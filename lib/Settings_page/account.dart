// ignore: file_names
import 'package:flutter/material.dart';

import '../widget/widget.dart';

class SettingsAccount extends StatefulWidget {
  const SettingsAccount({Key? key}) : super(key: key);

  @override
  State<SettingsAccount> createState() => _SettingsAccountState();
}

class _SettingsAccountState extends State<SettingsAccount> {
  final _usernameController = TextEditingController();
  // ignore: unused_field
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _districtController = TextEditingController();
  final _placeController = TextEditingController();
  final _stateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // ignore: non_constant_identifier_names
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Background_Image(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
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
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: TextButton(onPressed: (){
                    showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Are You Sure To Deactivate Your Profile '),
                  actions: [
                TextButton(
                  onPressed: () {
                  
                    Navigator.of(context).pop(); 
                  
                  },
                  child: Text('OK'),
                ),
                TextButton(
                  onPressed: () {
               
                    Navigator.of(context).pop(); 
                  
                  },
                  child: Text('Cancel'),
                ),
              ],
                  
                );
              },
            );
                }, child: Text('Deactivate You profile',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),))
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10,
                      // spreadRadius: 15,
                    )
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: 'Username',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {},
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Container(
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
                                labelText: "Blood Group",
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
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
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
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: 'Phone',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Add your edit button logic here
                              print('Edit button pressed for Phone');
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _placeController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          labelText: 'Place',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Add your edit button logic here
                              print('Edit button pressed for Phone');
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'place is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _districtController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          labelText: 'District',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Add your edit button logic here
                              print('Edit button pressed for Phone');
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'district is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _stateController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          labelText: 'State',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Add your edit button logic here
                              print('Edit button pressed for Phone');
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'state is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10,),
                     ElevatedButton(
  onPressed: () {
    if (_formKey.currentState?.validate() ?? false) {
      // Form is valid, perform the necessary actions
    }
  },
   style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(204, 243, 33, 33)), // Background color
    elevation: MaterialStateProperty.all<double>(10.0), // Elevation
    textStyle: MaterialStateProperty.all<TextStyle>(
      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    ), // Text style
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      EdgeInsets.all(15.0),
    ), // Padding
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    ), // Shape
  ),
  child: const Text('Save'),
  
  
),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
