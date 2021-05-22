import './widgets/chart.dart';
import './widgets/newTxn.dart';
import './widgets/displayTxn.dart';
import 'package:flutter/material.dart';
import 'models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App to manage your personal expenses',
      theme: ThemeData(
          //primarySwatch provides different shade of a color.
          primarySwatch: Colors.cyan,
          //accentColor provides an alernative color.
          accentColor: Colors.black,
          //Global font family.
          fontFamily: 'OpenSans',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                //color: Theme.of(context).primaryColorDark
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.normal,
                fontSize: 13,
              ),
              headline5: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800]),
              headline1: TextStyle(color: Colors.grey[600], fontSize: 10),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                      headline6: TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )))),
      home: HomePage(),
    );
  }
}

//Stateful element
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

//State Object
class _HomePageState extends State<HomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', name: 'New shoes', price: 1500, txnDate: DateTime.now()),
    Transaction(
        id: 't2', name: 'Room rent', price: 20000, txnDate: DateTime.now())
  ];

  bool _showChart = false;

  List<Transaction> get _recentData {
    return _userTransactions.where((txn) {
      return txn.txnDate.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addTransaction(String txName, double txPrice, DateTime selectedDate) {
    final newTxn = Transaction(
        id: DateTime.now().toString(),
        name: txName,
        price: txPrice,
        txnDate: selectedDate);

    setState(() {
      _userTransactions.add(newTxn);
    });
  }

  void _deleteTransaction(String idToDelete) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == idToDelete);
    });
  }

  void _startNewTxn(BuildContext ctx) {
    showModalBottomSheet(
        //To make this modal cover the whole page, uncomment ths
        //isScrollControlled: true,
        context: ctx,
        builder: (bctx) {
          return NewTransaction(addTransaction: _addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    //This is better practise
    //final mediaQuery = MediaQuery.of(context);
    final _isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text('Expensometer'),
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _startNewTxn(context);
            })
      ],
    );

    final _showTransactions = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.74,
      child: DisplayTxn(
          userTransactions: _userTransactions,
          removeTransaction: _deleteTransaction),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show Chart'),
                  Switch.adaptive(
                      activeColor: Theme.of(context).accentColor,
                      value:
                          _showChart, //_showChart is a boolean with def = false
                      onChanged: (value) {
                        setState(() {
                          _showChart = value;
                        });
                      }),
                ],
              ),
            if (!_isLandscape)
              Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.26,
                  child: Chart(data: _recentData)),
            if (!_isLandscape) _showTransactions,
            if (_isLandscape)
              _showChart
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: Chart(data: _recentData))
                  : _showTransactions,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _startNewTxn(context);
        },
      ),
    );
  }
}
