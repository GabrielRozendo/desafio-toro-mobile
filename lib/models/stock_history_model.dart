import 'dart:convert';

class StockHistory {
  String ticker;
  double price;
  DateTime timestamp;

  StockHistory(String jsonString) {
    Map json = jsonDecode(jsonString);
    this.ticker = json.keys.first;
    price = json.values.first;
    timestamp = convertToDateTime(json.values.last.toInt());
  }

  static DateTime convertToDateTime(int timestamp) =>
      DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
}
