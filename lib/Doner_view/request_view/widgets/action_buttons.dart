import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class ActionButtons extends StatelessWidget {
  final String phoneNumber;

  const ActionButtons({Key? key, required this.phoneNumber}) : super(key: key);

  void makeCall() async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void shareContact() {
    Share.share(phoneNumber, subject: 'Contact Information');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            iconSize: 45,
            icon: Icon(Icons.call, color: Colors.green),
            onPressed: makeCall,
            tooltip: 'Make a Call',
          ),
          IconButton(
            iconSize: 45,
            icon: Icon(Icons.share_outlined, color: Colors.blue),
            onPressed: shareContact,
            tooltip: 'Share',
          ),
        ],
      ),
    );
  }
}
