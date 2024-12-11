import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'donor_item.dart';
import 'donor_repository.dart';

class DonorList extends StatelessWidget {
  final String selectedBloodGroup;

  const DonorList({Key? key, required this.selectedBloodGroup}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DocumentSnapshot>>(
      stream: DonorRepository.fetchDonorsByGroup(selectedBloodGroup),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error loading data"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No data available"));
        }

        return ListView.separated(
          itemCount: snapshot.data!.length,
          separatorBuilder: (_, __) => const SizedBox(height: 1),
          itemBuilder: (context, index) {
            final donorData = snapshot.data![index];
            return DonorItem(donorData: donorData);
          },
        );
      },
    );
  }
}
