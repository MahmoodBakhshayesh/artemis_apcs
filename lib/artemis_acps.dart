import 'package:artemis_acps/classes/artemis_acps_kiosk_class.dart';
import 'package:artemis_acps/classes/artemis_acps_workstation_class.dart';
import 'package:artemis_acps/classes/artemis_kiosk_device_class.dart';
import 'package:artemis_acps/classes/artemis_kiosk_status_class.dart';
import 'package:artemis_acps/widgets/configure_dialog.dart';
import 'package:artemis_acps/widgets/general_buttom.dart';
import 'package:artemis_acps/widgets/workstation_select_dialog.dart';
import 'package:flutter/material.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'artemis_acps_contoller.dart';

class ArtemisAcps {
  late final ArtemisAcpsController _controller;

  ArtemisAcps({required String baseUrl,required String  airport, required String  airline, ArtemisAcpsController? controller, bool locked =false}) {
    _controller = controller ?? ArtemisAcpsController(baseUrl: baseUrl, airport: airport, airline: airline,locked: locked);
  }

  Widget getSocketStatusWidget() {
    return _SocketStatusWidget(controller: _controller);
  }

  Widget getKioskStatusWidget() {
    return _KioskStatusWidget(controller: _controller);
  }

  Widget getKioskWidget() {
    return _KioskWidget(controller: _controller);
  }

  Widget getKioskDevicesWidget({List<String> filter = const [], double? size}) {
    return _KioskDevicesWidget(controller: _controller, filters: filter, size: size ?? 30);
  }

  Widget getGeneralWidget({List<String> filter = const [], double? size}) {
    return _GeneralWidget(controller: _controller, filters: filter, size: size ?? 30);
  }

  void reconfigure({required String newAirline, required String newAirport, required String newBaseUrl}) {
    _controller.reconfigure(newAirline: newAirline, newAirport: newAirport, newBaseUrl: newBaseUrl);
  }

  ArtemisAcpsController get controller => _controller;
}

class _SocketStatusWidget extends StatelessWidget {
  final ArtemisAcpsController controller;

  const _SocketStatusWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<HubConnectionState>(
      valueListenable: controller.socketStatus,
      builder: (context, value, child) {
        switch (value) {
          case HubConnectionState.Disconnected:
            return Icon(Icons.circle, color: Colors.red);
          case HubConnectionState.Connecting:
            return Icon(Icons.circle, color: Colors.orange);
          case HubConnectionState.Connected:
            return Icon(Icons.circle, color: Colors.green);
          case HubConnectionState.Disconnecting:
            return Icon(Icons.circle, color: Colors.yellow);
          case HubConnectionState.Reconnecting:
            return Icon(Icons.circle, color: Colors.yellow);
        }
      },
    );
  }
}

class _KioskStatusWidget extends StatelessWidget {
  final ArtemisAcpsController controller;

  const _KioskStatusWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ArtemisAcpsKioskStatus?>(
      valueListenable: controller.kioskStatus,
      builder: (context, value, child) {
        if (value == null) {
          return Text("No Kiosk");
        }
        if (value.isOnline) {
          return Text("Kiosk is Online", style: TextStyle(color: Colors.green));
        }
        if (!value.isOnline) {
          return Text("Kiosk is Offline", style: TextStyle(color: Colors.red));
        }
        return Text("Unknown");
      },
    );
  }
}

class _KioskWidget extends StatelessWidget {
  final ArtemisAcpsController controller;

  const _KioskWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ArtemisAcpsKiosk?>(
      valueListenable: controller.kiosk,
      builder: (context, value, child) {
        if (value == null) {
          return Text("No Kiosk");
        }
        return Text(value.deviceId);
      },
    );
  }
}

class _KioskDevicesWidget extends StatelessWidget {
  final List<String> filters;
  final double size;
  final ArtemisAcpsController controller;

  const _KioskDevicesWidget({required this.controller, required this.filters, required this.size});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<ArtemisKioskDevice>>(
      valueListenable: controller.devices,
      builder: (context, value, child) {
        if (value.isEmpty) return SizedBox();
        return Row(
          spacing: 1,
          mainAxisSize: MainAxisSize.min,
          children: value.where((a) => filters.isEmpty || filters.map((f) => f.toLowerCase()).contains(a.getType.toLowerCase())).map((a) => Image.asset(a.img, width: size, package: 'artemis_acps')).toList(),
        );
      },
    );
  }
}

class _GeneralWidget extends StatelessWidget {
  final List<String> filters;
  final double size;
  final ArtemisAcpsController controller;

  const _GeneralWidget({required this.controller, required this.filters, required this.size});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: controller.station,
      builder: (context, station, child) {

        return ValueListenableBuilder<ArtemisAcpsWorkstation?>(
          valueListenable: controller.workstation,
          builder: (context, workstation, child) {
            if (workstation == null) {
              return GeneralButton(
                onLongPress: controller.locked?null:(){
                  showDialog(context: context, builder: (BuildContext context) {
                    return ConfigureDialog(controller: controller);
                  });
                },
                height: size,
                label: "Select Workstation (${station.toUpperCase()})",
                radius: 8,
                onPressed: () async {
                  final ws = await controller.getWorkstations();
                  final selected = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return WorkstationSelectDialog(workstations: ws);
                    },
                  );
                  if (selected is ArtemisAcpsWorkstation) {
                    controller.connectWorkstation(selected);
                  }
                },

              );
            }
            return GestureDetector(
              onLongPress: (){
                controller.disconnectSocket();
                controller.updateWorkstation(null);
                controller.updateKiosk(null);
              },
              child: ValueListenableBuilder<HubConnectionState>(
                valueListenable: controller.socketStatus,
                builder: (context, socket, child) {
                  if (socket == HubConnectionState.Connected) {
                    return ValueListenableBuilder<ArtemisAcpsKioskStatus?>(
                      valueListenable: controller.kioskStatus,
                      builder: (context, kioskStatus, child) {
                        if (kioskStatus != null && kioskStatus.isOnline) {
                          return Container(
                            height: size,
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(border: Border.all(color: Color(0xff00cf37)), borderRadius: BorderRadius.circular(8)),
                            child: Stack(children: [_KioskDevicesWidget(controller: controller, filters: [], size: size - 2)]),
                          );
                        }
                        return Container(
                          height: size,
                          constraints: BoxConstraints(minWidth: 100),
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(border: Border.all(color: Colors.green), borderRadius: BorderRadius.circular(8)),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(height: size, child: Text(workstation.workstationName, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black38))),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.black12),
                                  padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                                  child: Text("Offline", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, height: 1)),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return GestureDetector(
                    onTap: (){
                      controller.reconnectSocket();
                    },
                    child: Container(
                      height: size,
                      constraints: BoxConstraints(minWidth: 100),
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(border: Border.all(color: socket == HubConnectionState.Disconnected ? Colors.red : Colors.orange), borderRadius: BorderRadius.circular(8)),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(height: size, child: Text(workstation.workstationName, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black38))),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.black12),
                              padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                              child: Text(socket.name, style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, height: 1)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );

  }
}
