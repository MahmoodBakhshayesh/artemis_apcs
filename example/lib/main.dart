import 'dart:developer';

import 'package:artemis_acps/artemis_acps.dart';
import 'package:artemis_acps/classes/artemis_acps_bagtag_class.dart';
import 'package:artemis_acps/classes/artemis_acps_boarding_pass_class.dart';
import 'package:artemis_acps/classes/artemis_acps_workstation_class.dart';
import 'package:artemis_acps/widgets/general_buttom.dart';
import 'package:flutter/material.dart';

void main() {

  // runApp(ArtemisAcpsStatusProvider(child: MyApp()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ArtemisAcpsWorkstation> ws = [];
  List<ArtemisAcps> acpsList = [ArtemisAcps(airport: 'zzz', baseUrl: 'http://192.168.45.72:45457', airline: "zz"), ArtemisAcps(airport: 'zzz', baseUrl: 'http://192.168.45.72:45457', airline: "zz")];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text("")),
      body: Center(
        child: Column(
          children:
              acpsList
                  .map(
                    (acps) => Column(
                      children: [
                        // acps.getKioskWidget(),
                        // acps.getSocketStatusWidget(),
                        // acps.getKioskStatusWidget(),
                        // acps.getKioskDevicesWidget(filter: [],size: 35),
                        acps.getGeneralWidget(),
                        GeneralButton(
                          onPressed: () async {
                              ArtemisAcpsBoardingPass bp = ArtemisAcpsBoardingPass(name: "Mahmood BKH", title: "MR", seq: "1", fromCity: "YVR", toCity: "IST", classType: "E", passengerType: "ADL", seat: "2A", airlineCode: "ZZ", flightNumber: "1010", flightDate: DateTime.now(), std: "18:10", gate: '1', fromCityName: '', toCityName: '', airlineName: 'ZZ', artemisAcpsBoardingPassClass: '', referenceNo: '', baggageCount: 1, baggageWeight: 2, barcodeData: 'dadsad', btd: '');
                              ArtemisAcpsBagtag bt = ArtemisAcpsBagtag(tagNumber: '1001001001', sixDigitNumber: '001001', name: 'Mahmood bkh', referenceNo: '1234', airlineThreeDigitCode: '001', baggageCount: 1, baggageWeight: 10, weightUnit: 'KG', firstAirportCode: 'ZZZ', firstAirportName: 'ZZZ', lastArilineCode: 'ZZ', lastAirlineName: 'ZZ', lastFlightNumber: '1010', lastFlightDate: '07OCT', lastAirportCode: 'ZZZ', lastAirportName: 'ZZZ', lastClassType: 'E', lastclass: 'E');

                              // acps.controller.printApi(bpList: [bp],btList: [bt]);
                              final res = await acps.controller.printData(bpList: [bp],btList: [bt]);
                              log(res.isSuccessful.toString());
                          },
                          label: 'Print Data',
                        ),
                        TextButton(
                          onPressed: () async {
                              acps.controller.testAeaPrint(hasBp: true,hasBt: true);
                          },
                          child: Text("test print"),
                        ),
                        TextButton(
                          onPressed: () async {
                              String testBarcode ="bdcsprinterqr|kiosk|325a2328-5f72-45ba-aac4-18a4b35f92d3|3|https://testprintlayerapinew.abomis.com/ACPSHub|adf6624a-9f82-4e11-93af-f34ecca4fca1||";
                              acps.controller.connectWorkstationWithQr(testBarcode);
                          },
                          child: Text("connect qr"),
                        ),
                        TextButton(
                          onPressed: () async {
                              await acps.controller.disconnectSocket();
                          },
                          child: Text("Disconnect"),
                        ),
                        TextButton(
                          onPressed: () async {
                              await acps.controller.reconnectSocket();
                          },
                          child: Text("Reconnect"),
                        ),
                        Divider(),
                      ],
                    ),
                  )
                  .toList(),
        ),
        // child: Column(
        //   children: <Widget>[
        //
        //     OutlinedButton(
        //       onPressed: () {
        //         // ArtemisAcpsUtil.init(onKioskStatusChanged: (_) {}, onKioskChanged: (_) {}, onError: (_) {}, onReceiveData: (_) {}, onSocketStatusRefresh: (_) {}, baseUrl: "https://testprintlayerapinew.abomis.com", airport: "ZZZ");
        //       },
        //       child: Text("INIT "),
        //     ),
        //     OutlinedButton(
        //       onPressed: () async {
        //         // final wsl = await ArtemisAcpsUtil.getWorkstations();
        //         // ws = wsl;
        //         // setState(() {});
        //         // print(ws.length);
        //       },
        //       child: Text("GET WS"),
        //     ),
        //     OutlinedButton(
        //       onPressed: () async {
        //       },
        //       child: Text("GET WS"),
        //     ),
        //     Row(children: [
        //       Expanded(child: SocketStatusIndicator()),
        //       Expanded(child: KioskStatusStatusIndicator()),
        //       Expanded(child: KioskStatusIndicator()),
        //       Expanded(child: DeviceList()),
        //     ],),
        //     Expanded(
        //       child: ListView(
        //         children:
        //             ws
        //                 .map(
        //                   (w) => Container(
        //                     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        //                     decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
        //                     child: Row(
        //                       children: [
        //                         Expanded(child: Text(w.workstationName)),
        //                         Expanded(
        //                           flex: 3,
        //                           child: Row(
        //                             children: [
        //                               Expanded(
        //                                 child: OutlinedButton(
        //                                   onPressed: () {
        //                                     // ArtemisAcpsUtil.connectWorkstation(w);
        //                                   },
        //                                   child: Text("Connect"),
        //
        //                                 ),
        //                               ),
        //
        //                             ],
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 )
        //                 .toList(),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
