import 'package:artemis_acps/classes/artemis_acps_workstation_class.dart';
import 'package:artemis_acps/widgets/general_buttom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkstationSelectDialog extends StatelessWidget {
  final List<ArtemisAcpsWorkstation> workstations;

  const WorkstationSelectDialog({super.key, required this.workstations});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: Container(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
        child: ListView.separated(
          shrinkWrap: true,

          itemCount: workstations.length,
          itemBuilder: (BuildContext context, int index) {
            ArtemisAcpsWorkstation w = workstations[index];
            return Row(
              children: [
                Expanded(child: Text(w.workstationName)),
                GeneralButton(
                  label: "Connect",
                  onPressed: () {
                    Navigator.of(context).pop(w);
                  },
                  fontSize: 12,
                  height: 35,
                ),
              ],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        ),
      ),
    );
  }
}
