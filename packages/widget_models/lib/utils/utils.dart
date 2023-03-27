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
