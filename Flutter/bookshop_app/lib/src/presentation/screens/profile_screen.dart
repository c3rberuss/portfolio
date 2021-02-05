import 'package:bookshop/src/blocs/profile/bloc.dart';
import 'package:bookshop/src/blocs/profile/profile_form_bloc.dart';
import 'package:bookshop/src/models/addresses/address_model.dart';
import 'package:bookshop/src/models/args/location_picker_args.dart';
import 'package:bookshop/src/models/locations/city_model.dart';
import 'package:bookshop/src/models/locations/department_model.dart';
import 'package:bookshop/src/models/response/response_form_clasess.dart';
import 'package:bookshop/src/models/users/user_model.dart';
import 'package:bookshop/src/presentation/widgets/custom_app_bar.dart';
import 'package:bookshop/src/presentation/widgets/header.dart';
import 'package:bookshop/src/presentation/widgets/progress_dialog.dart';
import 'package:bookshop/src/repositories/theme_repository.dart';
import 'package:bookshop/src/repositories/user_repository.dart';
import 'package:bookshop/src/utils/functions.dart';
import 'package:bookshop/src/utils/screen_utils.dart';
import 'package:bookshop/src/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:getwidget/components/button/gf_button.dart';

class ProfileScreen extends StatelessWidget {
  final _name = FocusNode();
  final _lastName = FocusNode();
  final _phone = FocusNode();
  final _email = FocusNode();

  @override
  Widget build(BuildContext context) {
    final bool editProfile = ModalRoute.of(context).settings.arguments;

    return BlocProvider<ProfileFormBloc>(
      create: (_) => ProfileFormBloc(
        user: context.bloc<ProfileBloc>().state.user,
        userRepository: context.repository<UserRepository>(),
        isEditing: editProfile ?? false,
      ),
      child: FormBlocListener<ProfileFormBloc, SuccessResponse<UserModel>, FailResponse<ErrorType>>(
        onSubmitting: (context, state) {
          ProgressDialog.show(context);
        },
        onSuccess: (context, state) {
          context.bloc<ProfileBloc>().add(InitSessionEvent(state.successResponse.data));
          ProgressDialog.hide(context);
          showSuccess(context, state.successResponse.message, "Perfil");
        },
        onFailure: (context, state) {
          ProgressDialog.hide(context);
          showError(context, state.failureResponse.message, "Error");
        },
        child: Builder(
          builder: (BuildContext context) {
            // ignore: close_sinks
            final bloc = context.bloc<ProfileFormBloc>();
            final theme = context.repository<ThemeRepository>();

            return Scaffold(
              appBar: CustomAppBar(
                title: "Perfil",
                centerTitle: true,
                showCart: false,
                elevation: 0,
                showSearchButton: false,
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/icons/user.png",
                        width: screenWidth(context) * 0.25,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Header(
                            text: "Información personal",
                            color: theme.palette.primary,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: screenWidth(context) * 0.4,
                            child: SwitchFieldBlocBuilder(
                              booleanFieldBloc: bloc.editProfile,
                              body: Container(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    BlocBuilder<BooleanFieldBloc, BooleanFieldBlocState>(
                      bloc: bloc.editProfile,
                      builder: (BuildContext context, BooleanFieldBlocState<dynamic> editState) {
                        return Column(
                          children: <Widget>[
                            TextFieldBlocBuilder(
                              textFieldBloc: bloc.name,
                              isEnabled: editState.value,
                              decoration: Styles.inputDecorator(theme.palette, label: "Nombres"),
                              focusNode: _name,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              nextFocusNode: _lastName,
                            ),
                            TextFieldBlocBuilder(
                              textFieldBloc: bloc.lastName,
                              isEnabled: editState.value,
                              decoration: Styles.inputDecorator(theme.palette, label: "Apellidos"),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              focusNode: _lastName,
                              nextFocusNode: _phone,
                            ),
                            TextFieldBlocBuilder(
                              textFieldBloc: bloc.phone,
                              isEnabled: editState.value,
                              decoration: Styles.inputDecorator(theme.palette, label: "Teléfono"),
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              focusNode: _phone,
                              nextFocusNode: _email,
                            ),
                            TextFieldBlocBuilder(
                              textFieldBloc: bloc.email,
                              isEnabled: editState.value,
                              focusNode: _email,
                              decoration: Styles.inputDecorator(theme.palette, label: "Correo"),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.done,
                            ),
                            Divider(),
                            Header(
                              text: "Dirección de envío",
                              color: theme.palette.primary,
                            ),
                            CustomDialogFormBlocBuilder<AddressModel>(
                              inputFieldBloc: bloc.address,
                              animateWhenCanShow: false,
                              isEnabled: bloc.editProfile.value,
                              showSelected: (item) {
                                return item != null ? item.address : "";
                              },
                              decoration: Styles.inputDecorator(theme.palette, label: "Dirección"),
                              getValueFromDialog: () async {
                                LocationPickerArgs args = LocationPickerArgs();

                                if (bloc.address.value != null) {
                                  args = LocationPickerArgs(
                                    address: bloc.address.value.address,
                                    latitude: bloc.address.value.latitude,
                                    longitude: bloc.address.value.longitude,
                                  );
                                }

                                final response = await Navigator.pushNamed(
                                  context,
                                  "/locationPicker",
                                  arguments: args,
                                );

                                return response;
                              },
                            ),
                            SearchableListFormBlocBuilder<DepartmentModel>(
                              selectFieldBloc: bloc.department,
                              animateWhenCanShow: true,
                              isEnabled: false,
                              decoration:
                                  Styles.inputDecorator(theme.palette, label: "Departamento"),
                              showSelected: (item) {
                                return item != null ? item.name : "";
                              },
                              itemBuilder: (item, index) {
                                return Text(item.name);
                              },
                              searchCondition: (query, item) {
                                return query.toLowerCase() == item.name.toLowerCase();
                              },
                              showClearIcon: false,
                            ),
                            SearchableListFormBlocBuilder<CityModel>(
                              selectFieldBloc: bloc.city,
                              animateWhenCanShow: true,
                              isEnabled: false,
                              decoration:
                                  Styles.inputDecorator(theme.palette, label: "Ciudad/Municipio"),
                              showClearIcon: false,
                              showSelected: (item) {
                                return item != null ? item.name : "";
                              },
                              itemBuilder: (item, index) {
                                return Text(item.name);
                              },
                              searchCondition: (query, item) {
                                return query.toLowerCase() == item.name.toLowerCase();
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: BlocBuilder<BooleanFieldBloc, BooleanFieldBlocState>(
                  bloc: bloc.editProfile,
                  builder: (BuildContext context, BooleanFieldBlocState<dynamic> editState) {
                    return GFButton(
                      text: "Guardar cambios",
                      onPressed: editState.value
                          ? () {
                              bloc.submit();
                            }
                          : null,
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
