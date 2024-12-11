import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Doner_view/Donor_view/Doner_view.dart';
import 'package:reddrop/Register_page/registerlogin.dart';
import 'package:reddrop/Settings_page/settings_page_home.dart';
import 'package:reddrop/home_Page/home%20grid.dart';
import 'package:share/share.dart';

// ignore: camel_case_types
class Home_search extends StatefulWidget {
  const Home_search({Key? key}) : super(key: key);

  @override
  State<Home_search> createState() => _HomeGridState();
}

class _HomeGridState extends State<Home_search> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('Donor');

  List<String> items = List.generate(50, (index) => 'Item $index');
  late DocumentSnapshot donorSnap;

  List<String> bloodGroups = [];
  List<String> states = [];
  List<String> district = [];
  int _currentIndex = 0;

  String? selectedState;
  String? selectedDistrict;
  String? selectedBloodGroup;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final donorSnapshot =
        await FirebaseFirestore.instance.collection('Donor').get();

    Set<String> uniqueBloodGroups = {};
    Set<String> uniqueStates = {};
    Set<String> uniqueDistricts = {};

    donorSnapshot.docs.forEach((doc) {
      uniqueBloodGroups.add(doc['group'] as String? ?? '');
      uniqueStates.add(doc['state'] as String? ?? '');
      uniqueDistricts.add(doc['district'] as String? ?? '');
    });

    setState(() {
      bloodGroups = uniqueBloodGroups.toList();
      states = uniqueStates.toList();
      district = uniqueDistricts.toList();
    });
  }

  void shareContact(String contactDetails) {
    Share.share(contactDetails, subject: 'Contact Information');
  }

  @override
  Widget build(BuildContext context) {
    fetchData();
    return Stack(
      children: [
        // const Background_Image(),
        Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            height: 50,
            backgroundColor: Colors.white,
            color: const Color.fromARGB(255, 104, 41, 41),
            animationDuration: const Duration(milliseconds: 100),
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });

              // Perform navigation based on the selected index
              if (index == 0) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => const Home_search(),
                  ),
                );
              } else if (index == 1) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => const HomeGrid(),
                  ),
                );
              } else if (index == 2) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => const register_login(),
                  ),
                );
              }
            },
            items: const [
              Icon(
                Icons.bloodtype,
                color: Colors.white,
              ),
              Icon(
                Icons.home,
                color: Colors.white,
              ),
              Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
            ],
            index: _currentIndex,
          ),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Red',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 0, 0),
                        fontFamily: 'Italiana',
                        fontSize: 24,
                      ),
                    ),
                    TextSpan(
                      text: 'Drop ',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: 'Italiana',
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  icon: const Icon(Icons.more_vert, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const Setting(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        value: selectedState,
                        hint: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Choose State',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedState = newValue;
                          });
                          getFilteredStream();
                        },
                        items: states.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    if (selectedState != null)
                      IconButton(
                        onPressed: () {
                          setState(() {
                            selectedState = null;
                          });
                          getFilteredStream();
                        },
                        icon: const Icon(Icons.clear),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        value: selectedDistrict,
                        hint: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Choose District',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDistrict = newValue;
                          });
                          getFilteredStream();
                        },
                        items: district.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    if (selectedDistrict != null)
                      IconButton(
                        onPressed: () {
                          setState(() {
                            selectedDistrict = null;
                          });
                          getFilteredStream();
                        },
                        icon: const Icon(Icons.clear),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    DropdownButton<String>(
                      value: selectedBloodGroup,
                      hint: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Choose Blood Group',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedBloodGroup = newValue;
                        });
                        getFilteredStream();
                      },
                      items: bloodGroups.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    if (selectedBloodGroup != null)
                      IconButton(
                        onPressed: () {
                          setState(() {
                            selectedBloodGroup = null;
                          });
                          getFilteredStream();
                        },
                        icon: const Icon(Icons.clear),
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: getFilteredStream(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.isEmpty) {
                        // No donors available based on the selected criteria
                        return const Center(
                          child: Text('No available donors.'),
                        );
                      }

                      return Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black),
                          color: const Color.fromARGB(255, 252, 252, 252),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 255, 255, 255),
                              blurRadius: 20,
                            )
                          ],
                        ),
                        child: AnimatedList(
                          key: _listKey,
                          initialItemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index, animation) {
                            final DocumentSnapshot donorSnap =
                                snapshot.data!.docs[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 10,
                                      )
                                    ],
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (ctx) => ViewDonor(
                                            arguments: {
                                              'name': donorSnap['name'],
                                              'phone':
                                                  donorSnap['phone'].toString(),
                                              'group': donorSnap['group'],
                                              'place': donorSnap['place'],
                                              'district': donorSnap['district'],
                                              'state': donorSnap['state'],
                                              'id': donorSnap.id,
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        CircleAvatar(
                                          backgroundColor:
                                              const Color.fromARGB(255, 190, 24, 24),
                                          radius: 30,
                                          child: Text(
                                            donorSnap['group'] as String? ?? '',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                donorSnap['name'] as String? ??
                                                    '',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                donorSnap['phone'].toString(),
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                shareContact(
                                                    '${donorSnap['name'] as String? ?? ''} ${donorSnap['phone']}');
                                              },
                                              tooltip: 'Share',
                                              icon: const Icon(
                                                  Icons.share_outlined),
                                              color: const Color.fromARGB(
                                                  255, 6, 135, 233),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Clear the existing items

  // Apply filters to the Firestore query
  Stream<QuerySnapshot> getFilteredStream() {
    // Apply filters to the Firestore query
    Query filteredQuery = donor.orderBy('name', descending: true);

    if (selectedState != null) {
      filteredQuery = filteredQuery.where('state', isEqualTo: selectedState);
    }

    if (selectedDistrict != null) {
      filteredQuery =
          filteredQuery.where('district', isEqualTo: selectedDistrict);
    }

    if (selectedBloodGroup != null) {
      filteredQuery =
          filteredQuery.where('group', isEqualTo: selectedBloodGroup);
    }

    return filteredQuery.snapshots();
  }
}

class BloodCard extends StatelessWidget {
  const BloodCard({Key? key, required this.bloodGroup, required this.onTap})
      : super(key: key);

  final String bloodGroup;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 90,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
          )
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: CircleAvatar(
            backgroundColor: Colors.red,
            radius: 30,
            child: Text(
              bloodGroup,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
