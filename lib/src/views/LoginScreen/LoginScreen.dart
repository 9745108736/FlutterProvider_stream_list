import 'dart:convert';

import 'package:after_layout/after_layout.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tp_connects/src/constents/colors.dart';
import 'package:tp_connects/src/constents/strings.dart';
import 'package:tp_connects/src/getIt.dart';
import 'package:tp_connects/src/utils/findUtils.dart';
import 'package:tp_connects/src/widgets/commonWidget.dart';
import 'package:tp_connects/src/widgets/loadingWidget.dart';
import 'package:tp_connects/src/widgets/textFieldWidget.dart';

import '../ListPostScreen/listPostScreen.dart';
import 'loginController.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with AfterLayoutMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.appBackgroundColor.redC,
      body: _body(),
    );
  }

  LoginController _loginController = new LoginController(); //controller object

  @override
  void initState() {
    super.initState();
    //added default numbers
    _loginController.phoneTC.text = "+971501977439";
    _loginController.passwordTC.text = "1132456";
  }

  @override
  void dispose() {
    super.dispose();
    _loginController.provider.dispose();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    //after initialise screen will load this method and listen for changes
    _loginController.provider.loginResStream.listen((snapshot) {
      snapshot.fold(
          (l) => {
                //if glitch happen willl execute this block
                print("Somthing went wrong - ${l.message}"),
                FailedToastWidget(context, message: l.message)
              }, (r) {
        //if everything is correct this block will execute
        print("Login response encoded - ${jsonEncode(r)}");
        if (r.status == true) {
          FindUtils.sharePref.saveToken(token: r.userToken); //save token TO SP
          homeNavigate(); //open home screen
        } else {
          //show error meessage if login is not success
          FailedToastWidget(context, message: "Invalid user name or password");
          _loginController.loginErrorMessage = "Invalid user name or password";
          setState(() {});
        }
      });
      //make loading false
      LoadingManege(manageLoading: false);
    });
  }

  void homeNavigate() {
    //navigate to home
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListPostsScreen()),
    );
  }

  LoadingManege({bool manageLoading}) {
    _loginController.showLoading =
        manageLoading ?? !_loginController.showLoading;
    setState(() {});
  }

  validate() {
    //method to validate and call the login method
    _loginController.passwordErrTxt = null;
    _loginController.phoneErrTxt = null;
    if (_loginController.phoneTC.text.isEmpty) {
      _loginController.phoneErrTxt = L.enterValidphoneStr;
    } else if (_loginController.passwordTC.text.isEmpty) {
      _loginController.passwordErrTxt = L.enterValidPAssStr;
    } else {
      LoadingManege(manageLoading: true);
      loginFun();
    }
  }

  void loginFun() {
    //call provider method for login
    _loginController.provider.login(
        usrName: _loginController.phoneTC.text.trim(),
        passWrd: _loginController.passwordTC.text.trim());
  }

  Widget _body() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Card(
          child: Container(
            color: MyColors.white.redC,
            height: MediaQuery.of(context).size.height - 90,
            width: MediaQuery.of(context).size.width - 50,
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  spaceHeightWidget(
                      sizeParam: MediaQuery.of(context).size.width / 3),
                  Row(
                    children: [
                      AutoSizeText(
                        L.logintoAccountStr,
                        style: FindUtils.MyStyles.styleBold(fontSize: 22),
                        maxLines: 2,
                        wrapWords: true,
                      ),
                    ],
                  ),
                  spaceHeightWidget(sizeParam: 30),
                  MyTextFiled(
                    label: L.userNamePhoneStr,
                    hintTextStyle: FindUtils.MyStyles.styleLight(fontSize: 16),
                    textStyle: TextStyle(color: MyColors.black.redC),
                    errorText: _loginController.phoneErrTxt,
                    nextFocusNode: _loginController.passwordFocusNode,
                    textInputType: TextInputType.emailAddress,
                    textEditingController: _loginController.phoneTC,
                    focusNode: _loginController.usernameFocusNode,
                    underLineColor: MyColors.underLineColor.redC,
                  ),
                  spaceHeightWidget(sizeParam: 20),
                  MyTextFiled(
                    label: L.passwordStr,
                    obscureText: true,
                    hintTextStyle: FindUtils.MyStyles.styleLight(fontSize: 16),
                    textStyle: TextStyle(color: MyColors.black.redC),
                    errorText: _loginController.phoneErrTxt,
                    textInputType: TextInputType.visiblePassword,
                    textEditingController: _loginController.passwordTC,
                    focusNode: _loginController.passwordFocusNode,
                    underLineColor: MyColors.underLineColor.redC,
                  ),
                  spaceHeightWidget(sizeParam: 20),
                  _loginController.loginErrorMessage == ""
                      ? Container()
                      : Text(
                          _loginController.loginErrorMessage,
                          style: FindUtils.MyStyles.styleNormal(
                              fontSize: 16, fontColor: MyColors.red.redC),
                        ),
                  spaceHeightWidget(sizeParam: 20),
                  AbsorbPointer(
                    absorbing: _loginController.showLoading,
                    child: ButtonTheme(
                      height: 48,
                      minWidth: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        onPressed: () {
                          validate();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            side: BorderSide(
                                color: MyColors.underLineColor.redC)),
                        color: MyColors.btnGreenColor.redC,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: _loginController.showLoading
                              ? RoundedLoadingButtonWidget(
                                  color: MyColors.white.redC)
                              : Text(
                                  L.loginStr,
                                  style: FindUtils.MyStyles.styleLight(
                                      fontSize: 16,
                                      fontColor: MyColors.white.redC),
                                ),
                        ),
                      ),
                    ),
                  ),
                  spaceHeightWidget(sizeParam: 20),
                  Text(
                    L.forgetStr,
                    style: FindUtils.MyStyles.styleBold(
                        fontSize: 16, fontColor: MyColors.btnGreenColor.redC),
                  ),
                  spaceHeightWidget(
                      sizeParam: MediaQuery.of(context).size.width / 7),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: RichText(
                      text: TextSpan(
                          text: L.dontaccountStr,
                          children: [
                            TextSpan(
                                text: L.registerStr,
                                style: FindUtils.MyStyles.styleBold(
                                    fontSize: 18,
                                    fontColor: MyColors.btnGreenColor.redC)),
                          ],
                          style: FindUtils.MyStyles.styleNormal(
                              fontSize: 17, fontColor: MyColors.black.redC)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
