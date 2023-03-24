import '../enums/property_enums.dart';
import '../models/property_model.dart';
import '../property_models/double.dart';
import '../property_models/key.dart';

extension ModelExtension on PropertyType {
  // ignore: strict_raw_type
  PropertyModel fromJson(final Map<String, dynamic> json) {
    switch (this) {
      case PropertyType.bool:
        // TODO: Handle this case.
        break;
      case PropertyType.color:
        // TODO: Handle this case.
        break;
      case PropertyType.crossAxisAlignment:
        // TODO: Handle this case.
        break;
      case PropertyType.double:
        return DoubleProperty.fromJson(json);
      case PropertyType.fontStyle:
        // TODO: Handle this case.
        break;
      case PropertyType.fontWeight:
        // TODO: Handle this case.
        break;
      case PropertyType.function:
        // TODO: Handle this case.
        break;
      case PropertyType.iconData:
        // TODO: Handle this case.
        break;
      case PropertyType.int:
        // TODO: Handle this case.
        break;
      case PropertyType.key:
        return KeyProperty.fromJson(json);
      case PropertyType.mainAxisAlignment:
        // TODO: Handle this case.
        break;
      case PropertyType.string:
        // TODO: Handle this case.
        break;
      case PropertyType.textStyle:
        // TODO: Handle this case.
        break;
    }
    return KeyProperty();
  }
}
