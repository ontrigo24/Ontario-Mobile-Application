import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ontrigo/API/providers/user_provider.dart';
import 'package:ontrigo/firebase_options.dart';
import 'package:ontrigo/routes/routes.dart';
import 'package:ontrigo/screens/splash/splash.dart';
import 'package:ontrigo/utils/global_variables.dart';
import 'package:ontrigo/utils/screen_size.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        // Initialize screen size here
        ScreenSizeConfig.init(context);

        return MaterialApp(
          title: 'OntriGo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: GlobalVariables.colors.secondary),
            useMaterial3: true,
          ),
          onGenerateRoute: (routeSettings) => onGenerateRoute(routeSettings),
          initialRoute: SplashScreen.routeName,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
