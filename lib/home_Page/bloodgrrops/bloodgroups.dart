import 'package:flutter/material.dart';
import 'package:reddrop/home_Page/bloodgrrops/widgets/donor_list.dart';



class BloodDonorGroup extends StatelessWidget {
  final String selectedBloodGroup;

  const BloodDonorGroup({Key? key, required this.selectedBloodGroup}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Available $selectedBloodGroup Blood Groups'),
      ),
      body: SafeArea(
        child: DonorList(selectedBloodGroup: selectedBloodGroup),
      ),
    );
  }
}
