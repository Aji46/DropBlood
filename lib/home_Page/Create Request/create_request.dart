import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reddrop/Register_page/Register_page.dart';
import 'package:reddrop/home_Page/Create%20Request/BUild_date.dart'; // Ensure this file is correctly named
import 'package:reddrop/home_Page/Create%20Request/Build_text.dart';
import 'package:reddrop/home_Page/Create%20Request/conformation.dart';
import 'package:reddrop/home_Page/Home.dart';
import 'package:reddrop/home_Page/home%20grid.dart';
import 'package:reddrop/widget/appbar.dart';

import 'add_donor.dart'; // Ensure you import your DonorService file

class Createrequest extends StatefulWidget {
  const Createrequest({super.key});

  @override
  State<Createrequest> createState() => _CreaterequestState();
}

class _CreaterequestState extends State<Createrequest> {
  final _placeController = TextEditingController();
  final _phoneController = TextEditingController();
  final _districtController = TextEditingController();
  final _usernameController = TextEditingController();
  final _stateController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  final _formKey = GlobalKey<FormState>();
  
  // Create an instance of DonorService
  final DonorService _donorService = DonorService();
  
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        backgroundColor: Colors.white,
        color: Color.fromARGB(255, 104, 41, 41),
        animationDuration: Duration(milliseconds: 200),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // Handle navigation
          if (index == 0) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => Home_search()));
          } else if (index == 1) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => HomeGrid()));
          } else if (index == 2) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => RegisterPage()));
          }
        },
        items: [
          Icon(Icons.bloodtype, color: Colors.white),
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.account_circle, color: Colors.white),
        ],
        index: _currentIndex,
      ),
      appBar: customAppBar(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            children: [
              BuildText.buildTextField(_usernameController, "Recipient Name", "Value is Empty"),
              BuildItems(),
              
               // This should work as long as BuildItems is implemented correctly
              BuildText.buildTextField(_phoneController, "Phone Number", "Value is Empty"),
              BuildText.buildTextField(_placeController, "Hospital Name", "Value is Empty"),
              BuildText.buildTextField(_districtController, "District", "Value is Empty"),
              BuildText.buildTextField(_stateController, "State", "Value is Empty"),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      ShowConfirmationDialog.show(
                        context,
                        _usernameController.text,
                        _phoneController.text,
                        _districtController.text,
                        _donorService,
                      );
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
