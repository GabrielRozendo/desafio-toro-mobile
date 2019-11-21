import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import '../blocs/stocks_bloc.dart';
import 'top_stocks_screen.dart';

class TopGainersStocksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _stockBloc = BlocProvider.of<StockBloc>(context);
    return BlocProvider<StockBloc>(
      bloc: _stockBloc,
      child: TopStocksScreen(
        _stockBloc.outTopGainersStocks,
        "MAIORES ALTAS",
        Image.network(
          'https://cdn4.iconfinder.com/data/icons/finance-vol-2-3/32/finance_statics_stock_market_position_up_down_1-512.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
