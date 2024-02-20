import 'package:flutter/material.dart';
import 'package:zatca/constant/app_size.dart';
import 'package:zatca/constant/colors.dart';
import 'package:zatca/constant/font_size.dart';

class AppWidget{
  static headText(text,
      {double? scale, padding, padV, maxLine, bool? baseLine, color, align}) {
    scale ??= 1.0;
    padding ??= 0.0;
    maxLine ??= 2;
    baseLine ??= false;
    padV ??= 0.0;
    color ??= AppColors.bodyText;
    align ??= TextAlign.center;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: padV),
      child: Text(
        text,
        overflow: TextOverflow.visible,
        maxLines: maxLine,
        //textDirection: TextDirection.ltr,
        textAlign: align,
        softWrap: true,
        style: TextStyle(
          fontSize: FontSize.s24 * scale,
          height: 1.3,
          color: color,
          fontFamily: 'BCArabicB',
          decoration:
          baseLine ? TextDecoration.lineThrough : TextDecoration.none,
          //fontFamily: lng==2?'GESS':'Gotham',
        ),
      ),
    );
  }

  static bodyText(text,
      {double? scale,
        padding,
        padV,
        maxLine,
        bool? baseLine,
        color,
        align,
        font}) {
    scale ??= 1.0;
    padding ??= 0.0;
    maxLine ??= 2;
    baseLine ??= false;
    padV ??= AppHeight.h1 * scale;
    color ??= AppColors.bodyText;
    align ??= TextAlign.center;
    font ??= 'BCArabicB';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: padV),
      child: Text(
        text,
        overflow: TextOverflow.visible,
        maxLines: maxLine,
        //textDirection: TextDirection.ltr,
        textAlign: align,
        softWrap: true,
        style: TextStyle(
          //letterSpacing:1.0,
          height: 1.3,
          fontSize: FontSize.s20 * scale,
          color: color,
          fontFamily: font,
          decoration:
          baseLine ? TextDecoration.lineThrough : TextDecoration.none,
          //fontFamily: lng==2?'GESS':'Gotham',
        ),
      ),
    );
  }

  static Widget textFormFiled(
      {required TextEditingController controller,
        curve,
        hintText,
        textAlign,
        borderColor,
        password,
        readOnly,
        numberOnly,
        fontSize,
        bool? validate,
        double? padV,
        double? padH,
        Widget? suffixIcon,
        formkey}) {
    curve ??= AppWidth.w4;
    hintText ??= '';
    textAlign ??= TextAlign.start;
    borderColor ??= AppColors.mainColor;
    password ??= false;
    readOnly ??= false;
    numberOnly ??= true;
    fontSize ??= FontSize.s20;
    validate ??= false;
    padH ??=0.0;
    padV ??=0.0;
    controller.addListener(() {
      if (validate == true && formkey != null) formkey.currentState!.validate();
    });
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padH, vertical: padV),
      child: Form(
        key: formkey,
        child: TextFormField(
          validator: !validate
              ? null
              : (value) {
            if (value == null || value.isEmpty) {
              return 'Required';
            }
            return null;
          },
          readOnly: readOnly,
          //enabled: !readOnly,
          obscureText: password,
          textAlign: textAlign,
          keyboardType: numberOnly ? TextInputType.number : TextInputType.text,
          style: TextStyle(
              fontSize: fontSize,
              color: AppColors.mainColor,
              fontWeight: FontWeight.bold,
              fontFamily: 'BCArabicR'),
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            isDense: true,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(curve),
              borderSide: const BorderSide(color: AppColors.red, width: 2),
            ),
            errorStyle: const TextStyle(fontSize: 0.0, color: AppColors.red),
            fillColor: AppColors.whiteColor,
            filled: true,
            contentPadding: EdgeInsets.symmetric(horizontal: curve , vertical: curve),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(curve),
              borderSide: BorderSide(
                color: borderColor,
                width: 1,
                // style: BorderStyle.none,
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(curve),
              borderSide: BorderSide(
                color: borderColor,
                width: 1,
                // style: BorderStyle.none,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(curve),
              borderSide: BorderSide(
                color: borderColor,
                width: 1,
                style: BorderStyle.none,
              ),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
                fontSize: fontSize * 0.8,
                color: AppColors.mainColor.withOpacity(0.7)),
            // border: InputBorder.none,
          ),
          controller: controller,
        ),
      ),
    );
  }

  static elevatedButton(
      {required text,
        required Function()? press,
        backcolor,
        height,
        width,
        fontSize}) {
    backcolor ??= AppColors.mainColor;
    fontSize ??= FontSize.s18;
    height ??= FontSize.s18 + 40;
    width ??= double.infinity;
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: backcolor,
          textStyle: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontStyle: FontStyle.normal,
              fontFamily: 'BCArabicR'),
        ),
        onPressed: press,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: AppPadding.p2),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: fontSize,
            ),
          ),
        ),
      ),
    );
  }

}