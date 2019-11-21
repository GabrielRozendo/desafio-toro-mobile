import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/subjects.dart';
import '../models/stock_history_model.dart';
import '../models/stock_model.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class StockBloc extends BlocBase {
  WebSocketChannel _channel;

  StreamSubscription _streamSubscription;
  final _dataController = BehaviorSubject<Map<String, Stock>>();
  Stream<Map<String, Stock>> get outData =>
      _dataController.stream.asBroadcastStream();

  Stream<List<Stock>> get outTopGainersStocks => outData.transform(_topGainers);
  Stream<List<Stock>> get outTopLosersStocks => outData.transform(_topLosers);
  Map<String, Stock> _stocks = Map();

  StockBloc() {
    try {
      _channel = IOWebSocketChannel.connect('ws://192.168.15.8:8080/quotes');
      if (_channel.sink == null)
        throw new Exception("Unable to connect to websocket! Sink is null!");
      _streamSubscription = _channel.stream.listen(newDataFromWebSocket);
    } catch (e) {
      print("Error on listen to channel: $e");
      _dataController.sink.addError(e);
    }
  }

  void newDataFromWebSocket(dynamic jsonData) {
    final stockHistory = StockHistory(jsonData);
    final ticker = stockHistory.ticker;

    if (_stocks.containsKey(ticker))
      _stocks[ticker].updatePrice(stockHistory);
    else
      _stocks[ticker] = Stock(stockHistory);

    _dataController.sink.add(_stocks);
  }

  final _topGainers =
      StreamTransformer<Map<String, Stock>, List<Stock>>.fromHandlers(
          handleData: (value, sink) {
    final list = value.values.toList()
      ..sort((s1, s2) => s2.percent.compareTo(s1.percent));
    sink.add(list.take(5).toList());
  });

  final _topLosers =
      StreamTransformer<Map<String, Stock>, List<Stock>>.fromHandlers(
          handleData: (value, sink) {
    final list = value.values.toList()
      ..sort((s1, s2) => s1.percent.compareTo(s2.percent));
    sink.add(list.take(5).toList());
  });

  @override
  void dispose() {
    _dataController.close();
    _streamSubscription.cancel();
  }
}
