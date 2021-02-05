import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stripe_sdk/stripe_sdk.dart';
import 'package:services/src/blocs/application/application_bloc.dart';
import 'package:services/src/blocs/categories/categories_bloc.dart';
import 'package:services/src/blocs/categories/categories_event.dart';
import 'package:services/src/blocs/detail/detail_bloc.dart';
import 'package:services/src/blocs/history/history_bloc.dart';
import 'package:services/src/blocs/notifications/notifications_bloc.dart';
import 'package:services/src/blocs/services/services_bloc.dart';
import 'package:services/src/blocs/user/user_bloc.dart';
import 'package:services/src/blocs/user/user_event.dart';
import 'package:services/src/presentation/screens/application_detail_screen.dart';
import 'package:services/src/presentation/screens/credit_card_screen.dart';
import 'package:services/src/presentation/screens/history_screen.dart';
import 'package:services/src/presentation/screens/home_screen.dart';
import 'package:services/src/presentation/screens/login_screen.dart';
import 'package:services/src/presentation/screens/profile_screen.dart';
import 'package:services/src/presentation/screens/resume_screen.dart';
import 'package:services/src/presentation/screens/services_screen.dart';
import 'package:services/src/presentation/screens/signup_screen.dart';
import 'package:services/src/repositories/applications_repository.dart';
import 'package:services/src/repositories/applications_repository_impl.dart';
import 'package:services/src/repositories/auth_repository.dart';
import 'package:services/src/repositories/auth_repository_impl.dart';
import 'package:services/src/repositories/network_repository.dart';
import 'package:services/src/repositories/spreferences_repository.dart';
import 'package:services/src/repositories/spreferences_repository_impl.dart';
import 'package:services/src/repositories/user_repository.dart';
import 'package:services/src/repositories/user_repository_impl.dart';
import 'package:services/src/utils/constants.dart';
import 'package:services/src/utils/screen_utils.dart';

class ServicesApp extends StatelessWidget {
  final NetworkRepository network;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final SPreferencesRepositoryImpl preferences;

  ServicesApp({
    this.preferences,
  }) : this.network = NetworkRepository(baseUrl: BASE_URL, preferences: preferences);

  // Create the router.
  final Router router = new Router();

  @override
  Widget build(BuildContext context) {
    StripeApi.init(PK);
    buildRoutes();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<NetworkRepository>(
          create: (ctx) => network,
        ),
        RepositoryProvider<SPreferencesRepository>(
          create: (_) => preferences,
        ),
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepositoryImpl(preferences, network, _fcm),
        ),
        RepositoryProvider<ApplicationsRepository>(
          create: (_) => ApplicationsRepositoryImpl(preferences, network),
        ),
        RepositoryProvider<UserRepository>(
          create: (_) => UserRepositoryImpl(network),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CategoriesBloc>(
            create: (ctx) => CategoriesBloc(ctx.repository<ApplicationsRepository>()),
          ),
          BlocProvider<ServicesBloc>(
            create: (ctx) => ServicesBloc(ctx.repository<ApplicationsRepository>()),
          ),
          BlocProvider<ApplicationBloc>(
            create: (ctx) => ApplicationBloc(preferences, ctx.repository<ApplicationsRepository>()),
          ),
          BlocProvider<UserBloc>(
            create: (ctx) => UserBloc(),
          ),
          BlocProvider<HistoryBloc>(
            create: (ctx) => HistoryBloc(ctx.repository<UserRepository>()),
          ),
          BlocProvider<NotificationsBloc>(
            create: (ctx) => NotificationsBloc(),
          ),
          BlocProvider<DetailBloc>(
            create: (ctx) => DetailBloc(ctx.repository<ApplicationsRepository>()),
          ),
        ],
        child: MaterialApp(
          title: 'Tire Services',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: Builder(builder: (context) {
            return SplashScreen.callback(
              name: 'assets/animations/loading.flr',
              backgroundColor: Colors.blue,
              startAnimation: 'loading',
              loopAnimation: 'loading',
              endAnimation: 'ending',
              height: getScreenHeight(context) * 0.46,
              width: getScreenWidth(context),
              until: () async {
                final repo = RepositoryProvider.of<AuthRepository>(context);
                // ignore: close_sinks
                final categoriesBloc = context.bloc<CategoriesBloc>();

                final val = await preferences.getBool("logged");
                print(val);

                String initialRoute = "home";

                try {
                  final response = await repo.verify();

                  context.bloc<UserBloc>().add(SaveUserEvent(response.data));
                  categoriesBloc.add(FetchDataEvent());
                } on DioError catch (error) {
                  //
                  if (error.type != DioErrorType.DEFAULT) {
                    initialRoute = "auth";
                  } else {
                    categoriesBloc.add(FetchDataEvent());
                  }
                }

                return Future.value(initialRoute);
              },
              onError: (error, stacktrace) {
                //
              },
              onSuccess: (data) {
                Navigator.pushNamedAndRemoveUntil(context, data, (r) => false);
              },
            );
          }),
          onGenerateRoute: router.generator,
        ),
      ),
    );
  }

  void buildRoutes() {
    router.define(
      'home',
      handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return new HomeScreen();
      }),
      transitionType: TransitionType.inFromRight,
    );

    router.define('auth',
        handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return LoginScreen();
    }));

    router.define('services/:categoryId',
        handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new ServicesScreen(categoryId: int.parse(params["categoryId"][0]));
    }));

    router.define('resume',
        handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new ResumeScreen();
    }));

    router.define('profile',
        handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new ProfileScreen();
    }));

    router.define('history',
        handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new HistoryScreen();
    }));

    router.define('register',
        handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new SignUpScreen();
    }));

    router.define(
      'detail',
      handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return new ApplicationDetailScreen();
      }),
    );

    router.define(
      'card',
      handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return new CreditCardScreen();
      }),
    );
  }
}
