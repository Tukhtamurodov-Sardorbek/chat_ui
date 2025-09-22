import 'package:flutter/cupertino.dart';

extension NumExt on num {
  SizedBox get verticalSpace {
    return SizedBox(height: toDouble());
  }

  SizedBox get horizontalSpace {
    return SizedBox(width: toDouble());
  }
}
