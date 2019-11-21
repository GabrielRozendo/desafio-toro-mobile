import 'package:intl/intl.dart';
import 'package:toro_investimentos/models/stock_history_model.dart';

class Stock {
  String ticker;
  double initialPrice;
  double _currentPrice;
  double get currentPrice => _currentPrice;
  String get currentPriceReais =>
      NumberFormat.currency(symbol: 'R\$').format(_currentPrice);
  double _difference;
  double _percent;
  double get percent => _percent;
  DateTime _lastUpdate;
  DateTime get lastUpdate => _lastUpdate;
  List<StockHistory> timeline;

  void updatePrice(StockHistory history) {
    timeline.add(history);
    _currentPrice = history.price;
    _lastUpdate = history.timestamp;
    if (_currentPrice == 0)
      _difference = _percent = 0;
    else {
      _difference = _currentPrice - initialPrice;
      _percent = calcPercent(initialPrice, _currentPrice);
    }
  }

  static double calcPercent(double initialPrice, double currentPrice) {
    if (initialPrice == 0) return 0;
    return (currentPrice - initialPrice) * 100 / initialPrice;
  }

  Stock(StockHistory history) {
    ticker = history.ticker;
    initialPrice = history.price;
    _currentPrice = initialPrice;
    _lastUpdate = history.timestamp;
    _percent = _difference = 0;
    timeline = [history];
  }

  String getDifference({bool showSignal = true}) {
    if (_difference == 0) return '';
    if (showSignal) {
      final signal = _difference > 0 ? '+' : '';
      return '$signal${_difference.toStringAsFixed(2)}';
    }
    return _difference.toStringAsFixed(2).replaceAll('-', '');
  }

  String getPercentage({bool showSignal = true}) {
    if (_percent == 0) return '';
    if (showSignal) {
      final signal = _percent > 0 ? '+' : '';
      return '$signal${_percent.toStringAsFixed(2)}%';
    }
    return '${_percent.toStringAsFixed(2).replaceAll("-", "")}%';
  }
}
