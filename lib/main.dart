// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:bluetooth_gate_control/bluetooth_service.dart';
// import 'package:bluetooth_gate_control/ui/home_page.dart';
// import 'package:bluetooth_gate_control/ui/theme.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => BluetoothService(),
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Bluetooth Gate Control',
//       theme: appTheme,
//       home: HomePage(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Test App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getPlatformGreeting(),
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // This is where you'd put your Bluetooth logic for iOS
                  print('Button pressed!');
                },
                child: const Text('Test Button'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getPlatformGreeting() {
    if (kIsWeb) {
      return 'Hello, Chrome!';
    } else if (Platform.isIOS) {
      return 'Hello, iPhone!';
    } else {
      return 'Hello, Other Platform!';
    }
  }
}