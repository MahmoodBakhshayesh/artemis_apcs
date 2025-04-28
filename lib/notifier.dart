import 'package:artemis_acps/status_managers.dart';
import 'package:flutter/cupertino.dart';

class StatusNotifier extends InheritedNotifier<RouteInfoNotifier> {
  const StatusNotifier._({
    super.key,
    super.notifier,
    required super.child,
  });

  factory StatusNotifier({Key? key, required Widget child}) {
    return StatusNotifier._(
      key: key,
      notifier: RouteInfoNotifier.instance,
      child: child,
    );
  }

  static StatusManager? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StatusNotifier>()?.notifier?.value;
  }

  @override
  bool updateShouldNotify(covariant InheritedNotifier<RouteInfoNotifier> oldWidget) {
    return true;
    return notifier?.value != oldWidget.notifier?.value;
  }

  static updateState({required StatusManager routeName}) {
    WidgetsBinding.instance.addPostFrameCallback((_){
      RouteInfoNotifier.instance.updateRoute(newRoute: routeName);
    });
  }
}

class RouteInfoNotifier extends ChangeNotifier {
  StatusManager value = StatusManager();

  RouteInfoNotifier._({required this.value});

  static final RouteInfoNotifier instance = RouteInfoNotifier._(value: StatusManager());

  void updateRoute({required StatusManager newRoute}) {
    if (value != newRoute) {
      value = newRoute;
      notifyListeners();
    }
  }
}
