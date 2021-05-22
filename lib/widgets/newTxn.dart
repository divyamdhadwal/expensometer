import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  //Variables to store data from textfields.
  //They'll always be Strings. Would have to convert later on.
  // String nameInput;
  // String priceInput;

  //OR

  final Function addTransaction;

  NewTransaction({this.addTransaction});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  DateTime _selectedDate;

  void _validateTxn() {
    final String _txName = _nameController.text;
    final double _txPrice = double.parse(_priceController.text);
    if (_txName.isEmpty || _txPrice <= 0 || _selectedDate == null) {
      return;
    }
    // To access properties/methods of widget class inside the state class.
    widget.addTransaction(_txName, _txPrice, _selectedDate);
    //Close the top most screen.
    Navigator.of(context).pop();
  }

  void _showDateTimePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
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
    return SingleChildScrollView(
      child: Container(
        //height: MediaQuery.of(context).size.height * 1,
        child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: Column(
              //mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(labelText: 'Item name'),
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  onSubmitted: (_) =>
                      _validateTxn(), //onSubmitted returns the value the user entered.
                  //onChanged: (value) => nameInput = value,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Item price'),
                  controller: _priceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onSubmitted: (_) => _validateTxn(),
                  //onChanged: (value) => priceInput = value,
                ),
                SizedBox(height: 4),
                Container(
                  height: 45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_selectedDate == null
                          ? 'No date chosen !!'
                          : 'Date Chosen: ${DateFormat.yMMMd().format(_selectedDate)}'),
                      TextButton(
                        onPressed: _showDateTimePicker,
                        child: Text(
                          'Choose Date',
                        ),
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                    onPressed: _validateTxn,
                    child: Text('Add new Transaction'),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                        foregroundColor: MaterialStateProperty.all(
                            Theme.of(context).textTheme.button.color),
                        alignment: Alignment.center)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
