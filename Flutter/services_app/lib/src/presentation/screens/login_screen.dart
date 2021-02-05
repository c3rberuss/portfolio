import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services/src/blocs/auth/bloc.dart';
import 'package:services/src/blocs/categories/categories_bloc.dart';
import 'package:services/src/blocs/categories/categories_event.dart';
import 'package:services/src/blocs/user/bloc.dart';
import 'package:services/src/presentation/widgets/button.dart';
import 'package:services/src/presentation/widgets/card.dart';
import 'package:services/src/presentation/widgets/dialog.dart';
import 'package:services/src/presentation/widgets/input.dart';
import 'package:services/src/presentation/widgets/separators.dart';
import 'package:services/src/repositories/auth_repository.dart';
import 'package:services/src/repositories/spreferences_repository.dart';
import 'package:services/src/utils/functions.dart';
import 'package:services/src/utils/screen_utils.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthBloc _authBloc;
  TextEditingController emailController;
  TextEditingController passwordController;
  FocusNode _focusEmail;
  FocusNode _focusPassword;

  @override
  void initState() {
    super.initState();

    _authBloc = AuthBloc(
        authRepository: RepositoryProvider.of<AuthRepository>(context),
        preferences: RepositoryProvider.of<SPreferencesRepository>(context));

    emailController = TextEditingController();
    passwordController = TextEditingController();

    _focusEmail = FocusNode();
    _focusPassword = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            children: <Widget>[
              CustomCard(
                content: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 40,
                  ),
                  child: BlocConsumer<AuthBloc, AuthState>(
                    bloc: _authBloc,
                    listener: (context, state) async {
                      if (state.authSuccess) {
                        BlocProvider.of<UserBloc>(context).add(SaveUserEvent(state.user));
                        BlocProvider.of<CategoriesBloc>(context).add(FetchDataEvent());
                        Navigator.pushReplacementNamed(context, "home");
                      } else if (state.authError) {
                        _showError("Email or password incorrect! Check your credentials.");
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Image.asset("assets/login.png", scale: 4),
                          ),
                          separatorV(12),
                          Text(
                            'Welcome Back!',
                            style: TextStyle(fontSize: 35),
                          ),
                          separatorV(24),
                          Input(
                            icon: Icons.email,
                            placeholder: "Email",
                            controller: emailController,
                            focusNode: _focusEmail,
                            keyboardType: TextInputType.emailAddress,
                            showSuffix: true,
                            isValid: state.validEmail,
                            action: TextInputAction.next,
                            onAction: () {
                              fieldFocusChange(context, _focusEmail, _focusPassword);
                            },
                            onTextChange: (value) {
                              _authBloc.add(EmailChangedEvent(emailController.text));
                            },
                          ),
                          separatorV(8),
                          Input(
                            icon: Icons.vpn_key,
                            placeholder: "Password",
                            controller: passwordController,
                            focusNode: _focusPassword,
                            showSuffix: true,
                            isValid: state.validPassword,
                            action: TextInputAction.go,
                            onAction: () {
                              fieldFocusChange(context, _focusPassword);
                            },
                            onTextChange: (value) {
                              _authBloc.add(
                                PasswordChangedEvent(passwordController.text),
                              );
                            },
                            isPassword: true,
                          ),
                          separatorV(32),
                          if (!state.authenticating) ...[
                            CustomButton(
                              width: getScreenWidth(context),
                              disabled: (!state.validEmail && !state.validPassword) ||
                                  state.authenticating,
                              callback: () async {
                                if (!state.authenticating) {
                                  //emit event
                                  _authBloc.add(
                                    SignInEvent(
                                      emailController.text,
                                      passwordController.text,
                                    ),
                                  );
                                }
                              },
                              text: "Log in",
                            )
                          ] else ...[
                            Align(
                              child: CircularProgressIndicator(),
                              alignment: Alignment.center,
                            )
                          ],
                          separatorV(16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text("Don't have an account?"),
                              FlatButton(
                                onPressed: () async {
                                  _focusEmail.unfocus();
                                  _focusPassword.unfocus();
                                  final email = await Navigator.pushNamed(context, "register");
                                  if (email != null && email is String) {
                                    emailController.text = email;
                                  }
                                },
                                child: Text(
                                  "Create an Account",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showError(String error) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return CustomDialog(
          title: "Login Fail",
          content: error,
          dialogType: DialogType.Error,
        );
      },
    );
  }

  @override
  void dispose() {
    _authBloc.close();
    super.dispose();
  }
}
