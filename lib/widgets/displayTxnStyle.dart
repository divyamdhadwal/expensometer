import 'package:expensometer/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TxnStyle extends StatelessWidget {
  final int index;
  final List<Transaction> userTransactions;
  TxnStyle({this.index, this.userTransactions});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(
              color: Theme.of(context).primaryColorLight,
              width: 2,
            )),
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            child: Text(
              'INR ${userTransactions[index].price.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userTransactions[index].name,
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                DateFormat.yMMMMd()
                    .add_jm()
                    .format(userTransactions[index].txnDate),
                style: Theme.of(context).textTheme.headline1,
              )
            ],
          )
        ],
      ),
    );
  }
}
