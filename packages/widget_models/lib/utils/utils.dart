import 'dart:math' as math;

String generateUniqueId() {
  final random = math.Random();
  final now = DateTime.now();
  final timestamp = now.microsecondsSinceEpoch.toString();
  const allowedChars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#\$\%^&*()';
  final randomChars = List.generate(
      4, (final _) => allowedChars[random.nextInt(allowedChars.length)]);
  final id = '$timestamp${randomChars.join()}';
  return id.substring(id.length - 8);
}

Map<String, T> joinMaps<T>(final Map<String, T> to, final Map<String, T> from) {
  for (final k in from.keys) {
    to.putIfAbsent(k, () => from[k]!);
  }
  return to;
}
