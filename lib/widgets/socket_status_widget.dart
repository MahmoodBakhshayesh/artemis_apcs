// import 'package:flutter/material.dart';
//
// import '../providers/artemis_acps_status_provider.dart';
// import '../status_managers.dart';
//
// class SocketStatusIndicator extends StatelessWidget {
//   const SocketStatusIndicator({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final socketStatus = ArtemisAcpsStatusProvider.of(context);
//     print("socketStatus ${socketStatus.socketConnected}");
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(
//           socketStatus.socketConnected ? Icons.wifi : Icons.wifi_off,
//           color: socketStatus.socketConnected ? Colors.green : Colors.red,
//         ),
//         const SizedBox(width: 8),
//         Text(socketStatus.socketConnected ? "Connected" : "Disconnected"),
//       ],
//     );
//   }
// }