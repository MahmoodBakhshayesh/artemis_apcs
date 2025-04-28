// import 'package:flutter/material.dart';
//
// import '../providers/artemis_acps_status_provider.dart';
// import '../status_managers.dart';
//
// class KioskStatusIndicator extends StatelessWidget {
//   const KioskStatusIndicator({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final kioskStatus = ArtemisAcpsStatusProvider.of(context);
//
//     return Builder(
//       builder: (context) {
//         final kiosk = kioskStatus.kiosk;
//         if (kiosk == null) return const Text('No Kiosk Connected');
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               kiosk.online ? Icons.cloud_done : Icons.cloud_off,
//               color: kiosk.online ? Colors.green : Colors.red,
//             ),
//             const SizedBox(width: 8),
//           ],
//         );
//       },
//     );
//   }
// }
