import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
      final title = _titleController.text;
      final value = double.tryParse(_valueController.text) ?? 0.0;

      if (title.isEmpty || value <= 0 || _selectedDate == null) {
        return;
      }
      widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
        context: context,
        firstDate: DateTime(2025),
        initialDate: DateTime.now(),
        lastDate: DateTime.now()
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
      _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 20
      )
    );
    final ButtonStyle textButtonStyle =
    ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.primary

    );
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
                controller: _titleController,
                // Usa se _ quando se quer ignorar o parâmetro.
                onSubmitted: (_) => _submitForm(),
                decoration: InputDecoration(labelText: 'Título')),
            TextField(
                controller: _valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                decoration: InputDecoration(labelText: 'Valor (R\$)')),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                        _selectedDate == null ? 'Nenhuma data selecionada!'
                    : 'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate!)}'),
                  ),
                  TextButton(
                    style: textButtonStyle,
                      onPressed: _showDatePicker,
                      child: Text('Selecionar Data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    style: style,
                    onPressed: _submitForm,
                    child: Text('Nova Transação')
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
