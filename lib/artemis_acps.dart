import 'package:artemis_acps/classes/artemis_acps_kiosk_class.dart';
import 'package:artemis_acps/classes/artemis_acps_workstation_class.dart';
import 'package:artemis_acps/classes/artemis_kiosk_device_class.dart';
import 'package:artemis_acps/classes/artemis_kiosk_status_class.dart';
import 'package:artemis_acps/classes/general_button_style_class.dart';
import 'package:artemis_acps/widgets/configure_dialog.dart';
import 'package:artemis_acps/widgets/general_buttom.dart';
import 'package:artemis_acps/widgets/workstation_select_dialog.dart';
import 'package:flutter/material.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'artemis_acps_contoller.dart';

class ArtemisAcps {
  late final ArtemisAcpsController _controller;
  final GeneralButtonStyle? buttonStyle;

  ArtemisAcps({required String baseUrl, required String airport, required String airline, ArtemisAcpsController? controller, bool locked = false, this.buttonStyle}) {
    _controller = controller ?? ArtemisAcpsController(baseUrl: baseUrl, airport: airport, airline: airline, locked: locked);
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

  Widget getKioskDevicesWidget({List<String> filter = const [], List<String> statusFilters = const [], double? size}) {
    return _KioskDevicesWidget(controller: _controller, filters: filter,statusFilters:statusFilters, size: size ?? 30);
  }

  Widget getGeneralWidget({
    List<String> filter = const [],
    List<String> statusFilters = const [],
    double? size,
    Widget Function(ArtemisAcpsController controller, ArtemisAcpsWorkstation? worksation)? workstationWidgetBuilder,
    Widget Function(ArtemisAcpsController controller, ArtemisAcpsWorkstation? worksation, HubConnectionState socketState)? socketWidgetBuilder,
    Widget Function(ArtemisAcpsController controller, ArtemisAcpsWorkstation? worksation, HubConnectionState socketState, ArtemisAcpsKioskStatus? kioskStatus)? kioskWidgetBuilder,
    Widget Function(ArtemisAcpsController controller, ArtemisAcpsWorkstation? worksation, HubConnectionState socketState, ArtemisAcpsKioskStatus? kioskStatus, List<ArtemisKioskDevice> devices)? generalWidgetBuilder,
  }) {
    return _GeneralWidget(
      controller: _controller,
      filters: filter,
      statusFilters: statusFilters,
      size: size ?? 30,
      generalButtonStyle: buttonStyle,
      workstationWidgetBuilder: workstationWidgetBuilder,
      socketWidgetBuilder: socketWidgetBuilder,
      kioskWidgetBuilder: kioskWidgetBuilder,
      generalWidgetBuilder: generalWidgetBuilder,
    );
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
  final List<String> statusFilters;
  final double size;
  final ArtemisAcpsController controller;

  const _KioskDevicesWidget({required this.controller, required this.filters, required this.statusFilters, required this.size});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<ArtemisKioskDevice>>(
      valueListenable: controller.devices,
      builder: (context, value, child) {
        if (value.isEmpty) return SizedBox();
        return Row(
          spacing: 1,
          mainAxisSize: MainAxisSize.min,
          children: value.where((b)=>statusFilters.isEmpty || statusFilters.contains(b.status)).where((a) => filters.isEmpty || filters.map((f) => f.toLowerCase()).contains(a.getType.toLowerCase())).map((a) => Image.asset(a.img, width: size, package: 'artemis_acps')).toList(),
        );
      },
    );
  }
}

class _GeneralWidget extends StatelessWidget {
  final List<String> filters;
  final List<String> statusFilters;
  final double size;
  final ArtemisAcpsController controller;
  final GeneralButtonStyle? generalButtonStyle;
  final Widget Function(ArtemisAcpsController controller, ArtemisAcpsWorkstation? worksation)? workstationWidgetBuilder;
  final Widget Function(ArtemisAcpsController controller, ArtemisAcpsWorkstation? worksation, HubConnectionState socketState)? socketWidgetBuilder;
  final Widget Function(ArtemisAcpsController controller, ArtemisAcpsWorkstation? worksation, HubConnectionState socketState, ArtemisAcpsKioskStatus? kioskStatus)? kioskWidgetBuilder;
  final Widget Function(ArtemisAcpsController controller, ArtemisAcpsWorkstation? worksation, HubConnectionState socketState, ArtemisAcpsKioskStatus? kioskStatus, List<ArtemisKioskDevice> devices)? generalWidgetBuilder;

  const _GeneralWidget({required this.controller, required this.filters,required this.statusFilters, required this.size, this.generalButtonStyle, this.workstationWidgetBuilder, this.socketWidgetBuilder, this.kioskWidgetBuilder, this.generalWidgetBuilder});

  @override
  Widget build(BuildContext context) {
    var buttonStyle = generalButtonStyle ?? GeneralButtonStyle(borderRadius: BorderRadius.circular(8), foregroundColor: Colors.white, backgroundColor: Colors.blueAccent);
    return ValueListenableBuilder<String>(
      valueListenable: controller.station,
      builder: (context, station, child) {
        return ValueListenableBuilder<ArtemisAcpsWorkstation?>(
          valueListenable: controller.workstation,
          builder: (context, workstation, child) {
            if (workstation == null) {
              if (workstationWidgetBuilder != null) {
                return workstationWidgetBuilder!(controller, workstation);
              }
              return GeneralButton(
                onLongPress:
                    controller.locked
                        ? null
                        : () {
                          controller.configureAcps(context);
                        },
                height: buttonStyle.height ?? size,
                label: "Select Workstation (${station.toUpperCase()})",
                borderRadius: buttonStyle.borderRadius,
                color: buttonStyle.backgroundColor,
                textColor: buttonStyle.foregroundColor,
                icon: buttonStyle.icon,
                fontSize: buttonStyle.fontSize,
                fontWeight: buttonStyle.fontWeight,
                onPressed: () async {
                  await controller.selectWorkstation(context);
                  // final selected = await showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return WorkstationSelectDialog(workstations: ws);
                  //   },
                  // );
                  // if (selected is ArtemisAcpsWorkstation) {
                  //   controller.connectWorkstation(selected);
                  // }
                },
              );
            }
            return GestureDetector(
              onLongPress: () {
                controller.disconnect();
              },
              child: ValueListenableBuilder<HubConnectionState>(
                valueListenable: controller.socketStatus,
                builder: (context, socket, child) {
                  if (socket == HubConnectionState.Connected) {
                    return ValueListenableBuilder<ArtemisAcpsKioskStatus?>(
                      valueListenable: controller.kioskStatus,
                      builder: (context, kioskStatus, child) {
                        if (kioskStatus != null && kioskStatus.isOnline) {
                          if (generalWidgetBuilder != null) {
                            return generalWidgetBuilder!(controller, workstation, socket, kioskStatus, controller.devices.value);
                          }
                          return Container(
                            height: size,
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(border: Border.all(color: Color(0xff00cf37)), borderRadius: BorderRadius.circular(8)),
                            child: Stack(children: [_KioskDevicesWidget(controller: controller, filters: filters, statusFilters:statusFilters,size: size - 2)]),
                          );
                        }
                        if (kioskWidgetBuilder != null) {
                          return kioskWidgetBuilder!(controller, workstation, socket, kioskStatus);
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
                  if (socketWidgetBuilder != null) {
                    return socketWidgetBuilder!(controller, workstation, socket);
                  }
                  return GestureDetector(
                    onTap: () {
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
