import 'package:flutter_test/flutter_test.dart';
import 'package:toro_investimentos/models/stock_history_model.dart';
import 'package:toro_investimentos/models/stock_model.dart';

void main() {
  group('Stock', () {
    test('Value should start at first history', () {
      final stockHistory =
          StockHistory('{"SUZB3": 1.23, "timestamp": 1574178178.748371}');
      final stock = Stock(stockHistory);
      expect(stock.currentPrice, 1.23);
    });

    test('Percent should start at 0%', () {
      final stockHistory =
          StockHistory('{"SUZB3": 1.23, "timestamp": 1574178178.748371}');
      final stock = Stock(stockHistory);
      expect(stock.percent, 0);
    });

    test('Value should be 100', () {
      final stockHistory =
          StockHistory('{"SUZB3": 1.0, "timestamp": 1574178178.748371}');
      final stock = Stock(stockHistory);
      final stockHistory2 =
          StockHistory('{"SUZB3": 2.0, "timestamp": 1574178178.748371}');
      stock.updatePrice(stockHistory2);

      expect(stock.percent, 100);
    });

    test('Value currentPrice should be the last one 47.94', () {
      final stockHistory1 =
          StockHistory('{"B3SA3": 47.59, "timestamp": 1574178178.748371}');
      final stockHistory2 =
          StockHistory('{"B3SA3": 49.45, "timestamp": 1574181778}');
      final stockHistory3 =
          StockHistory('{"B3SA3": 47.94, "timestamp": 1574185378}');

      final stock = Stock(stockHistory1);
      stock.updatePrice(stockHistory2);
      stock.updatePrice(stockHistory3);
      expect(stock.currentPrice, 47.94);
    });

    test('Value difference should be 2.00 even in negative with no signal', () {
      final stockHistory1 =
          StockHistory('{"AAAA3": 14.01, "timestamp": 1574355593.254339}');
      final stock = Stock(stockHistory1);
      final stockHistory2 =
          StockHistory('{"AAAA3": 15.01, "timestamp": 1574355593.254339}');
      stock.updatePrice(stockHistory2);
      final stockHistory3 =
          StockHistory('{"AAAA3": 16.01, "timestamp": 1574355593.254339}');
      stock.updatePrice(stockHistory3);

      expect(stock.getDifference(showSignal: false), '2.00');
    });

    test('Value difference should be -9.87 in negative with signal', () {
      final stockHistory1 =
          StockHistory('{"AAAA3": 34.46, "timestamp": 1574355593.254339}');
      final stock = Stock(stockHistory1);
      final stockHistory2 =
          StockHistory('{"AAAA3": 40.01, "timestamp": 1574355593.254339}');
      stock.updatePrice(stockHistory2);
      final stockHistory3 =
          StockHistory('{"AAAA3": 44.33, "timestamp": 1574355593.254339}');
      stock.updatePrice(stockHistory3);

      expect(stock.getDifference(showSignal: true), '-9.87');
    });

    test('Value difference should be 3.21 in positive with no signal', () {
      final stockHistory1 =
          StockHistory('{"AAAA3": 13.21, "timestamp": 1574355593.254339}');
      final stock = Stock(stockHistory1);
      final stockHistory2 =
          StockHistory('{"AAAA3": 15.01, "timestamp": 1574355593.254339}');
      stock.updatePrice(stockHistory2);
      final stockHistory3 =
          StockHistory('{"AAAA3": 10.0, "timestamp": 1574355593.254339}');
      stock.updatePrice(stockHistory3);

      expect(stock.getDifference(showSignal: false), '3.21');
    });

    test('Value difference should be +3.21 in positive with signal', () {
      final stockHistory1 =
          StockHistory('{"AAAA3": 13.21, "timestamp": 1574355593.254339}');
      final stock = Stock(stockHistory1);
      final stockHistory2 =
          StockHistory('{"AAAA3": 15.01, "timestamp": 1574355593.254339}');
      stock.updatePrice(stockHistory2);
      final stockHistory3 =
          StockHistory('{"AAAA3": 10.00, "timestamp": 1574355593.254339}');
      stock.updatePrice(stockHistory3);

      expect(stock.getDifference(showSignal: true), '+3.21');
    });
  });
  group('Calc percent', () {
    test('Value should be 1.1762...', () {
      expect(Stock.calcPercent(47.61, 48.17), 1.1762234824616724);
    });

    test('Value should be 1.18', () {
      expect(Stock.calcPercent(47.61, 48.17).toStringAsFixed(2), '1.18');
    });

    test('Value should be -1.03', () {
      expect(Stock.calcPercent(29.08, 28.78).toStringAsFixed(2), '-1.03');
    });

    test('Value should be 0', () {
      expect(Stock.calcPercent(29.08, 29.08), 0);
    });

    test('Value percent should be as last one 0.74', () {
      final stockHistory1 =
          StockHistory('{"B3SA3": 47.59, "timestamp": 1574178178.748371}');
      final stockHistory2 =
          StockHistory('{"B3SA3": 49.45, "timestamp": 1574181778}');
      final stockHistory3 =
          StockHistory('{"B3SA3": 47.94, "timestamp": 1574185378}');

      final stock = Stock(stockHistory1);
      stock.updatePrice(stockHistory2);
      stock.updatePrice(stockHistory3);
      expect(stock.currentPrice, 47.94);
    });

    test('Value percent should be as last one +0.74% with signal', () {
      final stockHistory1 =
          StockHistory('{"B3SA3": 47.59, "timestamp": 1574178178.748371}');
      final stockHistory2 =
          StockHistory('{"B3SA3": 49.45, "timestamp": 1574181778}');
      final stockHistory3 =
          StockHistory('{"B3SA3": 47.94, "timestamp": 1574185378}');

      final stock = Stock(stockHistory1);
      stock.updatePrice(stockHistory2);
      stock.updatePrice(stockHistory3);
      expect(stock.getPercentage(), '+0.74%');
    });

    test('Value percent should be as last one +0.74% with signal', () {
      final stockHistory1 =
          StockHistory('{"B3SA3": 47.59, "timestamp": 1574178178.748371}');
      final stockHistory2 =
          StockHistory('{"B3SA3": 49.45, "timestamp": 1574181778}');
      final stockHistory3 =
          StockHistory('{"B3SA3": 47.94, "timestamp": 1574185378}');

      final stock = Stock(stockHistory1);
      stock.updatePrice(stockHistory2);
      stock.updatePrice(stockHistory3);
      expect(stock.getPercentage(showSignal: true), '+0.74%');
    });

    test('Value percent should be as last one -3.33% with signal', () {
      final stockHistory1 =
          StockHistory('{"B3SA3": 49.59, "timestamp": 1574178178.748371}');
      final stockHistory2 =
          StockHistory('{"B3SA3": 49.45, "timestamp": 1574181778}');
      final stockHistory3 =
          StockHistory('{"B3SA3": 47.94, "timestamp": 1574185378}');

      final stock = Stock(stockHistory1);
      stock.updatePrice(stockHistory2);
      stock.updatePrice(stockHistory3);
      expect(stock.getPercentage(showSignal: true), '-3.33%');
    });

    test('''Value percent should be as last one 3.33% without signal
        even it is being negative''', () {
      final stockHistory1 =
          StockHistory('{"B3SA3": 49.59, "timestamp": 1574178178.748371}');
      final stockHistory2 =
          StockHistory('{"B3SA3": 49.45, "timestamp": 1574181778}');
      final stockHistory3 =
          StockHistory('{"B3SA3": 47.94, "timestamp": 1574185378}');

      final stock = Stock(stockHistory1);
      stock.updatePrice(stockHistory2);
      stock.updatePrice(stockHistory3);
      expect(stock.getPercentage(showSignal: false), '3.33%');
    });
  });

  group('Match beetween price diff and percent', () {});
}
