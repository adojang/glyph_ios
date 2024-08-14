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
        body: const Center(
          child: Text('Hello, iPhone!', style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}