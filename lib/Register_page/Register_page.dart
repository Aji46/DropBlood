// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Register_page/registerlogin.dart';
import 'package:reddrop/home_Page/Home.dart';
import 'package:reddrop/home_Page/home%20grid.dart';

class RegisterPage extends StatefulWidget {
   RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _Register_pageState();
}

class _Register_pageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _districtController = TextEditingController();
  final _placeController = TextEditingController();
  final _stateController = TextEditingController();
  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  String? BloodGroup;
  List<String> bloodGroupOptions = [
    "A+",
    "A-",
    "B+",
    "B-",
    "O+",
    "O-",
    "AB+",
    "AB-",
    "INRA"
  ];

  int _currentIndex = 2;
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('Donor');



  Future<void> registerUser(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Assuming you have a User object after registration
      User? user = auth.currentUser;

      // Assuming you have these variables defined somewhere
      // String? name, phone, district, place, state, group;

      // Assuming you have a Firestore instance initialized
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Assuming 'users' is your collection in Firestore
      CollectionReference donor = firestore.collection('Donor');

      // Now you can add user data to Firestore
      await donor.doc(user?.uid).set({
        'name': _usernameController.text,
        'phone': _phoneController.text,
        'password': _passwordController.text,
        'district': _districtController.text,
        'place': _placeController.text,
        'state': _stateController.text,
        'group': BloodGroup,
      });

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => register_login(), // Change this to your login page
        ),
      );
    } catch (e) {
      print("Error during registration: $e");
      // Handle registration errors
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          print("User already exists. Try to log in");
          // You can show an alert or a message here
        }
      }
    }
  }




  

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            height: 50,
            backgroundColor: Colors.white,
            color: Color.fromARGB(255, 104, 41, 41),
            animationDuration: Duration(milliseconds: 200),
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });

              // Perform navigation based on the selected index
              if (index == 0) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => Home_search(),
                  ),
                );
              } else if (index == 1) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => HomeGrid(),
                  ),
                );
              } else if (index == 2) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => RegisterPage(),
                  ),
                );
              }
            },
            items: [
              Icon(Icons.bloodtype, color: Colors.white),
              Icon(Icons.home, color: Colors.white),
              Icon(Icons.account_circle, color: Colors.white),
            ],
            index: _currentIndex,
          ),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
          body: SafeArea(
            child: Form(
               key: _formKey,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 255, 120, 120),
                              blurRadius: 10,
                              // spreadRadius: 15,
                            )
                          ]),
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "Username",labelStyle: TextStyle(color: Colors.black)
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Value is Empty';
                          }else{
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 255, 120, 120),
                              blurRadius: 10,
                              // spreadRadius: 15,
                            )
                          ]),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "e_mail",labelStyle: TextStyle(color: Colors.black)
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Value is Empty';
                          }else{
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 30, left: 30),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 255, 120, 120),
                              blurRadius: 10,
                              // spreadRadius: 15,
                            )
                          ]),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "Blood Group",labelStyle: TextStyle(color: Colors.black)
                            ),
                            child: DropdownButton<String>(
                              value: BloodGroup,
                              onChanged: (String? newValue) {
                                setState(() {
                                  BloodGroup = newValue;
                                });
                                state.didChange(newValue);
                              },
                              items: bloodGroupOptions
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          );
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a blood group';
                          } 
                           return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 255, 120, 120),
                              blurRadius: 10,
                              // spreadRadius: 15,
                            )
                          ]),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "Password",labelStyle: TextStyle(color: Colors.black)
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Value is Empty';
                          }
                           return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 255, 120, 120),
                              blurRadius: 10,
                              // spreadRadius: 15,
                            )
                          ]),
                      child: TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "Phone Number",labelStyle: const TextStyle(color: Colors.black)
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Value is Empty';
                          }
                           return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 255, 120, 120),
                              blurRadius: 10,
                              // spreadRadius: 15,
                            )
                          ]),
                      child: TextFormField(
                        controller: _placeController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "Place",labelStyle: TextStyle(color: Colors.black)
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Value is Empty';
                          }
                           return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 255, 120, 120),
                              blurRadius: 10,
                              // spreadRadius: 15,
                            )
                          ]),
                      child: TextFormField(
                        controller: _districtController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "District",labelStyle: TextStyle(color: Colors.black)
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Value is Empty';
                          }
                           return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 255, 120, 120),
                              blurRadius: 10,
                              // spreadRadius: 15,
                            )
                          ]),
                      child: TextFormField(
                        controller: _stateController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "State",labelStyle: TextStyle(color: Colors.black,)
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Value is Empty';
                          }
                           return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Row(
                      children: [
                      ElevatedButton(
                  onPressed: ()  {
    if (_formKey.currentState?.validate() == true) {
      registerUser(_emailController.text, _passwordController.text);
   
    }
  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red),
                  ),
                  child: const Text('Submit'),
                ),
                        TextButton(
                          onPressed: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (ctx) => const HomeGrid()));

                                 Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const register_login()));
                          },
                          child: const Text(
                            'All ready have an account',
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
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
