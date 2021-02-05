import 'package:bookshop/src/blocs/auth/auth_bloc.dart';
import 'package:bookshop/src/blocs/auth/auth_event.dart';
import 'package:bookshop/src/blocs/auth/auth_form_bloc.dart';
import 'package:bookshop/src/blocs/auth/auth_state.dart';
import 'package:bookshop/src/blocs/categories/bloc.dart';
import 'package:bookshop/src/blocs/profile/bloc.dart';
import 'package:bookshop/src/models/users/user_model.dart';
import 'package:bookshop/src/presentation/widgets/input.dart';
import 'package:bookshop/src/presentation/widgets/progress_dialog.dart';
import 'package:bookshop/src/repositories/auth_repository.dart';
import 'package:bookshop/src/repositories/preferences_repository.dart';
import 'package:bookshop/src/repositories/theme_repository.dart';
import 'package:bookshop/src/utils/functions.dart';
import 'package:bookshop/src/utils/screen_utils.dart';
import 'package:bookshop/src/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:getwidget/getwidget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ThemeRepository _theme;
  AuthBloc _authBloc;
  TextEditingController emailController;
  TextEditingController passwordController;
  FocusNode _focusEmail;
  FocusNode _focusPassword;

  @override
  void initState() {
    super.initState();
    _theme = RepositoryProvider.of<ThemeRepository>(context);

    _authBloc = AuthBloc(
      authRepository: RepositoryProvider.of<AuthRepository>(context),
      preferences: RepositoryProvider.of<PreferencesRepository>(context),
    );

    emailController = TextEditingController();
    passwordController = TextEditingController();

    _focusEmail = FocusNode();
    _focusPassword = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthFormBloc(
        context.repository<AuthRepository>(),
        context.repository<PreferencesRepository>(),
      ),
      child: Builder(
        builder: (BuildContext context) {
          // ignore: close_sinks
          final bloc = context.bloc<AuthFormBloc>();
          return FormBlocListener<AuthFormBloc, UserModel, String>(
            onSubmitting: (context, state) {
              ProgressDialog.show(context);
            },
            onSuccess: (context, state) {
              ProgressDialog.hide(context);
              context.bloc<ProfileBloc>().add(InitSessionEvent(state.successResponse));
              context.bloc<CategoriesBloc>().add(FetchCategoriesEvent());
              Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
            },
            onFailure: (context, state) {
              ProgressDialog.hide(context);
              showError(context, state.failureResponse, "Error");
            },
            child: Scaffold(
              body: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: SizedBox(
                  height: screenHeight(context),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                            "assets/images/logo2.png",
                            width: screenWidth(context) * 0.4,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight(context) * 0.03),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: screenWidth(context) * 0.38,
                          child: GFTypography(
                            text: "Inicia Sesión!",
                            textColor: GFColors.DARK.withOpacity(0.7),
                            type: GFTypographyType.typo1,
                            dividerAlignment: Alignment.center,
                            dividerColor: GFColors.PRIMARY,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight(context) * 0.03),
                      TextFieldBlocBuilder(
                        textFieldBloc: bloc.email,
                        decoration: Styles.inputDecorator(_theme.palette, label: "Correo"),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        focusNode: _focusEmail,
                        nextFocusNode: _focusPassword,
                      ),
                      TextFieldBlocBuilder(
                        textFieldBloc: bloc.password,
                        suffixButton: SuffixButton.obscureText,
                        decoration: Styles.inputDecorator(_theme.palette, label: "Contraseña"),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        focusNode: _focusPassword,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          onPressed: () async {},
                          child: Text(
                            "Olvidaste tu contraseña?",
                            style: TextStyle(color: _theme.palette.secondary),
                          ),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        ),
                      ),
                      SizedBox(height: screenHeight(context) * 0.02),
                      GFButton(
                          text: "Ingresar",
                          blockButton: true,
                          disabledTextColor: GFColors.DARK.withOpacity(0.5),
                          onPressed: () {
                            bloc.submit();
                          }),
                      SizedBox(height: screenHeight(context) * 0.04),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("No tienes una cuenta? "),
                          FlatButton(
                            onPressed: () async {
                              _focusEmail.unfocus();
                              _focusPassword.unfocus();
                              final email = await Navigator.pushNamed(context, "/signup");
                              if (email != null && email is String) {
                                emailController.text = email;
                              }
                            },
                            child: Text(
                              "Regístrate",
                              style: TextStyle(color: _theme.palette.secondary),
                            ),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  example() {
    BlocConsumer<AuthBloc, AuthState>(
      bloc: _authBloc,
      listener: (BuildContext context, AuthState state) {
        if (state.noInternet) {
          //noInternetConnection(context);
        }

        if (state.authSuccess) {
          //BlocProvider.of<UserBloc>(context).add(SaveUserEvent(state.user));
          BlocProvider.of<ProfileBloc>(context).add(InitSessionEvent(state.user));
          //BlocProvider.of<CategoriesBloc>(context).add(FetchCategoriesEvent());
          Navigator.pushNamedAndRemoveUntil(context, "home", (predicate) => false);
        } else if (state.authError) {
          showError(context, "Correo u contraseña incorrectos! Revise sus credenciales.");
        }
      },
      builder: (BuildContext context, AuthState state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Input(
                placeholder: "Correo",
                controller: emailController,
                focusNode: _focusEmail,
                keyboardType: TextInputType.emailAddress,
                showSuffix: true,
                isValid: state.validEmail,
                action: TextInputAction.next,
                onAction: () {
                  fieldFocusChange(context, _focusEmail, _focusPassword);
                },
                onTextChange: () {
                  _authBloc.add(EmailChangedEvent(emailController.text));
                },
              ),
              SizedBox(height: screenHeight(context) * 0.03),
              Input(
                placeholder: "Contraseña",
                controller: passwordController,
                focusNode: _focusPassword,
                showSuffix: true,
                isValid: state.validPassword,
                action: TextInputAction.go,
                onAction: () {
                  fieldFocusChange(context, _focusPassword);
                },
                onTextChange: () {
                  _authBloc.add(
                    PasswordChangedEvent(passwordController.text),
                  );
                },
                isPassword: true,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () async {},
                    child: Text(
                      "Olvidaste tu contraseña?",
                      style: TextStyle(color: _theme.palette.secondary),
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  )),
              SizedBox(height: screenHeight(context) * 0.02),
              if (!state.authenticating) ...[
                GFButton(
                  text: "Ingresar",
                  fullWidthButton: true,
                  disabledTextColor: GFColors.DARK.withOpacity(0.5),
                  onPressed: state.validData
                      ? () {
                          if (!state.authenticating) {
                            //emit event
                            /*_authBloc.add(
                                        SignInEvent(
                                          emailController.text,
                                          passwordController.text,
                                        ),
                                      );*/

                            Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
                          }
                        }
                      : null,
                )
              ] else ...[
                Align(
                  child: CircularProgressIndicator(),
                  alignment: Alignment.center,
                )
              ],
              SizedBox(height: screenHeight(context) * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("No tienes una cuenta? "),
                  FlatButton(
                    onPressed: () async {
                      _focusEmail.unfocus();
                      _focusPassword.unfocus();
                      final email = await Navigator.pushNamed(context, "/signup");
                      if (email != null && email is String) {
                        emailController.text = email;
                      }
                    },
                    child: Text(
                      "Regístrate",
                      style: TextStyle(color: _theme.palette.secondary),
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _authBloc.close();
    emailController.dispose();
    passwordController.dispose();
    _focusEmail.dispose();
    _focusPassword.dispose();
    super.dispose();
  }
}
