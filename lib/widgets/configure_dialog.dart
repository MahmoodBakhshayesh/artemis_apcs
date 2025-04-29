import 'package:artemis_acps/artemis_acps_contoller.dart';
import 'package:artemis_acps/classes/artemis_acps_workstation_class.dart';
import 'package:artemis_acps/widgets/general_buttom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConfigureDialog extends StatefulWidget {
  final ArtemisAcpsController controller;

  const ConfigureDialog({super.key, required this.controller});

  @override
  State<ConfigureDialog> createState() => _ConfigureDialogState();
}

class _ConfigureDialogState extends State<ConfigureDialog> {
  TextEditingController airportC = TextEditingController();

  @override
  void initState() {
    airportC.text = widget.controller.airport;
    airportC.addListener((){
      setState((){});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return CupertinoAlertDialog(
      content: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 12,
              children: [
                Expanded(child: CupertinoTextField(controller: airportC, inputFormatters: [UpperCaseTextFormatter(),],maxLength: 3,)),
                GeneralButton(
                  label: "Submit",
                  onPressed:airportC.text.length!=3?null: () {
                    widget.controller.reconfigure(newAirline: widget.controller.airline, newAirport: airportC.text, newBaseUrl: widget.controller.baseUrl);
                    Navigator.of(context).pop();
                  },
                  height: 35,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
}
