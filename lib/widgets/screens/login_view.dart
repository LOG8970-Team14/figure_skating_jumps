import 'package:figure_skating_jumps/exceptions/empty_field_exeption.dart';
import 'package:figure_skating_jumps/exceptions/too_many_attempts.dart';
import 'package:figure_skating_jumps/exceptions/user_not_found_exeption.dart';
import 'package:figure_skating_jumps/exceptions/wrong_password_exepction.dart';
import 'package:figure_skating_jumps/services/user_client.dart';
import 'package:figure_skating_jumps/widgets/titles/page_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/colors.dart';
import '../../constants/lang_fr.dart';
import '../../enums/ice_button_importance.dart';
import '../../enums/ice_button_size.dart';
import '../buttons/ice_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String _email = '';
  String _password = '';
  String _errorMessage = '';
  String _connectionLabelBtn = connectionButton;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _connectionInfoKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController(text: _email);
    _passwordController = TextEditingController(text: _password);
    super.initState();
  }

  Future<void> onConnection() async {
    if (_connectionInfoKey.currentState == null ||
        !_connectionInfoKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _connectionLabelBtn = connectingButton;
    });
    try {
      await UserClient().signIn(_email, _password);
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/');
    } on EmptyFieldException {
      setState(() {
        _errorMessage = EmptyFieldException().uiMessage;
      });
    } on UserNotFoundException {
      setState(() {
        _errorMessage = UserNotFoundException().uiMessage;
      });
    } on WrongPasswordException {
      setState(() {
        _errorMessage = WrongPasswordException().uiMessage;
      });
    } on TooManyAttemptsException {
      setState(() {
        _errorMessage = TooManyAttemptsException().uiMessage;
      });
    } catch (e) {
      _errorMessage = connectionImpossible;
    }
    setState(() {
      _connectionLabelBtn = connectionButton;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Center(
                child: SingleChildScrollView(
                    child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.all(32.0),
                    height: 100,
                    child: SvgPicture.asset(
                        'assets/vectors/blanc-logo-patinage-quebec.svg')),
                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(32.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                        margin: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: PageTitle(text: loginTitle),
                            ),
                            Form(
                                key: _connectionInfoKey,
                                child: Column(children: [
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller: _emailController,
                                    validator: (value) {
                                      return _emailValidator(value);
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        _email = value;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      labelText: email,
                                      labelStyle: TextStyle(
                                          fontSize: 16, color: discreetText),
                                    ),
                                  ),
                                  TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller: _passwordController,
                                    obscureText: true,
                                    validator: (value) {
                                      return _passValidator(value);
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        _password = value;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      labelText: password,
                                      labelStyle: TextStyle(
                                          fontSize: 16, color: discreetText),
                                    ),
                                  )
                                ])),
                            Container(
                                margin: const EdgeInsets.all(8),
                                child: Text(
                                  _errorMessage,
                                  style: const TextStyle(
                                      color: errorColor, fontSize: 16),
                                )),
                            IceButton(
                                text: _connectionLabelBtn,
                                onPressed: () async {
                                  onConnection();
                                },
                                textColor: paleText,
                                color: primaryColor,
                                iceButtonImportance:
                                    IceButtonImportance.mainAction,
                                iceButtonSize: IceButtonSize.medium),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: IceButton(
                                  text: createAccount,
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      '/CoachAccountCreation',
                                    );
                                  },
                                  textColor: primaryColor,
                                  color: primaryColor,
                                  iceButtonImportance:
                                      IceButtonImportance.secondaryAction,
                                  iceButtonSize: IceButtonSize.medium),
                            )
                          ],
                        ))),
              ],
            )))));
  }

  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return pleaseFillField;
    }
    return null;
  }

  String? _passValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return pleaseFillField;
    }
    return null;
  }
}
