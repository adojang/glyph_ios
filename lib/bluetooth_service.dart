import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logging/logging.dart';

class BluetoothService extends ChangeNotifier {
  final Logger _logger = Logger('BluetoothService');
  bool isScanning = false;
  bool isConnected = false;
  BluetoothDevice? targetDevice;
  String? savedDeviceId;

  BluetoothService() {
    _loadSavedDevice();
    _initBluetoothState();
  }

  void _initBluetoothState() {
    FlutterBluePlus.adapterState.listen((state) {
      if (state == BluetoothAdapterState.on) {
        _tryConnectSavedDevice();
      } else {
        disconnect();
      }
      notifyListeners();
    });
  }

  Future<void> _loadSavedDevice() async {
    final prefs = await SharedPreferences.getInstance();
    savedDeviceId = prefs.getString('saved_device_id');
  }

  Future<void> _saveDevice(String deviceId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_device_id', deviceId);
    savedDeviceId = deviceId;
  }

  Future<void> _tryConnectSavedDevice() async {
    if (savedDeviceId != null) {
      try {
        final deviceId = DeviceIdentifier(savedDeviceId!);
        targetDevice = BluetoothDevice(remoteId: deviceId);
        
        bool isConnected = targetDevice!.isConnected;
        if (!isConnected) {
          await targetDevice!.connect();
        }
        
        this.isConnected = true;
        notifyListeners();
      } catch (e) {
        _logger.warning('Failed to connect to saved device: $e');
        targetDevice = null;
      }
    }
  }

  Future<void> startScan() async {
    if (isScanning) return;
    isScanning = true;
    notifyListeners();

    try {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));

      FlutterBluePlus.scanResults.listen((results) {
        for (ScanResult r in results) {
          if (r.device.platformName == "Charles") {
            targetDevice = r.device;
            connect();
            FlutterBluePlus.stopScan();
            break;
          }
        }
      });

      await Future.delayed(const Duration(seconds: 4));
    } catch (e) {
      _logger.warning('Error during scan: $e');
    } finally {
      isScanning = false;
      notifyListeners();
    }
  }

  Future<void> connect() async {
    if (targetDevice == null) return;
    try {
      await targetDevice!.connect();
      isConnected = true;
      await _saveDevice(targetDevice!.remoteId.str);
      notifyListeners();
    } catch (e) {
      _logger.warning('Failed to connect: $e');
    }
  }

  Future<void> disconnect() async {
    if (targetDevice != null) {
      try {
        await targetDevice!.disconnect();
      } catch (e) {
        _logger.warning('Failed to disconnect: $e');
      }
    }
    isConnected = false;
    notifyListeners();
  }

  void toggleConnection() {
    if (isConnected) {
      disconnect();
    } else {
      startScan();
    }
  }

  Future<void> clearSavedDevice() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('saved_device_id');
    savedDeviceId = null;
    notifyListeners();
  }
}