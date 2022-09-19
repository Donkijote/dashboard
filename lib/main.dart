import 'package:dashboard/controllers/user_controller.dart';
import 'package:dashboard/screens/login/login_scree.dart';
import 'package:dashboard/screens/main/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'constants/global.dart';
import 'controllers/menu_controller.dart';
import 'firebase_options.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      routes: {
        '/login': (ctx) => const LoginScreen(),
        '/dashboard': (ctx) => const MainScreen()
      },
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuController(),
          ),
          ChangeNotifierProvider(
            create: (context) => UserController(),
          ),
        ],
        child: Consumer<UserController>(
          builder: (ctx, user, _) => user.isUserAuthenticated()
              ? const MainScreen()
              : const LoginScreen(),
        ),
      ),
    );
  }
}
