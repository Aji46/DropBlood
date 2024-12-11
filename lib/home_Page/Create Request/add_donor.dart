import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DonorService {
  // Firestore reference
  final CollectionReference request = FirebaseFirestore.instance.collection('Request');

  // Text editing controllers
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  
  String? bloodGroup; // Use a string instead of TextEditingController for blood group

  // Function to add donor data to Firestore
  Future<void> addDonor(BuildContext context) async {
    final data = {
      'name': _usernameController.text,
      'phone': _phoneController.text,
      'district': _districtController.text,
      'hospital': _placeController.text,
      'state': _stateController.text,
      'group': bloodGroup,
      'date': _dateController.text,
      'timestamp': FieldValue.serverTimestamp(),
    };

    try {
      DocumentReference documentReference = await request.add(data);
      print("Request data added with ID: ${documentReference.id}");
      Navigator.of(context).pop(); // Navigate back to previous page
    } catch (error) {
      print("Error adding request: $error");
      // Show an error dialog here (optional)
      _showErrorDialog(context, error.toString());
    }
  }

  // Method to show error dialog
  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // Dispose method for cleaning up controllers
  void dispose() {
    _usernameController.dispose();
    _phoneController.dispose();
    _districtController.dispose();
    _placeController.dispose();
    _stateController.dispose();
    _dateController.dispose();
  }
}
