import 'package:flutter/material.dart';

class ShowConfirmationDialog {
  // This method can be called from anywhere and accepts the context and controller values
  static void show(BuildContext context, String name, String phone, String district, donorService) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Make sure Given Details are correct'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: $name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text("Phone: $phone", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text("District: $district", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                // Add more details here if needed
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                donorService.addDonor(context);
                Navigator.of(context).pop();
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}
