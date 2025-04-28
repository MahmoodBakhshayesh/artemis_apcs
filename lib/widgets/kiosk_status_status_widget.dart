// import 'package:artemis_acps/notifier.dart';
// import 'package:flutter/material.dart';
//
// import '../providers/artemis_acps_status_provider.dart';
// import '../status_managers.dart';
//
// class KioskStatusStatusIndicator extends StatelessWidget {
//   const KioskStatusStatusIndicator({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final kiosk = ArtemisAcpsStatusProvider.of(context).kioskStatus;
//     if(kiosk == null) return SizedBox();
//     print("kioskStatusStatus ${kiosk.isOnline}");
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(
//           kiosk.isOnline ? Icons.cloud_done : Icons.cloud_off,
//           color: kiosk.isOnline ? Colors.green : Colors.red,
//         ),
//         const SizedBox(width: 8),
//         Text(kiosk.message),
//       ],
//     );
//     // return AnimatedBuilder(
//     //   animation: kioskStatus,
//     //   builder: (context, _) {
//     //     final kiosk = kioskStatus.kiosk;
//     //     if (kiosk == null) return const Text('No Kiosk Connected');
//     //
//     //     Row(
//     //       mainAxisAlignment: MainAxisAlignment.center,
//     //       children: [
//     //         Icon(
//     //           kiosk.isOnline ? Icons.cloud_done : Icons.cloud_off,
//     //           color: kiosk.isOnline ? Colors.green : Colors.red,
//     //         ),
//     //         const SizedBox(width: 8),
//     //         Text(kiosk.message),
//     //       ],
//     //     );
//     //   },
//     // );
//   }
// }
