import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Doner_view/request_view/Request_view.dart';
import 'package:reddrop/Register_page/registerlogin.dart';
import 'package:reddrop/Settings_page/settings_page_home.dart';
import 'package:reddrop/home_Page/Home.dart';
import 'package:reddrop/home_Page/Create%20Request/create_request.dart';
import 'package:reddrop/home_Page/home%20grid.dart';
import 'package:share/share.dart';

class Request extends StatefulWidget {
  const Request({Key? key}) : super(key: key);

  @override
  State<Request> createState() => _HomeGridState();
}

class _HomeGridState extends State<Request> {
  final CollectionReference Request =
      FirebaseFirestore.instance.collection('Request');

  List<String> items = List.generate(50, (index) => 'Item $index');
  late DocumentSnapshot requestSnap;

  int _currentIndex = 1;

  void shareContact(String contactDetails) {
    Share.share(contactDetails, subject: 'Contact Information');
  }

Future<void> deleteOldRequests() async {
  final specificDate = requestSnap['date'];

 
  final QuerySnapshot<Map<String, dynamic>> oldRequests =
      await Request.where('timestamp', isLessThan: specificDate).get()
          as QuerySnapshot<Map<String, dynamic>>;


  for (final QueryDocumentSnapshot<Map<String, dynamic>> doc
      in oldRequests.docs) {
    await doc.reference.delete();
  }
}


  @override
  void initState() {
    super.initState();
    deleteOldRequests();
}
  @override
  Widget build(BuildContext context) {
    
    return Stack(
      children: [
        // const Background_Image(),
        Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            height: 50,
            backgroundColor: Colors.white,
            color: const Color.fromARGB(255, 104, 41, 41),
            animationDuration: const Duration(milliseconds: 200),
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
              Container(
                height: 130,
                width: 200,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 255, 255, 255),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(97, 19, 82, 153),
                      blurRadius: 20,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (ctx) => const Createrequest(),
                        ));
                      },
                      child: const Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(left:15.0),
                          child: Text(
                            'Create a Request',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 19, 82, 153)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: Request.orderBy('timestamp', descending: true).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
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
                        child: ListView.separated(
                          itemCount: snapshot.data!.docs.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 1),
                          itemBuilder: (context, index) {
                            final DocumentSnapshot requestSnap =
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
                                          builder: (ctx) => ViewRequest(
                                            arguments: {
                                              'name': requestSnap['name'],
                                              'date': requestSnap['date'],
                                              
                                              'phone': requestSnap['phone']
                                                  .toString(),
                                              'group': requestSnap['group'],
                                              'hospital':
                                                  requestSnap['hospital'],
                                              'district':
                                                  requestSnap['district'],
                                              'state': requestSnap['state'],

                                              'id': requestSnap.id,
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
                                            requestSnap['group'] as String? ??
                                                '',
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
                                                requestSnap['name']
                                                        as String? ??
                                                    '',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                requestSnap['district'].toString(),
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
                                                    '${requestSnap['name'] as String? ?? ''} ${requestSnap['phone']}');
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
