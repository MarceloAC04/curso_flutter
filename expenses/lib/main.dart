import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:expenses/components/chart.dart';
import 'package:expenses/models/transaction.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:intl/intl.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  final ThemeData tema = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      // Tema geral da aplicação
      theme: ThemeData(
        useMaterial3: false,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          titleLarge: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: '1',
      title: "Internet",
      value: 33.00,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: '2',
      title: "Marmita Elétrica",
      value: 129.45,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: '',
      title: "O Silmarillion",
      value: 35.00,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransaction {
    return _transactions.where((tr) {
      return tr.date!.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  Widget _getIconButton(IconData icon, Function() fn) {
    return UniversalPlatform.isIOS
        ? GestureDetector(onTap: fn, child: Icon(icon))
        : IconButton(icon: Icon(icon), onPressed: fn);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final iconList = UniversalPlatform.isIOS ? CupertinoIcons.refresh : Icons.list;
    final chartList = UniversalPlatform.isIOS ? CupertinoIcons.refresh : Icons.show_chart;

    final actions = <Widget>[
      if (isLandscape)
        _getIconButton(
    _showChart ? iconList : chartList,
           () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
      _getIconButton(
    UniversalPlatform.isIOS ? CupertinoIcons.add : Icons.add,
    () => _openTransactionFormModal(context),
      ),
    ];

    final appBar = AppBar(
      title: Text(
        'Despesas Pessoais',
        style: TextStyle(
          fontSize: 10 * MediaQuery.textScalerOf(context).scale(2),
        ),
      ),
      actions: actions
    );
    final availabeHeight =
        mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // if (isLandscape)
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Text('Exibir Gráfico'),
            //     Switch(
            //       value: _showChart,
            //       onChanged: (value) {
            //         setState(() {
            //           _showChart = value;
            //         });
            //       },
            //     ),
            //   ],
            // ),
            if (_showChart || !isLandscape)
              Container(
                height: availabeHeight * (isLandscape ? 0.8 : 0.3),
                child: Chart(_recentTransaction),
              ),
            if (!_showChart || !isLandscape)
              Container(
                height: availabeHeight * (isLandscape ? 1 : 0.7),
                child: TransactionList(_transactions, _removeTransaction),
              ),
          ],
        ),
      ),
    );

    return UniversalPlatform.isIOS
        ? CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('Despesas Pessoais'),
            trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions
            ),
          ),
          child: bodyPage,
        )
        : Scaffold(
          appBar: appBar,
          body: bodyPage,
          floatingActionButton:
              UniversalPlatform.isIOS
                  ? Container()
                  : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _openTransactionFormModal(context),
                  ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
  }
}
