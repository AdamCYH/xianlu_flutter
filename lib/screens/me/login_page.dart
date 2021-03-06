import 'package:flutter/material.dart';
import 'package:mobile/services/routing_service.dart';
import 'package:mobile/constants/colors.dart';
import 'package:mobile/services/app_state.dart';
import 'package:mobile/utils/screen_utils.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordHidden = true;
  var username = '';
  var password = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text('登录'),
              centerTitle: true,
              elevation: 0,
            ),
            body: Builder(builder: (BuildContext context) {
              return Container(
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Row(children: [
                            Container(
                              child: Icon(
                                Icons.account_box,
                                color: ColorConstants.BUTTON_PRIMARY,
                              ),
                              margin: EdgeInsets.only(left: 10, right: 20),
                            ),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: '请输入用户名',
                                    border: InputBorder.none),
                                onChanged: (text) {
                                  username = text;
                                },
                              ),
                            )
                          ]),
                          Row(children: [
                            Container(
                              child: Icon(Icons.vpn_key,
                                  color: ColorConstants.BUTTON_PRIMARY),
                              margin: EdgeInsets.only(left: 10, right: 20),
                            ),
                            Expanded(
                              child: TextField(
                                  obscureText: isPasswordHidden,
                                  decoration: InputDecoration(
                                      hintText: '请输入密码',
                                      border: InputBorder.none),
                                  onChanged: (text) {
                                    password = text;
                                  }),
                            ),
                            Container(
                              child: IconButton(
                                  icon: isPasswordHidden
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                  color: ColorConstants.ICON_MEDIUM,
                                  onPressed: () {
                                    setState(() {
                                      isPasswordHidden = !isPasswordHidden;
                                    });
                                  }),
                            ),
                          ]),
                        ],
                      ),
                      padding: EdgeInsets.all(10),
                      color: ColorConstants.BACKGROUND_WHITE,
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                    ),
                    Container(
                      child: MaterialButton(
                        child: Text(
                          '登录',
                          style: TextStyle(color: ColorConstants.TEXT_WHITE),
                        ),
                        onPressed: () {
                          appState.authService.login(
                              username: username,
                              password: password,
                              closeCurrentScreen: true,
                              forceGetUser: true,
                              context: context);
                        },
                        color: ColorConstants.BUTTON_PRIMARY,
                        minWidth: ScreenUtils.screenWidth(context) - 20,
                        height: 40,
                      ),
                      margin: EdgeInsets.all(5),
                    ),
                    Container(
                      child: MaterialButton(
                        child: Text('注册'),
                        onPressed: () {
                          Navigator.pop(context);
                          appState.routingService.pushNoParams(
                              context, RoutingService.registrationPage);
                        },
                        color: ColorConstants.BUTTON_WHITE,
                        minWidth: ScreenUtils.screenWidth(context) - 20,
                        height: 40,
                      ),
                      margin: EdgeInsets.all(5),
                    ),
                  ],
                ),
              );
            }));
      },
    );
  }
}
