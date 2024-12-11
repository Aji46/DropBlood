import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Register_page/registerlogin.dart';
import 'package:reddrop/Settings_page/settings_page_home.dart';
import 'package:reddrop/home_Page/Home.dart';
import 'package:reddrop/home_Page/bloodgrrops/bloodgroups.dart';
import 'package:reddrop/home_Page/request.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeGrid extends StatefulWidget {
  const HomeGrid({Key? key}) : super(key: key);

  @override
  State<HomeGrid> createState() => _HomeGridState();
}

class _HomeGridState extends State<HomeGrid> {
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('Donor');

  List<String> items = List.generate(50, (index) => 'Item $index');
  late DocumentSnapshot donorSnap;

  List<String> bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  String? selectedBloodGroup;
  final ScrollController _scrollController = ScrollController();
  bool _isVisible = true;
  int _currentIndex = 1;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      setState(() {
        _isVisible = true;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void makeCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
                child: Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.more_vert, color: Colors.black),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const Setting(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: _isVisible ? 1.0 : 0.0,
                  child: Column(
                    children: [
                      Container(
                        height: 215,
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 104, 41, 41),
                              blurRadius: 20,
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: PageView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: (bloodGroups.length ~/ 4),
                                onPageChanged: (index) {
                                  setState(() {
                                    _currentPageIndex = index;
                                  });
                                },

                                // Display 4 items at a time
                                itemBuilder: (context, index) {
                                  final firstItemIndex = index * 4;

                                  if (firstItemIndex >= bloodGroups.length) {
                                    // Prevent accessing an index that is out of range
                                    return Container();
                                  }

                                  return Padding(
                                    padding: const EdgeInsets.only(left: 30.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            BloodCard(
                                              bloodGroup:
                                                  bloodGroups[firstItemIndex],
                                              onTap: () {
                                                setState(() {
                                                  selectedBloodGroup =
                                                      bloodGroups[
                                                          firstItemIndex];
                                                });
                                              },
                                            ),
                                            const SizedBox(
                                                width:
                                                    40.0), // Adjust the width based on your preference
                                            BloodCard(
                                              bloodGroup: bloodGroups[
                                                  firstItemIndex + 1],
                                              onTap: () {
                                                setState(() {
                                                  selectedBloodGroup =
                                                      bloodGroups[
                                                          firstItemIndex + 1];
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        // Adjust the height based on your preference
                                        Row(
                                          children: [
                                            BloodCard(
                                              bloodGroup: bloodGroups[
                                                  firstItemIndex + 2],
                                              onTap: () {
                                                String selectedBloodGroup =
                                                    bloodGroups[
                                                        firstItemIndex + 2];
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        BloodDonorGroup(
                                                            selectedBloodGroup:
                                                                selectedBloodGroup),
                                                  ),
                                                );
                                              },
                                            ),
                                            const SizedBox(
                                                width:
                                                    40), // Adjust the width based on your preference
                                            BloodCard(
                                              bloodGroup: bloodGroups[
                                                  firstItemIndex + 3],
                                              onTap: () {
                                                setState(() {
                                                  selectedBloodGroup =
                                                      bloodGroups[
                                                          firstItemIndex + 3];
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      DotIndicator(
                        currentPageIndex: _currentPageIndex,
                        pageCount: (bloodGroups.length ~/ 4),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 215,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 104, 41, 41),
                      blurRadius: 20,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      height: 200,
                      width: 160,
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
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (ctx) => const Request(),
                              ));
                            },
                            child: const Text(
                              'Request for blood',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 19, 82, 153)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 200,
                      width: 160,
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 255, 255, 255),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(58, 19, 82, 153),
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
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (ctx) => const register_login(),
                              ));
                            },
                            child: const Text(
                              'I want to be a Donor',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 19, 82, 153)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DotIndicator extends StatelessWidget {
  final int currentPageIndex;
  final int pageCount;

  const DotIndicator({super.key, required this.currentPageIndex, required this.pageCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) {
          return Container(
            width: 8.0,
            height: 8.0,
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentPageIndex == index ? Colors.red : Colors.grey,
            ),
          );
        },
      ),
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
            backgroundColor: const Color.fromARGB(255, 190, 24, 24),
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
