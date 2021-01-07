import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:megalibreria/src/blocs/registration/bloc.dart';
import 'package:megalibreria/src/blocs/registration/register_form_bloc.dart';
import 'package:megalibreria/src/presentation/widgets/dialog.dart';
import 'package:megalibreria/src/presentation/widgets/progress_dialog.dart';
import 'package:megalibreria/src/repositories/theme_repository.dart';
import 'package:megalibreria/src/repositories/user_repository.dart';
import 'package:megalibreria/src/utils/functions.dart';
import 'package:megalibreria/src/utils/screen_utils.dart';
import 'package:megalibreria/src/utils/styles.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _focusName = FocusNode();
  final _focusLastName = FocusNode();
  final _focusPhone = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _focusConfirmPassword = FocusNode();

  RegisterBloc _bloc;

  ThemeRepository _theme;

  @override
  void initState() {
    super.initState();
    _theme = RepositoryProvider.of<ThemeRepository>(context);
    _bloc = RegisterBloc(RepositoryProvider.of<UserRepository>(context));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterFormBloc(context.repository<UserRepository>()),
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: GFAppBar(
              iconTheme: ThemeData.light().iconTheme.copyWith(color: GFColors.PRIMARY),
              automaticallyImplyLeading: true,
              backgroundColor: GFColors.WHITE,
              elevation: 0,
            ),
            body: Center(
              child: FormBlocListener<RegisterFormBloc, String, String>(
                onSubmitting: (context, state) {
                  if (state.isLastStep) {
                    ProgressDialog.show(context);
                  }
                },
                onSuccess: (context, state) {
                  if (state.stepCompleted == state.lastStep) {
                    ProgressDialog.hide(context);
                    showMessage(context, state.successResponse, "Éxito", DialogType.Success);
                  }
                },
                onFailure: (context, state) {
                  ProgressDialog.hide(context);
                  showError(context, state.failureResponse, "Error");
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      ..._header(),
                      StepperFormBlocBuilder<RegisterFormBloc>(
                        type: StepperType.vertical,
                        physics: ClampingScrollPhysics(),
                        controlsBuilder: (context, onContinue, onCancel, step, bloc) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8, top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                if (step != 1) ...[
                                  GFButton(
                                    text: "Continuar",
                                    type: GFButtonType.solid,
                                    shape: GFButtonShape.standard,
                                    onPressed: onContinue,
                                  )
                                ] else ...[
                                  GFButton(
                                    text: "Regresar",
                                    type: GFButtonType.transparent,
                                    shape: GFButtonShape.standard,
                                    onPressed: onCancel,
                                  ),
                                  SizedBox(width: screenWidth(context) * 0.05),
                                  GFButton(
                                    text: "Registrarse",
                                    type: GFButtonType.solid,
                                    shape: GFButtonShape.standard,
                                    onPressed: onContinue,
                                  ),
                                ]
                              ],
                            ),
                          );
                        },
                        stepsBuilder: (formBloc) {
                          return [
                            _personalInfo(formBloc),
                            _accountInfo(formBloc),
                          ];
                        },
                      )
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

  /* void _dataChange() {
    _bloc.add(DataChangeEvent(
      name: _controllerName.text,
      email: _controllerEmail.text,
      lastName: _controllerLastName.text,
      password: _controllerPassword.text,
      confirmPassword: _controllerConfirmPassword.text,
    ));
  }*/

  @override
  void dispose() {
    _bloc.close();

    _focusName.dispose();
    _focusLastName.dispose();
    _focusEmail.dispose();
    _focusPassword.dispose();
    _focusConfirmPassword.dispose();

    super.dispose();
  }

  /*child() {
    BlocConsumer<RegisterBloc, RegisterState>(
      bloc: _bloc,
      listener: (BuildContext context, RegisterState state) {
        if (state.noInternet) {
          //noInternetConnection(context);
        }

        if (state.registerSuccessfully) {
          //await showSuccess(state.message);
          Navigator.pop(context, _controllerEmail.text);
        } else if (state.registerFailed) {
          //showError(state.message);
        }
      },
      builder: (BuildContext context, RegisterState state) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  "assets/images/logo.png",
                  width: screenWidth(context) * 0.4,
                ),
              ),
            ),
            SizedBox(height: screenHeight(context) * 0.03),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: screenWidth(context) * 0.31,
                child: GFTypography(
                  text: "Regístrate!",
                  textColor: GFColors.DARK.withOpacity(0.7),
                  type: GFTypographyType.typo1,
                  dividerAlignment: Alignment.center,
                  dividerColor: GFColors.PRIMARY,
                ),
              ),
            ),
            SizedBox(height: screenHeight(context) * 0.03),
            GFAccordion(
              title: "Información personal",
              contentChild: Column(
                children: <Widget>[
                  Input(
                    placeholder: "Nombres",
                    keyboardType: TextInputType.text,
                    action: TextInputAction.next,
                    controller: _controllerName,
                    showSuffix: true,
                    isValid: state.isValidName,
                    onAction: () {
                      fieldFocusChange(context, _focusName, _focusLastName);
                    },
                    focusNode: _focusName,
                  ),
                  SizedBox(height: screenHeight(context) * 0.02),
                  Input(
                    placeholder: "Apellidos",
                    keyboardType: TextInputType.phone,
                    action: TextInputAction.next,
                    showSuffix: true,
                    isValid: state.isValidLastName,
                    controller: _controllerLastName,
                    onAction: () {
                      fieldFocusChange(context, _focusLastName, _focusEmail);
                    },
                    focusNode: _focusLastName,
                  ),
                ],
              ),
            ),
            GFAccordion(
              title: "Dirección de envío",
              contentChild: Column(
                children: <Widget>[],
              ),
            ),
            GFAccordion(
              title: "Información de acceso",
              contentChild: Column(
                children: <Widget>[
                  Input(
                    placeholder: "Correo",
                    keyboardType: TextInputType.emailAddress,
                    action: TextInputAction.next,
                    showSuffix: true,
                    isValid: state.isValidEmail,
                    controller: _controllerEmail,
                    onAction: () {
                      fieldFocusChange(context, _focusEmail, _focusPassword);
                    },
                    focusNode: _focusEmail,
                  ),
                  SizedBox(height: screenHeight(context) * 0.02),
                  LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            width: constraints.biggest.width * 0.49,
                            child: Input(
                              isPassword: true,
                              placeholder: "Contraseña",
                              keyboardType: TextInputType.text,
                              action: TextInputAction.next,
                              showSuffix: true,
                              isValid: state.isValidPassword,
                              controller: _controllerPassword,
                              onAction: () {
                                fieldFocusChange(context, _focusPassword, _focusConfirmPassword);
                              },
                              focusNode: _focusPassword,
                            ),
                          ),
                          SizedBox(
                            width: constraints.biggest.width * 0.49,
                            child: Input(
                              isPassword: true,
                              placeholder: "Confirmar",
                              keyboardType: TextInputType.text,
                              action: TextInputAction.done,
                              showSuffix: true,
                              isValid: state.isValidConfirmPassword,
                              controller: _controllerConfirmPassword,
                              onAction: () {
                                fieldFocusChange(context, _focusConfirmPassword);
                              },
                              focusNode: _focusConfirmPassword,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: screenHeight(context) * 0.04),
                  if (!state.sendingData) ...[
                    GFButton(
                      text: "Registrarse",
                      fullWidthButton: true,
                      disabledTextColor: GFColors.DARK.withOpacity(0.5),
                      onPressed: state.isValidData
                          ? () {
                              if (!state.sendingData) {
                                _bloc.add(
                                  SendDataEvent(
                                    name: _controllerName.text,
                                    email: _controllerEmail.text,
                                    lastName: _controllerLastName.text,
                                    password: _controllerPassword.text,
                                  ),
                                );
                              }
                            }
                          : null,
                    ),
                  ] else ...[
                    Align(
                      child: CircularProgressIndicator(),
                      alignment: Alignment.center,
                    )
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );

    Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              "assets/images/logo.png",
              width: screenWidth(context) * 0.4,
            ),
          ),
        ),
        SizedBox(height: screenHeight(context) * 0.03),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: screenWidth(context) * 0.31,
            child: GFTypography(
              text: "Regístrate!",
              textColor: GFColors.DARK.withOpacity(0.7),
              type: GFTypographyType.typo1,
              dividerAlignment: Alignment.center,
              dividerColor: GFColors.PRIMARY,
            ),
          ),
        ),
        SizedBox(height: screenHeight(context) * 0.03),
        BlocConsumer<RegisterBloc, RegisterState>(
          bloc: _bloc,
          listener: (BuildContext context, RegisterState state) async {
            if (state.noInternet) {
              //noInternetConnection(context);
            }

            if (state.registerSuccessfully) {
              //await showSuccess(state.message);
              Navigator.pop(context, _controllerEmail.text);
            } else if (state.registerFailed) {
              //showError(state.message);
            }
          },
          builder: (BuildContext context, RegisterState state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Input(
                    placeholder: "Nombres",
                    keyboardType: TextInputType.text,
                    action: TextInputAction.next,
                    controller: _controllerName,
                    showSuffix: true,
                    isValid: state.isValidName,
                    onAction: () {
                      fieldFocusChange(context, _focusName, _focusLastName);
                    },
                    focusNode: _focusName,
                  ),
                  SizedBox(height: screenHeight(context) * 0.02),
                  Input(
                    placeholder: "Apellidos",
                    keyboardType: TextInputType.phone,
                    action: TextInputAction.next,
                    showSuffix: true,
                    isValid: state.isValidLastName,
                    controller: _controllerLastName,
                    onAction: () {
                      fieldFocusChange(context, _focusLastName, _focusEmail);
                    },
                    focusNode: _focusLastName,
                  ),
                  SizedBox(height: screenHeight(context) * 0.02),
                  Input(
                    placeholder: "Correo",
                    keyboardType: TextInputType.emailAddress,
                    action: TextInputAction.next,
                    showSuffix: true,
                    isValid: state.isValidEmail,
                    controller: _controllerEmail,
                    onAction: () {
                      fieldFocusChange(context, _focusEmail, _focusPassword);
                    },
                    focusNode: _focusEmail,
                  ),
                  SizedBox(height: screenHeight(context) * 0.02),
                  LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            width: constraints.biggest.width * 0.49,
                            child: Input(
                              isPassword: true,
                              placeholder: "Contraseña",
                              keyboardType: TextInputType.text,
                              action: TextInputAction.next,
                              showSuffix: true,
                              isValid: state.isValidPassword,
                              controller: _controllerPassword,
                              onAction: () {
                                fieldFocusChange(context, _focusPassword, _focusConfirmPassword);
                              },
                              focusNode: _focusPassword,
                            ),
                          ),
                          SizedBox(
                            width: constraints.biggest.width * 0.49,
                            child: Input(
                              isPassword: true,
                              placeholder: "Confirmar",
                              keyboardType: TextInputType.text,
                              action: TextInputAction.done,
                              showSuffix: true,
                              isValid: state.isValidConfirmPassword,
                              controller: _controllerConfirmPassword,
                              onAction: () {
                                fieldFocusChange(context, _focusConfirmPassword);
                              },
                              focusNode: _focusConfirmPassword,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: screenHeight(context) * 0.04),
                  if (!state.sendingData) ...[
                    GFButton(
                      text: "Registrarse",
                      fullWidthButton: true,
                      disabledTextColor: GFColors.DARK.withOpacity(0.5),
                      onPressed: state.isValidData
                          ? () {
                              if (!state.sendingData) {
                                _bloc.add(
                                  SendDataEvent(
                                    name: _controllerName.text,
                                    email: _controllerEmail.text,
                                    lastName: _controllerLastName.text,
                                    password: _controllerPassword.text,
                                  ),
                                );
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
                ],
              ),
            );
          },
        ),
      ],
    );
  }*/

  FormBlocStep _personalInfo(RegisterFormBloc bloc) {
    return FormBlocStep(
      isActive: true,
      title: Text("Datos personales"),
      content: Column(
        children: <Widget>[
          TextFieldBlocBuilder(
            textFieldBloc: bloc.name,
            keyboardType: TextInputType.text,
            enableOnlyWhenFormBlocCanSubmit: true,
            decoration: Styles.inputDecorator(_theme.palette, label: "Nombres"),
            textInputAction: TextInputAction.next,
            focusNode: _focusName,
            onSubmitted: (value) {
              fieldFocusChange(context, _focusName, _focusLastName);
            },
          ),
          TextFieldBlocBuilder(
            textFieldBloc: bloc.lastName,
            keyboardType: TextInputType.text,
            decoration: Styles.inputDecorator(_theme.palette, label: "Apellidos"),
            textInputAction: TextInputAction.next,
            focusNode: _focusLastName,
            onSubmitted: (value) {
              fieldFocusChange(context, _focusLastName, _focusPhone);
            },
          ),
          TextFieldBlocBuilder(
            textFieldBloc: bloc.phone,
            keyboardType: TextInputType.phone,
            decoration: Styles.inputDecorator(_theme.palette, label: "Teléfono"),
            textInputAction: TextInputAction.done,
            focusNode: _focusPhone,
            onSubmitted: (value) {
              fieldFocusChange(context, _focusPhone);
            },
          ),
        ],
      ),
    );
  }

  FormBlocStep _accountInfo(RegisterFormBloc bloc) {
    return FormBlocStep(
      title: Text("Cuenta"),
      content: Column(
        children: <Widget>[
          TextFieldBlocBuilder(
            textFieldBloc: bloc.email,
            keyboardType: TextInputType.emailAddress,
            decoration: Styles.inputDecorator(_theme.palette, label: "Correo"),
            textInputAction: TextInputAction.next,
            focusNode: _focusEmail,
            onSubmitted: (value) {
              fieldFocusChange(context, _focusEmail, _focusPassword);
            },
          ),
          TextFieldBlocBuilder(
            textFieldBloc: bloc.password,
            keyboardType: TextInputType.text,
            suffixButton: SuffixButton.obscureText,
            decoration: Styles.inputDecorator(_theme.palette, label: "Contraseña"),
            textInputAction: TextInputAction.next,
            focusNode: _focusPassword,
            onSubmitted: (value) {
              fieldFocusChange(context, _focusPassword, _focusConfirmPassword);
            },
          ),
          TextFieldBlocBuilder(
            textFieldBloc: bloc.confirmPassword,
            keyboardType: TextInputType.text,
            suffixButton: SuffixButton.obscureText,
            decoration: Styles.inputDecorator(_theme.palette, label: "Confirmar contraseña"),
            textInputAction: TextInputAction.done,
            focusNode: _focusConfirmPassword,
            onSubmitted: (value) {
              fieldFocusChange(context, _focusConfirmPassword);
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _header() {
    return [
      Align(
        alignment: Alignment.center,
        child: Image.asset(
          "assets/images/logo.png",
          width: screenWidth(context) * 0.5,
        ),
      ),
      SizedBox(height: screenHeight(context) * 0.02),
      Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: screenWidth(context) * 0.31,
          child: GFTypography(
            text: "Regístrate!",
            textColor: GFColors.DARK.withOpacity(0.7),
            type: GFTypographyType.typo1,
            dividerAlignment: Alignment.center,
            dividerColor: GFColors.PRIMARY,
          ),
        ),
      ),
    ];
  }
}
