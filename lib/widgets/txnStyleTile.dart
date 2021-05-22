import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AllTransactionsInTile extends StatelessWidget {
  final Transaction userTransaction;
  final Function removeTransaction;
  AllTransactionsInTile({this.userTransaction, this.removeTransaction});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        contentPadding: EdgeInsets.all(3),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColorLight,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text(
                '\u{20B9}${userTransaction.price.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        ),
        title: Text(
          userTransaction.name,
          style: Theme.of(context).textTheme.headline5,
        ),
        subtitle: Text(
          DateFormat.yMMMMd().add_jm().format(userTransaction.txnDate),
          style: Theme.of(context).textTheme.headline1,
        ),
        trailing: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: MediaQuery.of(context).size.width > 450
              ? TextButton.icon(
                  onPressed: () => removeTransaction(userTransaction.id),
                  label: Text('Delete'),
                  icon: Icon(Icons.delete),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(
                          Theme.of(context).errorColor)),
                )
              : IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () => removeTransaction(userTransaction.id),
                ),
        ),
        hoverColor: Color.fromRGBO(220, 220, 220, 1),
        selected: true,
        onTap: () {},
      ),
    );
  }
}
