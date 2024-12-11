// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/home_Page/home%20grid.dart';
import 'package:reddrop/main.dart';
import 'package:reddrop/splash/frist_register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login_for_use extends StatefulWidget {
  const Login_for_use({super.key});

  @override
  State<Login_for_use> createState() => _Register_pageState();
}

class _Register_pageState extends State<Login_for_use> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  // final _formKey = GlobalKey<FormState>();
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('Donor');

  List<String> items = List.generate(50, (index) => 'Item $index');
  late DocumentSnapshot donorSnap;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _currentIndex = 2;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // If sign in is successful, navigate to the desired page
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const HomeGrid(),
        ),
      );
        final sharedPref1 =await SharedPreferences.getInstance();
       await sharedPref1.setBool(SAVE_KEY_NAME, true);

    } catch (e) {
      // Handle sign-in errors
      print("Error signing in: $e");
      // You can show an error message here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid email or password. Please check your credentials."),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print("Error during login: $e");
        ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("Error signing in: $e"),
      duration: Duration(seconds: 3),
    ),
  );
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
       
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            title: Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Red',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 0, 0),
                        fontFamily: 'Italiana',
                        fontSize: 24,
                      ),
                    ),
                    TextSpan(
                      text: 'Drop ',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: 'Italiana',
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Container(
            margin: const EdgeInsets.only(left: 25, right: 25),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/images/background1.png',
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Account Verification",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "We need to signin your phone with your email and Your password",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "email",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _passwordController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 153, 19, 19),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                       _signInWithEmailAndPassword();
                      },
                      child: const Text(
                        "Signup",
                        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      
                     Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => Frist_Register(),
        ),
      );

                    },
                    child: const Text(
                      "I don't have an account",
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
