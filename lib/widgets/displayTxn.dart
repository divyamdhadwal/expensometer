//import './displayTxnStyle.dart';
import './txnStyleTile.dart';
import '../models/transaction.dart';
import 'package:flutter/material.dart';

class DisplayTxn extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function removeTransaction;
  DisplayTxn({this.userTransactions, this.removeTransaction});
  @override
  Widget build(BuildContext context) {
    return userTransactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'You have not added anything yet',
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset('./assets/images/waiting.png',
                        fit: BoxFit.cover)),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) {
              // return TxnStyle(
              //     index: index, userTransactions: userTransactions);
              return AllTransactionsInTile(
                  userTransaction: userTransactions[index],
                  removeTransaction: removeTransaction);
            },
            itemCount: userTransactions.length,
          );
  }
}
