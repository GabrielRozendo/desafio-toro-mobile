import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import '../blocs/stocks_bloc.dart';
import '../models/stock_model.dart';
import '../utils/date_utils.dart';

class HomeScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _stockBloc = BlocProvider.of<StockBloc>(context);

    if (_stockBloc.hasError || _stockBloc.isEmpty == null || _stockBloc.isEmpty)
      return Scaffold(key: _scaffoldKey, body: showError(context));

    return Scaffold(
      body: StreamBuilder(
          stream: _stockBloc.outData,
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text('Error');
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());

            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.1,
                ),
                itemCount: snapshot.data.length,
                padding: EdgeInsets.all(4),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return gridItem(
                      context, snapshot.data.values.toList()[index]);
                });
          }),
    );
  }

  Widget showError(BuildContext context) {
    final errorWidget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.error_outline,
          size: 30,
          color: Theme.of(context).errorColor,
        ),
        SizedBox(
          height: 30,
        ),
        const Text(
          'Não foi possível carregar as informações do servidor!',
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),
        const Text(
          'Verifique a conexão e tente novamente.',
          textAlign: TextAlign.center,
        )
      ],
    );
    // _scaffoldKey.currentState.showSnackBar(
    //   SnackBar(
    //     backgroundColor: Theme.of(context).errorColor,
    //     content: Text('Não foi possível carregar as informações do servidor!'),
    //     duration: Duration(seconds: 10),
    //   ),
    // );

    return Center(
        child: Padding(padding: EdgeInsets.all(12), child: errorWidget));
  }

  Widget gridItem(BuildContext context, Stock stock) {
    return Card(
      color: stock.percent == 0
          ? Colors.white.withOpacity(.8)
          : stock.percent < 0 ? Colors.red : Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: GridTile(
          child: Column(
            children: <Widget>[
              Text(
                stock.ticker,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: stock.percent == 0
                        ? Theme.of(context).primaryColor
                        : Colors.white),
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  stock.currentPriceReais,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: stock.percent == 0 ? Colors.black : Colors.white),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      stock.getDifference(),
                      style: TextStyle(
                          fontSize: 8,
                          fontStyle: FontStyle.italic,
                          color:
                              stock.percent == 0 ? Colors.black : Colors.white),
                    ),
                    Text(
                      stock.getPercentage(),
                      style: TextStyle(
                          fontSize: 8,
                          fontStyle: FontStyle.italic,
                          color:
                              stock.percent == 0 ? Colors.black : Colors.white),
                    )
                  ]),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  DateUtils.durationInString(stock.lastUpdate),
                  style: TextStyle(fontSize: 7, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
