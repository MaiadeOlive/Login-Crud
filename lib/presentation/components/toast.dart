import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../../utils/theme.dart';

void showToast(
  String text, {
  bool shortToast = true,
  bool fromBottom = true,
  Color color = ThemeColors.white,
  Color textColor = ThemeColors.turkeyred,
}) {
  Toast.show(
    text,
    duration: shortToast ? Toast.lengthLong : Toast.lengthShort,
    gravity: fromBottom ? Toast.bottom : Toast.top,
    backgroundColor: color,
    backgroundRadius: 16.0,
    textStyle: TextStyle(color: textColor),
    border: Border.all(color: Colors.transparent), // Optional border
  );
}
