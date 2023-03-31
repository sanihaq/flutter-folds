import '../enums/property_enums.dart';
import '../models/property_model.dart';
import '../property_models/alignment_model.dart';
import '../property_models/bool_model.dart';
import '../property_models/box_constraints_model.dart';
import '../property_models/clip_model.dart';
import '../property_models/color_model.dart';
import '../property_models/cross_axis_alignment_model.dart';
import '../property_models/decoration_model.dart';
import '../property_models/double_model.dart';
import '../property_models/edge_insets_model.dart';
import '../property_models/key_model.dart';
import '../property_models/main_axis_alignment_model.dart';
import '../property_models/main_axis_size_model.dart';
import '../property_models/matrix4_model.dart';
import '../property_models/text_baseline_model.dart';
import '../property_models/text_direction_model.dart';
import '../property_models/vertical_direction_model.dart';

extension ModelExtension on PropertyType {
  PropertyModel fromJson(final Map<String, dynamic> json) {
    switch (this) {
      case PropertyType.bool:
        return BoolProperty.fromJson(json);
      case PropertyType.color:
        return ColorProperty.fromJson(json);
      case PropertyType.crossAxisAlignment:
        return CrossAxisAlignmentProperty.fromJson(json);
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
        return MainAxisAlignmentProperty.fromJson(json);
      case PropertyType.string:
        // TODO: Handle this case.
        break;
      case PropertyType.textStyle:
        // TODO: Handle this case.
        break;
      case PropertyType.mainAxisSize:
        return MainAxisSizeProperty.fromJson(json);
      case PropertyType.textBaseline:
        return TextBaselineProperty.fromJson(json);
      case PropertyType.textDirection:
        return TextDirectionProperty.fromJson(json);
      case PropertyType.verticalDirection:
        return VerticalDirectionProperty.fromJson(json);
      case PropertyType.alignment:
        return AlignmentProperty.fromJson(json);
      case PropertyType.boxConstraints:
        return BoxConstraintsProperty.fromJson(json);
      case PropertyType.clip:
        return ClipProperty.fromJson(json);
      case PropertyType.decoration:
        return DecorationProperty.fromJson(json);
      case PropertyType.edgeInsets:
        return EdgeInsetsProperty.fromJson(json);
      case PropertyType.matrix4:
        return Matrix4Property.fromJson(json);
    }

    return KeyProperty();
  }
}
