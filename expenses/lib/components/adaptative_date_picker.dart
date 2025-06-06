import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:universal_platform/universal_platform.dart';

class AdaptativeDatePicker extends StatelessWidget {

  final DateTime? selectedDate;
  final Function(DateTime)? onDateChanged;
  AdaptativeDatePicker({
    this.selectedDate,
    this.onDateChanged
});

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      firstDate: DateTime(2025),
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

     onDateChanged!(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle textButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.primary,
    );

    return UniversalPlatform.isIOS ?
        Container(
          height: 180,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now(),
            minimumDate: DateTime(2025),
            maximumDate: DateTime.now(),
            onDateTimeChanged: onDateChanged!,
          ),
        )
    : Container(
      height: 70,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              selectedDate == null
                  ? 'Nenhuma data selecionada!'
                  : 'Data Selecionada: ${DateFormat('dd/MM/y').format(selectedDate!)}',
            ),
          ),
          TextButton(
            style: textButtonStyle,
            onPressed: () => _showDatePicker(context),
            child: Text(
              'Selecionar Data',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
