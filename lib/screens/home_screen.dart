import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:toro_investimentos/blocs/stocks_bloc.dart';
import 'package:toro_investimentos/models/stock_model.dart';
import 'package:toro_investimentos/utils/date_utils.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _stockBloc = BlocProvider.of<StockBloc>(context);

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
              // Expanded(
              // child:
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  DateUtils.durationInString(stock.lastUpdate),
                  style: TextStyle(fontSize: 7, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.right,
                ),
              ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
