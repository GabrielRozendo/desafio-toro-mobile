import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import '../blocs/stocks_bloc.dart';
import 'home_screen.dart';
import 'top_gainers_stocks_screen.dart';
import 'top_losers_stocks_screen.dart';

class TabScreen extends StatelessWidget {
  final StockBloc _stockBloc;
  TabScreen() : _stockBloc = StockBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StockBloc>(
      bloc: _stockBloc,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: appBar(),
          body: TabBarView(
            children: <Widget>[
              HomeScreen(),
              TopGainersStocksScreen(),
              TopLosersStocksScreen()
            ],
          ),
          bottomNavigationBar: TabBar(
              tabs: <Widget>[
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.trending_up)),
                Tab(icon: Icon(Icons.trending_down))
              ],
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.all(5),
              indicatorColor: Theme.of(context).accentColor),
        ),
      ),
    );
  }

  Widget appBar() {
    return AppBar(
      title: Image.asset('assets/images/toro_logo.png'),
    );
  }
}
