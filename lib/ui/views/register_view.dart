import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_gorgeous_login/core/view_models/views/register_view_model.dart';
import 'package:the_gorgeous_login/ui/widgets/base_widget.dart';
import 'package:the_gorgeous_login/ui/widgets/input.dart';
import '../../style/theme.dart' as Theme;
import 'package:intl/intl.dart';

class RegisterView extends StatefulWidget {
  final Function(String value) showSnackBar;

  const RegisterView({Key key, this.showSnackBar}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmationController =
      TextEditingController();
  TextEditingController _birthDateController = TextEditingController();
  DateFormat _birthDateFormat = DateFormat('dd-MM-yyyy');

  Map controllersToMap() {
    return {
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'username': _usernameController.text,
      'email': _emailController.text,
      'birthDate': _birthDateController.text,
      'height': _heightController.text,
      'weight': _weightController.text,
      'passkey': _passwordController.text,
      'passwordConfirmation': _passwordConfirmationController.text
    };
  }

  Widget _buildBody(RegisterViewModel model) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 23.0),
        child: SingleChildScrollView(
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
//                      height: 580.0,
                      child: Column(
                        children: <Widget>[
                          Input(
                            controller: _firstNameController,
                            icon: FontAwesomeIcons.user,
                            hintText: "First Name",
//                        suffixIcon: FontAwesomeIcons.user,
                          ),
                          Input(
                            controller: _lastNameController,
                            icon: FontAwesomeIcons.user,
                            hintText: "Last Name",
//                        suffixIcon: FontAwesomeIcons.user,
                          ),
                          Input(
                            controller: _usernameController,
                            icon: FontAwesomeIcons.user,
                            hintText: "Username",
//                        suffixIcon: FontAwesomeIcons.user,
                          ),
                          Input(
                            controller: _emailController,
                            icon: FontAwesomeIcons.envelope,
                            keyboardType: TextInputType.emailAddress,
                            hintText: "Email Address",
//                        suffixIcon: FontAwesomeIcons.user,
                          ),
                          Input(
                            controller: _birthDateController,
                            icon: FontAwesomeIcons.calendar,
                            hintText: "Date of Birth",
                            readOnly: true,
                            keyboardType: TextInputType.datetime,
                            onTap: () async {
                              DateTime date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now()
                                    .subtract(Duration(days: 356 * 40)), lastDate:DateTime.utc(2040),

                              );
                              _birthDateController.value = TextEditingValue(
                                text: _birthDateFormat.format(date),
                              );
                            },
//                        suffixIcon: FontAwesomeIcons.user,
                          ),
                          Input(
                            controller: _heightController,
                            icon: FontAwesomeIcons.expand,
                            hintText: "Height",
                            keyboardType: TextInputType.number,
                          ),
                          Input(
                            controller: _weightController,
                            icon: FontAwesomeIcons.expand,
                            hintText: "Weight",
                            keyboardType: TextInputType.number,
                          ),
                          Input(
                            controller: _passwordController,
                            icon: FontAwesomeIcons.expand,
                            hintText: "Password",
                            obscureText: true,
                          ),
                          Input(
                            controller: _passwordConfirmationController,
                            icon: FontAwesomeIcons.expand,
                            hintText: "Confirm Password",
                            bottom: false,
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 600.0),
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
                    child: MaterialButton(
                        highlightColor: Colors.transparent,
                        splashColor: Theme.Colors.loginGradientEnd,
                        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 42.0),
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontFamily: "WorkSansBold"),
                          ),
                        ),
                        onPressed: () async {
                          bool success = await model.register(controllersToMap());
                          if (success) {
                            widget.showSnackBar('User Registered Successfully');
//                        Navigator.pushReplacementNamed(
//                            context, Routes.Home);
                            return;
                          }
                          widget.showSnackBar('Couldn\'t Register User');
                          /*var result = await firebase.signup(
                              signupEmailController.text,
                              signupNameController.text,
                              signupPasswordController.text,
                              signupConfirmPasswordController.text);*/
//                      showInSnackBar(result.message);
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: RegisterViewModel(authenticationService: Provider.of(context)),
      builder: (BuildContext context, ChangeNotifier model, Widget child) =>
          _buildBody(model),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }
}
