import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:personal_pjt/actions/auth/auth_action.dart';
import 'package:personal_pjt/data/api/api_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:personal_pjt/data/app_repository.dart';
import 'package:personal_pjt/data/preference_client.dart';
import 'package:personal_pjt/middleware/middleware.dart';
import 'package:personal_pjt/models/models.dart';
import 'package:personal_pjt/reducers/reducers.dart';
import 'package:personal_pjt/theme.dart';
import 'package:personal_pjt/views/init_page.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
const _kTestingCrashlytics = true;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final AppRepository repository = AppRepository(
      preferencesClient: PreferencesClient(prefs: prefs),
      config: ApiRoutes.debugConfig);
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();
  String? token=await FirebaseMessaging.instance.getToken();
  print(token);
  runZonedGuarded(() {
    runApp(MyApp(repository: repository));
  }, FirebaseCrashlytics.instance.recordError);
}

class MyApp extends StatefulWidget {
  MyApp({Key? key, required AppRepository repository})
      : store = Store<AppState>(
          reducer,
          middleware: middleware(repository),
          initialState: AppState.initState(),
        ),
        super(key: key);

  final Store<AppState> store;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {

    }
  }

  late Store<AppState> store;
  late Future<void> _initializeFlutterFireFuture;

  @override
  void initState() {
    setupInteractedMessage();
    super.initState();
    store = widget.store;
    _init();
    _initializeFlutterFireFuture = _initializeFlutterFire();
    WidgetsBinding.instance!.addObserver(this);
  }

  void _init() {
    Future<void>.delayed(Duration(seconds: 2), () {
      store.dispatch(new CheckForUserInPrefs());
    });
  }
  Future<void> _initializeFlutterFire() async {
    if (_kTestingCrashlytics) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    } else {
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(!kDebugMode);
    }
    FlutterExceptionHandler? originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      originalOnError!(errorDetails);
    };
  }
  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        navigatorKey: store.state.navigator,
        title: 'MyApp',
        theme: themeData,
        home: InitPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
