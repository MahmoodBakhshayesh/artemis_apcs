// import 'package:flutter/material.dart';
//
// import '../providers/artemis_acps_status_provider.dart';
// import '../status_managers.dart';
//
// class DeviceList extends StatelessWidget {
//   const DeviceList({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final deviceManager = ArtemisAcpsStatusProvider.of(context);
//
//     return Row(
//       spacing: 1,
//       children:deviceManager.devices.map((a)=> Image.asset(a.img,package: 'artemis_acps',width: 40,height: 35,)).toList()
//     );
//   }
//
//   Color _getDeviceStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'ok':
//         return Colors.green;
//       case 'warning':
//         return Colors.orange;
//       case 'error':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }
// }
