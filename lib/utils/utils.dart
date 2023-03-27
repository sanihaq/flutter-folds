import 'extensions.dart';

String getTitleFromEnum(final Enum type) {
  return type.toString().split(".").last.capitalize();
}
