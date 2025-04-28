// import 'package:artemis_acps/classes/artemis_acps_kiosk_class.dart';
// import 'package:artemis_acps/classes/artemis_kiosk_device_class.dart';
// import 'package:artemis_acps/status_managers.dart';
// import 'package:artemis_acps/widgets/device_list_status_widget.dart';
// import 'package:artemis_acps/widgets/kiosk_status_widget.dart';
// import 'package:artemis_acps/widgets/socket_status_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:signalr_netcore/hub_connection.dart';
//
// void main() {
//   final manager = StatusManager();
//
//   // Simulating socket events
//   Future.delayed(const Duration(seconds: 2), () {
//     manager.socketStatus.update(HubConnectionState.Connected);
//     manager.kioskStatus.update(ArtemisAcpsKiosk(
//       deviceId: "KIOSK123",
//       online: true,
//       devices: [
//         ArtemisKioskDevice(deviceName: "Blood Pressure", status: "ok", type: 1),
//         ArtemisKioskDevice(deviceName: "Temperature", status: "warning", type: 2),
//       ],
//     ));
//     manager.deviceStatus.updateDevices([
//       ArtemisKioskDevice(deviceName: "Blood Pressure", status: "ok", type: 1),
//       ArtemisKioskDevice(deviceName: "Temperature", status: "warning", type: 2),
//     ]);
//   });
//
//   runApp(MyApp(manager));
// }
//
// class MyApp extends StatelessWidget {
//   final StatusManager manager;
//
//   const MyApp(this.manager, {Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: StatusProvider(
//         manager: manager,
//         child: Scaffold(
//           appBar: AppBar(title: const Text('Artemis ACPS Dashboard')),
//           body: SingleChildScrollView(
//             child: Column(
//               children: const [
//                 SizedBox(height: 20),
//                 SocketStatusIndicator(),
//                 SizedBox(height: 20),
//                 KioskStatusIndicator(),
//                 SizedBox(height: 20),
//                 DeviceList(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }