import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tp_connects/src/constents/colors.dart';
import 'package:tp_connects/src/constents/fonts.dart';

class MyTextFiled extends StatefulWidget {
  //todo : toggling  password eye causes turn on softkeybaord if no softkeyboard

  String label;

  TextEditingController textEditingController;
  TextInputAction textInputAction;
  TextInputType textInputType;
  FocusNode focusNode;
  FocusNode nextFocusNode;
  bool enabled = true;
  Widget icon;

  bool readOnly = false;
  String errorText;
  bool obscureText = false;
  var passwordVisibleOnEye = PasswordVisibleOnEye(false);
  bool passwordEyeEnabled = false;
  VoidCallback onFieldSubmitted;
  GestureTapCallback ontap;
  TextStyle textStyle;
  TextStyle hintTextStyle;
  EdgeInsetsGeometry contentPadding;
  Color underLineColor;
  int paddingSimilarToForm = 0;
  int maxLength;

/*  Widget suffixIcon;*/

  MyTextFiled(
      {@required this.label,
      this.textEditingController,
      this.textInputAction,
      this.textInputType,
      this.focusNode,
      this.nextFocusNode,
      this.enabled = true,
      this.readOnly = false,
      this.ontap,
      this.errorText,
      this.icon,
      this.textStyle,
      this.hintTextStyle,
      this.contentPadding,
      this.underLineColor = Colors.white,
      /* this.suffixIcon,*/
      this.obscureText = false,
      this.passwordEyeEnabled = false,
      this.onFieldSubmitted,
      this.passwordVisibleOnEye,
      this.paddingSimilarToForm,
      this.maxLength});

  @override
  _MyTextFiledState createState() => _MyTextFiledState();
}

class _MyTextFiledState extends State<MyTextFiled> {
  @override
  void initState() {
    if (widget.focusNode?.hasListeners == true)
      widget.focusNode.addListener(() {
        if (widget.focusNode.hasFocus) {
          setState(() {
            widget.errorText = null;
          });
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding:
            EdgeInsets.only(top: widget?.paddingSimilarToForm?.toDouble() ?? 0),
        child: TextFormField(
          autofocus: false,
          maxLength: widget.maxLength ?? 50,
          onTap: widget.ontap,
          readOnly: widget.readOnly ?? widget.ontap != null,
          enabled: widget.enabled,
          inputFormatters: [
            LengthLimitingTextInputFormatter(40),
          ],
          maxLines: 1,
          keyboardType: widget.textInputType,
          style: widget.textStyle ??
              TextStyle(
//                color: MyColor.blackText1_2E2E2E,
                color: MyColors.black.redC,
                fontSize: 16,
                fontFamily: MyFonts.FontLight.fontC,
              ),
          decoration: InputDecoration(
            prefixIcon: widget.icon,
            counterText: "",
            contentPadding: widget.contentPadding ??
                EdgeInsetsDirectional.only(top: 0, bottom: 0, start: 4, end: 0),
            labelText: widget.label,
            hintText: widget.label,
            labelStyle: widget?.hintTextStyle ??
                TextStyle(
                    color: MyColors.white.redC,
                    fontFamily: MyFonts.FontLight.fontC),
            hintStyle: widget.hintTextStyle ??
                TextStyle(
                    color: MyColors.white.redC,
                    fontFamily: MyFonts.FontLight.fontC),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.underLineColor, width: .5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.underLineColor, width: .5),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.underLineColor.redC),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.underLineColor.redC),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.underLineColor, width: .5),
            ),
            /*       suffix: widget.suffixIcon,*/
            suffixIcon: (widget.passwordEyeEnabled
                ? IconButton(
                    icon: Icon(
                      CupertinoIcons.eye_solid,
                      color: MyColors.black.redC,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.passwordVisibleOnEye.visible =
                            !widget.passwordVisibleOnEye.visible;
                      });
                    },
                  )
                : null),
            errorText: widget.errorText,
          ),
          textAlign: TextAlign.start,
          controller: widget.textEditingController,
          textInputAction: widget.textInputAction ??
              (widget.nextFocusNode == null
                  ? TextInputAction.done
                  : TextInputAction.next),
          focusNode: widget.focusNode,
          onFieldSubmitted: (v) {
            if (widget.nextFocusNode != null)
              FocusScope.of(context).requestFocus(widget.nextFocusNode);
            else if (widget.onFieldSubmitted != null) {
              widget.onFieldSubmitted();
            }
          },
          onChanged: (text) {
            if (widget.errorText != null)
              setState(() {
                widget.errorText = null;
              });
          },
          obscureText: widget.passwordEyeEnabled
              ? !widget.passwordVisibleOnEye.visible
              : widget.obscureText,
        ),
      ),
    );
  }
}

class PasswordVisibleOnEye {
  PasswordVisibleOnEye(this.visible);

  bool visible = false;
}

class MyTextFiled2 extends MyTextFiled {}
