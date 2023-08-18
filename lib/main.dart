import 'package:chuss/Customer-side/CustomerNav/CustomerNavigationbar.dart';
import 'package:chuss/Customer-side/Home/components/Location_provider.dart';
import 'package:chuss/Technician_side/TechHome/Components/TechNavigationBar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:chuss/splashscreen/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'Themes/app_theme.dart';
import 'components/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => LocationProvider(),
          ),
        ],
        child: MaterialApp(
          home:Phoenix(child: MyApp()),
          builder: EasyLoading.init(),
        )),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'CHUSS',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        home: UserManager(),
        routes: routes);
  }
}

class UserManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            var currentUserph = FirebaseAuth.instance.currentUser.phoneNumber;
            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('UserData')
                  .doc(currentUserph)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Material(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  default:
                    return checkRole(snapshot.data);
                }
              },
            );
          } else
            return SplashScreen();
        });
  }

  checkRole(DocumentSnapshot snapshot) {
    if (snapshot['Role'] == 'Technician') {
      return TechNavigationBar();
    } else {
      return CustomerNavigationBar();
    }
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}
