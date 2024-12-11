

import 'package:flutter/material.dart';

class BuildText {
 static Widget buildTextField(TextEditingController controller, String label, String errorMessage) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          fillColor: Colors.white,
          filled: true,
          labelText: label,
          labelStyle: TextStyle(color: Colors.black),
        ),
        validator: (value) => (value == null || value.isEmpty) ? errorMessage : null,
      ),
    );
  }
}
