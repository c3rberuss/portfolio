import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:megalibreria/src/blocs/categories/bloc.dart';
import 'package:megalibreria/src/blocs/order/order_state.dart';
import 'package:megalibreria/src/blocs/profile/bloc.dart';
import 'package:megalibreria/src/models/args/location_picker_args.dart';
import 'package:megalibreria/src/presentation/screens/branch_offices_screen.dart';
import 'package:megalibreria/src/presentation/screens/finish_order_screen.dart';
import 'package:megalibreria/src/presentation/screens/home_screen.dart';
import 'package:megalibreria/src/presentation/screens/location_picker_screen.dart';
import 'package:megalibreria/src/presentation/screens/login_screen.dart';
import 'package:megalibreria/src/presentation/screens/order_resume_screen.dart';
import 'package:megalibreria/src/presentation/screens/orders_screen.dart';
import 'package:megalibreria/src/presentation/screens/products_screen.dart';
import 'package:megalibreria/src/presentation/screens/profile_screen.dart';
import 'package:megalibreria/src/presentation/screens/register_screen.dart';
import 'package:megalibreria/src/repositories/auth_repository.dart';
import 'package:megalibreria/src/repositories/auth_repository_impl.dart';
import 'package:megalibreria/src/repositories/data_repository.dart';
import 'package:megalibreria/src/repositories/data_repository_impl.dart';
import 'package:megalibreria/src/repositories/network_repository.dart';
import 'package:megalibreria/src/repositories/preferences_repository.dart';
import 'package:megalibreria/src/repositories/preferences_repository_impl.dart';
import 'package:megalibreria/src/repositories/theme_repository.dart';
import 'package:megalibreria/src/repositories/user_repository.dart';
import 'package:megalibreria/src/repositories/user_repository_impl.dart';
import 'package:megalibreria/src/utils/constants.dart';
import 'package:megalibreria/src/utils/screen_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'blocs/categories/categories_bloc.dart';
import 'blocs/home/home_bloc.dart';
import 'blocs/order/bloc.dart';
import 'blocs/orders_user/bloc.dart';
import 'blocs/products/products_bloc.dart';
import 'blocs/profile/profile_bloc.dart';

class App extends StatelessWidget {
  final themeRepository = ThemeRepository();
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final PreferencesRepositoryImpl preferences;
  final NetworkRepository network;
  final textStyle = TextStyle(color: Colors.grey.withOpacity(0.5));

  App({this.preferences})
      : this.network = NetworkRepository(baseUrl: BASE_URL, preferences: preferences);

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PreferencesRepository>(
          create: (BuildContext context) {
            return this.preferences;
          },
        ),
        RepositoryProvider<NetworkRepository>(
          create: (BuildContext context) {
            return network;
          },
        ),
        RepositoryProvider<ThemeRepository>(
          create: (BuildContext context) {
            return themeRepository;
          },
        ),
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepositoryImpl(
            preferences,
            network,
            _fcm,
          ),
        ),
        RepositoryProvider<UserRepository>(
          create: (_) => UserRepositoryImpl(network),
        ),
        RepositoryProvider<DataRepository>(
          create: (BuildContext context) {
            return DataRepositoryImpl(network);
          },
        ),
        RepositoryProvider<GlobalKey<ScaffoldState>>(
          create: (context) => GlobalKey<ScaffoldState>(),
        )
        //more repositories
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
            create: (BuildContext context) {
              return HomeBloc();
            },
          ),
          BlocProvider<ProfileBloc>(
            create: (BuildContext context) {
              return ProfileBloc(context.repository<UserRepository>());
            },
          ),
          BlocProvider<CategoriesBloc>(
            create: (BuildContext context) {
              return CategoriesBloc(context.repository<DataRepository>());
            },
          ),
          BlocProvider<ProductsBloc>(
            create: (BuildContext context) {
              return ProductsBloc(
                context.repository<DataRepository>(),
                context.repository<UserRepository>(),
              );
            },
          ),
          BlocProvider<OrderBloc>(
            create: (BuildContext context) {
              return OrderBloc(context.repository<UserRepository>());
            },
          ),
          BlocProvider<OrdersUserBloc>(
            create: (BuildContext context) {
              return OrdersUserBloc(context.repository<UserRepository>());
            },
          ),
/*          BlocProvider<StoresBloc>(
            create: (BuildContext context) {
              return StoresBloc(context.repository<DataRepository>());
            },
          ),
          BlocProvider<ProductsBloc>(
            create: (BuildContext context) {
              return ProductsBloc(context.repository<DataRepository>());
            },
          BlocProvider<DetailBloc>(
            create: (BuildContext context) {
              return DetailBloc(themeRepository.palette, context);
            },
          ),
          BlocProvider<AddressesBloc>(
            create: (BuildContext context) {
              return AddressesBloc(context.repository<UserRepository>());
            },
          ),
          BlocProvider<NotificationsBloc>(
            create: (ctx) => NotificationsBloc(),
          ),
          */
        ],
        child: RefreshConfiguration(
          headerBuilder: () => WaterDropHeader(
            complete: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.check, color: Colors.grey.withOpacity(0.8)),
                SizedBox(width: 8),
                Text("Se actualizaron los datos", style: textStyle)
              ],
            ),
            waterDropColor: themeRepository.palette.primary,
          ),
          footerBuilder: () => ClassicFooter(
            loadingText: "Cargando...",
            noDataText: "Ya no hay más datos",
            canLoadingText: "Cargar más",
            idleText: "Deslice para cargar más",
            failedText: "No se pudieron cargar más datos",
          ),
          enableScrollWhenRefreshCompleted: true,
          //This property is incompatible with PageView and TabBarView. If you need TabBarView to slide left and right, you need to set it to true.
          enableLoadingWhenFailed: true,
          //In the case of load failure, users can still trigger more loads by gesture pull-up.
          hideFooterWhenNotFull: false,
          // Disable pull-up to load more functionality when Viewport is less than one screen
          enableBallisticLoad: true,
          // trigger load more by BallisticScrollActivity
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeRepository.theme,
            home: Builder(
              builder: (context) {
                return SplashScreen.callback(
                  name: 'assets/animations/library.flr',
                  backgroundColor: context.repository<ThemeRepository>().palette.white,
                  startAnimation: 'Animations',
                  loopAnimation: 'Animations',
                  endAnimation: 'Animations',
                  height: screenHeight(context),
                  width: screenWidth(context),
                  until: () async {
                    final repo = RepositoryProvider.of<AuthRepository>(context);

                    String initialRoute = "/home";

                    try {
                      final response = await repo.verify();

                      //init session
                      context.bloc<ProfileBloc>().add(InitSessionEvent(response.data));

                      //get categories
                      context.bloc<CategoriesBloc>().add(FetchCategoriesEvent());

                      print(response);
                    } on DioError catch (error) {
                      if (error.type == DioErrorType.DEFAULT) {
                        //await noInternetConnection(context);
                      }
                      initialRoute = "/auth";
                    }

                    return Future.value(initialRoute);
                  },
                  onError: (error, stacktrace) {
                    print(error);
                    Navigator.pushNamedAndRemoveUntil(context, "/auth", (r) => false);
                  },
                  onSuccess: (data) {
                    Navigator.pushNamedAndRemoveUntil(context, data, (r) => false);
                  },
                );
              },
            ),
            routes: {
              "/home": (context) => HomeScreen(),
              "/auth": (context) => LoginScreen(),
              "/signup": (context) => RegisterScreen(),
              "/products": (context) => ProductsScreen(),
              "/offices": (context) => BranchOfficesScreen(),
              "/resume": (context) => OrderResumeScreen(),
              "/profile": (context) => ProfileScreen(),
              "/orders": (context) => OrdersScreen(),
              "finish": (context) => FinishOrderScreen(),
              "/locationPicker": (context) {
                return LocationPicker(ModalRoute.of(context).settings.arguments);
              },
            },
          ),
        ),
      ),
    );
  }
}
