import './chart_bar.dart';
import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> data;
  Chart({this.data});
  List<Map<String, Object>> get groupedTxn {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalAmt = 0.0;
      for (var i = 0; i < data.length; i++) {
        if (data[i].txnDate.day == weekDay.day &&
            data[i].txnDate.month == weekDay.month &&
            data[i].txnDate.year == weekDay.year) {
          totalAmt += data[i].price;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 2),
        'amount': totalAmt
      };
    }).reversed.toList();
  }

  double get totWeekSpent {
    //fold method allows us to change a list to another type with a certain logic
    return groupedTxn.fold(0.0, (sum, currElement) {
      return sum + currElement['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(groupedTxn);
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 7,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTxn
              .map((currData) => Flexible(
                    fit: FlexFit.tight,
                    child: BarGraph(
                        dayLabel: currData['day'],
                        amountSpent: currData['amount'],
                        percentOfTotalSpent: totWeekSpent == 0
                            ? 0.0
                            : (currData['amount'] as double) / totWeekSpent),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
