import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:manageuz/models/foto_hive_model.dart';
import 'package:manageuz/models/main_model.dart';
import 'package:manageuz/providers/get_main_data_provider.dart';
import 'package:manageuz/providers/login_provider.dart';
import 'package:manageuz/providers/foto_provider.dart';
import 'package:manageuz/screens/home_page.dart';
import 'package:manageuz/screens/loading.dart';
import 'package:manageuz/screens/login.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'providers/add_custom_provider.dart';
import 'providers/edit_custom_provider.dart';
import 'screens/add_custom.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(FotoHiveModelAdapter());
  }
  if (!Hive.isBoxOpen('foto_model')) {
    await Hive.openBox<FotoHiveModel>('foto_model');
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              LoginProvider(loginError: false, loginLoading: false),
        ),
        ChangeNotifierProvider(
          create: (context) => MainApiProvider(hududlar: [
            Category(
              name: "Barcha Hududlar",
              id: -1,
            )
          ]),
        ),
        ChangeNotifierProvider<FotoApiProvider>(
          create: (context) => FotoApiProvider(),
        ),
        ChangeNotifierProvider<AddCustomProvider>(
          create: (context) => AddCustomProvider(),
          child: CustomAdd(),
        ),
        ChangeNotifierProvider<EditCustomProvider>(
          create: (context) => EditCustomProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Manage.uz',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Loading(),
        routes: {
          '/login': (context) => const Login(),
          '/loading': (context) => const Loading(),
          '/home': (context) => const MyHomePage()
        },
      ),
    );
  }
}
