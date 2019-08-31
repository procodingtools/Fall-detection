import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_gorgeous_login/core/constants/app_contstants.dart';
import 'package:the_gorgeous_login/core/services/scaffold_service.dart';
import 'package:the_gorgeous_login/core/view_models/views/login_view_model.dart';
import 'package:the_gorgeous_login/locator_setup.dart';
import 'package:the_gorgeous_login/ui/widgets/base_widget.dart';
import 'package:the_gorgeous_login/ui/widgets/input.dart';
import '../../style/theme.dart' as Theme;

class LoginView extends StatefulWidget {
  final Function showSnackBar;

  const LoginView({Key key, this.showSnackBar}) : super(key: key);
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  Widget _buildBody(LoginViewModel model) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 140.0,
                  child: Column(
                    children: <Widget>[
                      Input(
                        controller: _emailController,
                        icon: FontAwesomeIcons.envelope,
                        hintText: "Email Address",
                        keyboardType: TextInputType.emailAddress,
                      ),
                      Input(
                        bottom: false,
                        controller: _passwordController,
                        icon: FontAwesomeIcons.lock,
                        hintText: "Password",
                        suffixIcon: GestureDetector(
                          onTap: model.togglePasswordObscure,
                          child: Icon(
                            model.passwordObscure
                                ? FontAwesomeIcons.eyeSlash
                                : FontAwesomeIcons.eye,
                            size: 15.0,
                            color: Colors.black,
                          ),
                        ),
                        obscureText: model.passwordObscure,
                      )
//                            Padding(
//                              padding: EdgeInsets.only(
//                                  top: 10.0,
//                                  bottom: 10.0,
//                                  left: 25.0,
//                                  right: 25.0),
//                              child: TextField(
//                                focusNode: myFocusNodePasswordLogin,
//                                controller: loginPasswordController,
//                                obscureText: _obscureTextLogin,
//                                style: TextStyle(
//                                    fontFamily: "WorkSansSemiBold",
//                                    fontSize: 16.0,
//                                    color: Colors.black),
//                                decoration: InputDecoration(
//                                  border: InputBorder.none,
//                                  icon: Icon(
//                                  ,
//                                  size: 22.0,
//                                  color: Colors.black,
//                                  ),
//                                  hintText:,
//                                  hintStyle: TextStyle(
//                                      fontFamily: "WorkSansSemiBold",
//                                      fontSize: 17.0),
//                                  suffixIcon:,
//                                ),
//                              ),
//                            ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 160.0), //login top margin
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Theme.Colors.loginGradientStart,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: Theme.Colors.loginGradientEnd,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: new LinearGradient(
                      colors: [
                        Theme.Colors.loginGradientEnd,
                        Theme.Colors.loginGradientStart
                      ],
                      begin: const FractionalOffset(0.2, 0.2),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: model.busy
                    ? CircularProgressIndicator()
                    : MaterialButton(
                        highlightColor: Colors.transparent,
                        splashColor: Theme.Colors.loginGradientEnd,
                        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 42.0),
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontFamily: "WorkSansBold"),
                          ),
                        ),
                        onPressed: () async {
                          var success = await model.login(
                              _emailController.text, _passwordController.text);
                              ScaffoldService scaffoldService = locator<ScaffoldService>();
                          if (success) {
                            scaffoldService.showSnackBar(Text('Logged In Successfully'));
                            Navigator.pushNamed(
                                context, Routes.Home);
                          } else {
                            scaffoldService.showSnackBar(Text('User not Found '));
                          }
                        },
                      ),
              ),
            ],
          ),
//          Padding(
//            padding: EdgeInsets.only(top: 10.0),
//            child: FlatButton(
//              onPressed: () {},
//              child: Text(
//                "Forgot Password?",
//                style: TextStyle(
//                    decoration: TextDecoration.underline,
//                    color: Colors.white,
//                    fontSize: 16.0,
//                    fontFamily: "WorkSansMedium"),
//              ),
//            ),
//          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
        model: LoginViewModel(authenticationService: Provider.of(context)),
        builder: (BuildContext context, LoginViewModel model, Widget child) =>
            _buildBody(model));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
