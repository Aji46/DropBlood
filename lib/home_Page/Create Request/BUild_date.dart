import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BuildItems extends StatefulWidget {
  BuildItems({Key? key}) : super(key: key);

  final List<String> bloodGroupOptions = [
    "A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-", "INRA"
  ];

  final TextEditingController dateController = TextEditingController();
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final CollectionReference request = FirebaseFirestore.instance.collection('Request');

  @override
  _BuildItemsState createState() => _BuildItemsState();
}

class _BuildItemsState extends State<BuildItems> {
  String? bloodGroup;

  Widget _buildDateField() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: widget.dateController,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          fillColor: Colors.white,
          filled: true,
          labelText: "Date: yyyy-MM-dd",
          labelStyle: TextStyle(color: Colors.black),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Value is Empty';
          }
          try {
            widget.dateFormat.parse(value);
          } catch (e) {
            return 'Invalid date format';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          fillColor: Colors.white,
          filled: true,
          labelText: "Blood Group",
          labelStyle: TextStyle(color: Colors.black),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: bloodGroup,
            onChanged: (String? newValue) {
              setState(() {
                bloodGroup = newValue;
              });
            },
            items: widget.bloodGroupOptions.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          _buildDateField(),
          _buildDropdown(),
          // Additional widgets can be added here
        ],
      ),
    );
  }
}
