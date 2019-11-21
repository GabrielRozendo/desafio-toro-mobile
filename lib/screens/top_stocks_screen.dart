// import 'package:bezier_chart/bezier_chart.dart';
// import 'package:fl_animated_linechart/fl_animated_linechart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import '../models/stock_model.dart';

class TopStocksScreen extends StatelessWidget {
  final Stream stream;
  final String title;
  final Image bgImage;

  TopStocksScreen(
    this.stream,
    this.title,
    this.bgImage,
  );

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: EdgeInsets.all(0),
              title: Text(this.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  )),
              background: bgImage),
          expandedHeight: 100,
          floating: true,
          pinned: false,
          snap: true,
        ),
        stocksList(context),
      ]),
    );
  }

  Widget stocksList(BuildContext context) {
    return StreamBuilder(
        stream: this.stream,
        builder: (context, snapshot) {
          return SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (snapshot.hasError) return showError(context);
              if (!snapshot.hasData)
                return const Center(child: CircularProgressIndicator());

              return stockItem(context, snapshot.data[index]);
            },
            childCount: snapshot.hasData ? snapshot.data.length : 0,
          ));
        });
  }

  Widget showError(BuildContext context) {
    final errorWidget = Column(
      children: <Widget>[
        Icon(
          Icons.error_outline,
          color: Theme.of(context).errorColor,
        ),
        const Text('Não foi possível carregar as informações do servidor!'),
        const Text('Verifique a conexão e tente novamente.')
      ],
    );

    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: errorWidget,
        duration: Duration(seconds: 10),
      ),
    );

    return Center(child: errorWidget);
  }

  Widget stockItem(BuildContext context, Stock stock) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  stockTicker(stock.ticker),
                  stockCurrentPrice(stock.currentPriceReais),
                  stockDifference(stock),
                ]),
            // stockGraph2(context, stock)
            // stockGraph(stock)
            stockGraph3(stock)
          ],
        ),
      ),
    );
  }

  Widget stockTicker(String ticker) {
    return Text(ticker, style: TextStyle(fontWeight: FontWeight.bold));
  }

  Widget stockCurrentPrice(String price) {
    return Text(price);
  }

  Widget stockDifference(Stock stock) {
    final isPositive = stock.percent > 0;
    final textStyle = TextStyle(fontSize: 10, color: Colors.white);

    final children = stock.currentPrice > 0
        ? [
            Padding(
              padding: EdgeInsets.only(left: 4),
              child: Text(
                isPositive ? '+' : '-',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    stock.getDifference(showSignal: false),
                    style: textStyle,
                  ),
                  Text(
                    stock.getPercentage(showSignal: false),
                    style: textStyle,
                  ),
                ]),
          ]
        : [Container()];

    return Container(
      color: isPositive ? Colors.green : Colors.red,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: children),
    );
  }

  // Widget stockGraph(Stock stock) {
  //   final Map<DateTime, double> serie = Map.fromIterable(
  //     stock.timeline,
  //     key: (item) => item.timestamp,
  //     value: (item) => item.price,
  //   );
  //   final color = stock.percent > 0 ? Colors.green : Colors.red;
  //   LineChart lineChart = LineChart.fromDateTimeMaps([serie], [color], ['R\$']);

  //   return Container(
  //     color: Colors.yellow,
  //     height: 300,
  //     child: Row(children: <Widget>[
  //       Expanded(
  //         child: AnimatedLineChart(lineChart),
  //       ),
  //     ]),
  //   );
  // }

  // Widget stockGraph2(BuildContext context, Stock stock) {
  //   final List<DataPoint> data = stock.timeline
  //       .map((stockHistory) => DataPoint<DateTime>(
  //             value: stockHistory.price,
  //             xAxis: stockHistory.timestamp,
  //           ))
  //       .toList();

  //   final series = [
  //     BezierLine(lineColor: Theme.of(context).primaryColor, data: data)
  //   ];

  //   final now = DateTime.now();

  //   return Container(
  //     color: Colors.grey[700],
  //     height: 100, //MediaQuery.of(context).size.height / 2,
  //     width: MediaQuery.of(context).size.width * 0.9,
  //     child: BezierChart(
  //       bezierChartScale: BezierChartScale.HOURLY,
  //       fromDate: DateTime(now.year, now.month, now.day, 8, 0, 0),
  //       toDate: DateTime(now.year, now.month, now.day, 18, 0, 0),
  //       series: series,
  //       config: BezierChartConfig(
  //         verticalIndicatorStrokeWidth: 3.0,
  //         verticalIndicatorColor: Colors.black,
  //         // bubbleIndicatorColor: Theme.of(context).primaryColorDark,
  //         bubbleIndicatorTitleStyle: TextStyle(color: Colors.black),
  //         verticalIndicatorFixedPosition: false,
  //         bubbleIndicatorLabelStyle: TextStyle(color: Colors.black),
  //         bubbleIndicatorValueStyle: TextStyle(color: Colors.black),
  //         displayDataPointWhenNoValue: true,

  //         displayYAxis: true,
  //         showDataPoints: true,
  //         showVerticalIndicator: false,
  //         backgroundColor: Colors.transparent,
  //         snap: true,
  //       ),
  //     ),
  //   );
  // }

  Widget stockGraph3(Stock stock) {
    final List<double> data =
        stock.timeline.map((stockHistory) => stockHistory.price).toList();

    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Container(
        color: Colors.transparent,
        height: 50,
        child: Sparkline(
          data: data,
          pointsMode: PointsMode.all,
          pointSize: 4.0,
          pointColor: Colors.amber,
        ),
      ),
    );
  }
}
