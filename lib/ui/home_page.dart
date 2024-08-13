import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bluetooth_gate_control/bluetooth_service.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Gate Control'),
      ),
      body: Consumer<BluetoothService>(
        builder: (context, bluetoothService, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: bluetoothService.startScan,
                  child: Text('Scan for Devices'),
                ),
                SizedBox(height: 20),
                Switch(
                  value: bluetoothService.isConnected,
                  onChanged: (value) => bluetoothService.toggleConnection(),
                ),
                Text(bluetoothService.isConnected ? 'Connected' : 'Disconnected'),
                if (bluetoothService.isScanning)
                  CircularProgressIndicator(),
              ],
            ),
          );
        },
      ),
    );
  }
}