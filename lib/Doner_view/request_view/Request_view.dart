// ignore_for_file: prefer_const_constructors, file_names
import 'package:flutter/material.dart';
import 'package:reddrop/Doner_view/request_view/widgets/action_buttons.dart';
import 'package:reddrop/Doner_view/request_view/widgets/contact_info.dart';
import 'package:reddrop/Doner_view/request_view/widgets/text_detail.dart';
import 'package:reddrop/widget/appbar.dart';

class ViewRequest extends StatelessWidget {
  const ViewRequest({super.key, required this.arguments});

  final Map<String, dynamic> arguments;

  @override
  Widget build(BuildContext context) {
    final String phoneNumber = arguments['phone'] as String;

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ContactInfoWidget(group: arguments['group'] as String),
                DetailText(title: 'Name', value: arguments['name']),
                DetailText(title: 'Blood Wanted Date', value: arguments['date']),
                DetailText(title: 'Phone', value: phoneNumber),
                ActionButtons(
                  phoneNumber: phoneNumber,
                ),
                DetailText(title: 'Hospital', value: arguments['hospital']),
                DetailText(title: 'District', value: arguments['district']),
                DetailText(title: 'State', value: arguments['state']),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
