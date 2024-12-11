import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Doner_view/Donor_view/Doner_view.dart';
import 'package:reddrop/home_Page/bloodgrrops/widgets/utils.dart';


class DonorItem extends StatelessWidget {
  final DocumentSnapshot donorData;

  const DonorItem({Key? key, required this.donorData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ViewDonor(
              arguments: {
                'name': donorData['name'],
                'phone': donorData['phone'].toString(),
                'group': donorData['group'],
                'place': donorData['place'],
                'id': donorData.id,
              },
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 10)],
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text(
                donorData['group'] ?? '',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              donorData['name'] ?? '',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(donorData['place'] ?? ''),
            trailing: IconButton(
              icon: const Icon(Icons.call, color: Colors.green),
              onPressed: () => Utils.makeCall(donorData['phone'].toString()),
            ),
          ),
        ),
      ),
    );
  }
}
