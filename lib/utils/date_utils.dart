class DateUtils {
  static String durationInString(DateTime dateTime) {
    final Duration lastUpdate = DateTime.now().difference(dateTime);
    if (lastUpdate.inSeconds == 0) return "agora!";
    if (lastUpdate.inMinutes < 1) return '${lastUpdate.inSeconds} seg. atrás';
    if (lastUpdate.inHours < 1) return '${lastUpdate.inMinutes} min. atrás';

    return 'Há muito tempo...';
  }
}
