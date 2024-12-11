// view_donor.dart
import 'package:flutter/material.dart';
import 'package:reddrop/widget/appbar.dart';
import 'package:reddrop/Doner_view/Donor_view/widgets/contact_info.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';



class ViewDonor extends StatefulWidget {
  const ViewDonor({super.key, required this.arguments});
  final Map<String, dynamic> arguments;

  @override
  State<ViewDonor> createState() => _ViewerState();
}

class _ViewerState extends State<ViewDonor> {
  late String phoneNumber;

  @override
  void initState() {
    super.initState();
    phoneNumber = widget.arguments['phone'] as String;
  }

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 10)],
            ),
            child: Column(
              children: [
                CircleAvatar(
                  child: Text(
                    widget.arguments['group'] ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  radius: 60,
                  backgroundColor: Colors.red,
                ),
                ContactInfo(title: 'Name', value: widget.arguments['name'] ?? ''),
                ContactInfo(title: 'Phone', value: phoneNumber),
                ContactInfo(title: 'City', value: widget.arguments['place'] ?? ''),
                ContactInfo(title: 'District', value: widget.arguments['district'] ?? ''),
                ContactInfo(title: 'State', value: widget.arguments['state'] ?? ''),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: 45,
                      icon: Icon(Icons.call, color: Colors.green),
                      onPressed: makeCall,
                      tooltip: 'Make a Call',
                    ),
                    SizedBox(width: 40),
                    IconButton(
                      iconSize: 45,
                      icon: Icon(Icons.share_outlined, color: Colors.blue),
                      onPressed: shareContact,
                      tooltip: 'Share',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
