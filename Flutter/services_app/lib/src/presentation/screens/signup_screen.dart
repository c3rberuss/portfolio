import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services/src/blocs/registration/register_bloc.dart';
import 'package:services/src/blocs/registration/register_event.dart';
import 'package:services/src/blocs/registration/register_state.dart';
import 'package:services/src/presentation/widgets/button.dart';
import 'package:services/src/presentation/widgets/card.dart';
import 'package:services/src/presentation/widgets/dialog.dart';
import 'package:services/src/presentation/widgets/input.dart';
import 'package:services/src/presentation/widgets/separators.dart';
import 'package:services/src/repositories/user_repository.dart';
import 'package:services/src/utils/functions.dart';
import 'package:services/src/utils/screen_utils.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _focusName = FocusNode();
  final _controllerName = TextEditingController();
  final _focusEmail = FocusNode();
  final _controllerEmail = TextEditingController();
  final _focusPhone = FocusNode();
  final _controllerPhone = TextEditingController();
  final _focusPassword = FocusNode();
  final _controllerPassword = TextEditingController();

  RegisterBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = RegisterBloc(RepositoryProvider.of<UserRepository>(context));

    _controllerName.addListener(_dataChange);
    _controllerPhone.addListener(_dataChange);
    _controllerPassword.addListener(_dataChange);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.blue,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 32),
            child: Wrap(
              children: <Widget>[
                BlocConsumer<RegisterBloc, RegisterState>(
                  bloc: _bloc,
                  listener: (BuildContext context, RegisterState state) async {
                    if (state.registerSuccessfully) {
                      await _showSuccess(state.message);
                      Navigator.pop(context, _controllerEmail.text);
                    } else if (state.registerFailed) {
                      _showError(state.message);
                    }
                  },
                  builder: (BuildContext context, RegisterState state) {
                    return CustomCard(
                      content: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 40,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Image.asset("assets/register.png", scale: 4),
                            ),
                            separatorV(12),
                            Text(
                              'Create an account!',
                              style: TextStyle(fontSize: 35),
                            ),
                            separatorV(16),
                            Input(
                              placeholder: "Full name",
                              keyboardType: TextInputType.text,
                              action: TextInputAction.next,
                              controller: _controllerName,
                              showSuffix: true,
                              isValid: state.isValidName,
                              onAction: () {
                                fieldFocusChange(context, _focusName, _focusPhone);
                              },
                              focusNode: _focusName,
                            ),
                            separatorV(4),
                            Input(
                              placeholder: "Phone",
                              keyboardType: TextInputType.phone,
                              action: TextInputAction.next,
                              showSuffix: true,
                              isValid: state.isValidPhone,
                              controller: _controllerPhone,
                              onAction: () {
                                fieldFocusChange(context, _focusPhone, _focusEmail);
                              },
                              focusNode: _focusPhone,
                            ),
                            separatorV(4),
                            Input(
                              placeholder: "E-mail",
                              keyboardType: TextInputType.emailAddress,
                              action: TextInputAction.next,
                              showSuffix: true,
                              isValid: state.isValidEmail,
                              controller: _controllerEmail,
                              onTextChange: (value) {
                                _bloc.add(EmailChangeEvent(_controllerEmail.text));
                              },
                              onAction: () {
                                fieldFocusChange(context, _focusEmail, _focusPassword);
                              },
                              focusNode: _focusEmail,
                            ),
                            separatorV(4),
                            Input(
                              isPassword: true,
                              placeholder: "Password",
                              keyboardType: TextInputType.text,
                              action: TextInputAction.done,
                              showSuffix: true,
                              isValid: state.isValidPassword,
                              controller: _controllerPassword,
                              onAction: () {
                                fieldFocusChange(context, _focusPassword);
                              },
                              focusNode: _focusPassword,
                            ),
                            separatorV(16),
                            if (state.sendingData) ...[
                              Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(),
                              )
                            ] else ...[
                              Align(
                                alignment: Alignment.center,
                                child: CustomButton(
                                  disabled: !(state.isValidData),
                                  width: getScreenWidth(context),
                                  callback: () {
                                    _bloc.add(
                                      SendDataEvent(
                                        name: _controllerName.text,
                                        email: _controllerEmail.text,
                                        phone: _controllerPhone.text,
                                        password: _controllerPassword.text,
                                      ),
                                    );
                                  },
                                  text: "Sign Up",
                                ),
                              )
                            ]
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _dataChange() {
    _bloc.add(DataChangeEvent(
      name: _controllerName.text,
      email: _controllerEmail.text,
      phone: _controllerPhone.text,
      password: _controllerPassword.text,
    ));
  }

  Future<void> _showError(String error) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return CustomDialog(
          title: "Register Fail",
          content: error,
          dialogType: DialogType.Error,
        );
      },
    );
  }

  Future<void> _showSuccess(String message) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return CustomDialog(
          title: "Register",
          content: message,
          dialogType: DialogType.Success,
        );
      },
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
