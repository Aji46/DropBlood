import 'package:cloud_firestore/cloud_firestore.dart';

class DonorRepository {
  static Stream<List<DocumentSnapshot>> fetchDonorsByGroup(String bloodGroup) {
    final CollectionReference donor = FirebaseFirestore.instance.collection('Donor');
    return (bloodGroup.isNotEmpty
            ? donor.where('group', isEqualTo: bloodGroup)
            : donor)
        .orderBy('name')
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }
}
