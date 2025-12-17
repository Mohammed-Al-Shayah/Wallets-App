import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallets/core/theming/colors.dart';

class TextStyles {
  TextStyles._();

  static TextStyle _base({
    required double size,
    FontWeight weight = FontWeight.normal,
    required Color color,
  }) {
    return TextStyle(
      fontFamily: 'Cairo',
      fontSize: size.sp,
      fontWeight: weight,
      color: color,
    );
  }

  // -------- Black --------
  static final TextStyle black14Regular = _base(
    size: 14,
    weight: FontWeight.w400,
    color: Colors.black,
  );

  static final TextStyle black16Medium = _base(
    size: 16,
    weight: FontWeight.w500,
    color: Colors.black,
  );
  static final TextStyle black14Medium = _base(
    size: 14,
    weight: FontWeight.w500,
    color: Colors.black,
  );

  static final TextStyle black16Bold = _base(
    size: 16,
    weight: FontWeight.w700,
    color: Colors.black,
  );

  static final TextStyle black20SemiBold = _base(
    size: 20,
    weight: FontWeight.w600,
    color: Colors.black,
  );

  static final TextStyle black24Bold = _base(
    size: 24,
    weight: FontWeight.w700,
    color: Colors.black,
  );

  // -------- Blue --------
  static final TextStyle blue16Medium = _base(
    size: 16,
    weight: FontWeight.w500,
    color: ColorsManager.blueblode,
  );
   static final TextStyle blue16bold = _base(
    size: 16,
    weight: FontWeight.w700,
    color: ColorsManager.blueblode,
  );

  static final TextStyle blue20Bold = _base(
    size: 20,
    weight: FontWeight.w700,
    color: ColorsManager.blueblode,
  );

  static final TextStyle blue24Bold = _base(
    size: 24,
    weight: FontWeight.w700,
    color: ColorsManager.mainBlue,
  );

  static final TextStyle blue32Bold = _base(
    size: 32,
    weight: FontWeight.w700,
    color: ColorsManager.mainBlue,
  );

  // -------- Gray --------
  static final TextStyle gray12Medium = _base(
    size: 12,
    color: ColorsManager.gray,
    weight: FontWeight.w500,
  );
  static final TextStyle gray13 = _base(size: 13, color: ColorsManager.gray);

  static final TextStyle gray14 = _base(
    size: 14,
    color: ColorsManager.moreGray,
  );

  static final TextStyle gray14Medium = _base(
    size: 14,
    color: ColorsManager.gray,
    weight: FontWeight.w500,
  );

  static final TextStyle gray16Medium = _base(
    size: 16,
    weight: FontWeight.w500,
    color: ColorsManager.gray,
  );

  // -------- Orange --------
  static final TextStyle orange16SemiBold = _base(
    size: 16,
    weight: FontWeight.w600,
    color: ColorsManager.orange,
  );

  // -------- White --------
  static final TextStyle white16Medium = _base(
    size: 16,
    weight: FontWeight.w500,
    color: Colors.white,
  );

  static final TextStyle white24Bold = _base(
    size: 24,
    weight: FontWeight.w700,
    color: Colors.white,
  );

  // -------- green --------
  static final TextStyle green16Medium = _base(
    size: 16,
    weight: FontWeight.w500,
    color: ColorsManager.green,
  );

  static final TextStyle green24Bold = _base(
    size: 24,
    weight: FontWeight.w700,
    color: ColorsManager.green,
  );
}
