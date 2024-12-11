import 'package:flutter/material.dart';
import 'package:reddrop/home_Page/home%20grid.dart';
import 'package:reddrop/splash/login_for_use.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  static const String SAVE_KEY_NAME = "user_logged_in";

  @override
  void initState() {
    super.initState();
    initApp();
  }

  void initApp()  {
    checkLoginStatus();
  }

Future<void> checkLoginStatus() async {
  final sharedPref = await SharedPreferences.getInstance();
  final isLoggedIn = sharedPref.getBool(SAVE_KEY_NAME) ?? false;

  if (isLoggedIn) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => HomeGrid(),
      ),
    );
  } else {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => Login_for_use(),
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              'Red',
              style: TextStyle(
                color: Colors.red,
                fontFamily: 'Italiana',
                fontSize: screenWidth < 600 ? 20 : 24,
              ),
            ),
            Text(
              'drop',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Italiana',
                fontSize: screenWidth < 600 ? 20 : 24,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Image.asset(
                        'lib/assets/images/background1.png',
                        width: screenWidth < 600 ? 1000 : 500,
                        height: screenWidth < 600 ? 300 : 200,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Red',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 255, 0, 0),
                            fontFamily: 'Italiana',
                            fontSize: screenWidth < 600 ? 20 : 24,
                          ),
                        ),
                        TextSpan(
                          text: 'Drop ',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontFamily: 'Italiana',
                            fontSize: screenWidth < 600 ? 20 : 24,
                          ),
                        ),
                        TextSpan(
                          text: 'has 1000’s of donors all over India.',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: screenWidth < 600 ? 20 : 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: Text(
                    '‘Your life, our best’',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: screenWidth < 600 ? 24 : 32,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
