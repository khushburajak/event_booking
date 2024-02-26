import 'package:event_booking/models/event.dart';
import 'package:event_booking/models/profile.dart';
import 'package:event_booking/repository/event_repositories.dart';
import 'package:event_booking/repository/profile_repository.dart';
import 'package:event_booking/response/get_event_response.dart';
import 'package:event_booking/response/profile_response.dart';
import 'package:event_booking/shared_preferences/jwt_auth_token.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  TabController? tabController;
  int selectedIndex = 0;
  var myMenuItems = <String>[
    'Home',
    'Edit Profile',
    'Setting',
  ];

  var listImage = [
    "https://i.pinimg.com/originals/aa/eb/7f/aaeb7f3e5120d0a68f1b814a1af69539.png",
    "https://cdn.fnmnl.tv/wp-content/uploads/2020/09/04145716/Stussy-FA20-Lookbook-D1-Mens-12.jpg",
    "https://www.propermag.com/wp-content/uploads/2020/03/0x0-19.9.20_18908-683x1024.jpg",
    "https://i.pinimg.com/originals/95/0f/4d/950f4df946e0a373e47df37fb07ea1f9.jpg",
    "https://i.pinimg.com/736x/c4/03/c6/c403c63b8e1882b6f10c82f601180e2d.jpg",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder<ProfileResponse?>(
              future: ProfileRepository().getProfile(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data != null) {
                    List<Profile> profile = snapshot.data!.profiles!;

                    return Card(
                        elevation: 5,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 35.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/navigation');
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back_ios,
                                      size: 20.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 80,
                                  ),
                                  Text(
                                    profile.single.facebook!,
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 19,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.settings,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/settings');
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.logout,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          Authcontroller.removeAuthToken();
                                          Navigator.pushNamed(
                                              context, '/login');
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            CircleAvatar(
                                radius: 70,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1,
                                      style: BorderStyle.solid,
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        profile[0].avatar!.replaceAll(
                                            '127.0.0.0', '192.168.1.101'),
                                        scale: 1.0,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )),
                            const SizedBox(height: 10.0),
                            Text(
                              "@${profile.single.linkedin!}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20.0,
                              ),
                            ),
                            // added the tab bar to the scaffold
                            const SizedBox(
                              height: 30.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const SizedBox(width: 20.0),
                                Column(
                                  children: [
                                    const Text(
                                      "29",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(
                                      "Following",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.3),
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w100),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      "121.9k",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(
                                      "Followers",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.3),
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      "7.5M",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(
                                      "Like",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.3),
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 20.0),
                              ],
                            ),
                            const SizedBox(height: 20.0),

                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/editProfile',
                                      arguments: profile);
                                },
                                child: const Text('Update Profile')),
                            const SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TabBar(
                                  isScrollable: true,
                                  controller: tabController,
                                  indicator: const BoxDecoration(
                                      borderRadius: BorderRadius.zero),
                                  labelColor: Colors.black,
                                  labelStyle: const TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                  unselectedLabelColor: Colors.black26,
                                  onTap: (tapIndex) {
                                    setState(() {
                                      selectedIndex = tapIndex;
                                    });
                                  },
                                  tabs: const [
                                    Tab(text: "Story"),
                                    Tab(text: "Attending Events"),
                                    Tab(text: "Organized Events"),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Expanded(
                              child: TabBarView(
                                controller: tabController,
                                children: [
                                  GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            mainAxisExtent: 250.0,
                                            crossAxisCount: 3),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  listImage[index]),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: listImage.length,
                                  ),
                                  // event purchased by user
                                  Center(
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.6,
                                      width: double.infinity,
                                      child: FutureBuilder<EventResponse?>(
                                        future:
                                            EventRepository().attendingEvent(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            if (snapshot.data != null) {
                                              List<Event> lstEventCategory =
                                                  snapshot.data!.events!;

                                              return ListView.builder(
                                                itemCount: snapshot
                                                    .data!.events!.length,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          '/attenddetails',
                                                          arguments:
                                                              lstEventCategory[
                                                                  index]);
                                                    },
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            width:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    10),
                                                              ),
                                                              border:
                                                                  Border.all(
                                                                color: const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    55,
                                                                    80,
                                                                    92),
                                                                width: 2,
                                                              ),
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                const SizedBox(
                                                                  height: 170,
                                                                ),
                                                                Text(
                                                                  lstEventCategory[
                                                                          index]
                                                                      .title!,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          width:
                                                              double.infinity,
                                                          height: 170,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            border: Border.all(
                                                              color: const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  55,
                                                                  80,
                                                                  92),
                                                              width: 2,
                                                            ),
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  NetworkImage(
                                                                lstEventCategory[
                                                                        index]
                                                                    .eventImage!
                                                                    .replaceAll(
                                                                        '127.0.0.0',
                                                                        '192.168.1.101'),
                                                              ),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              ListTile(
                                                                leading:
                                                                    CircleAvatar(
                                                                        child:
                                                                            Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Colors
                                                                          .grey,
                                                                      width: 1,
                                                                      style: BorderStyle
                                                                          .solid,
                                                                    ),
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          NetworkImage(
                                                                        lstEventCategory[index].eventImage!.replaceAll(
                                                                            '127.0.0.0',
                                                                            '192.168.1.101'),
                                                                      ),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                )),
                                                                title: Text(
                                                                  lstEventCategory[
                                                                          index]
                                                                      .title!,
                                                                  style: const TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                                ),
                                                                trailing:
                                                                    CircleAvatar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .indigo,
                                                                  child:
                                                                      IconButton(
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .bookmark_add_outlined),
                                                                    onPressed:
                                                                        () {},
                                                                  ),
                                                                ),
                                                              ),
                                                              ListTile(
                                                                leading:
                                                                    CircleAvatar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .indigo,
                                                                  child:
                                                                      IconButton(
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .favorite),
                                                                    onPressed:
                                                                        () {},
                                                                  ),
                                                                ),
                                                                trailing:
                                                                    CircleAvatar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .indigo,
                                                                  child:
                                                                      IconButton(
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .share_rounded),
                                                                    onPressed:
                                                                        () {},
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            } else {
                                              return Center(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pushNamed(context,
                                                        '/editProfile');
                                                  },
                                                  child: const Text(
                                                      'Edit Profile'),
                                                ),
                                              );
                                            }
                                          } else if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          } else if (snapshot.hasError) {
                                            return Text("${snapshot.error}");
                                          } else {
                                            return Center(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context, '/editProfile');
                                                },
                                                child:
                                                    const Text('Edit Profile'),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  // User Event i.e. Events that user has created by User
                                  Center(
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.6,
                                      width: double.infinity,
                                      child: FutureBuilder<EventResponse?>(
                                        future:
                                            EventRepository().getEventsByUser(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            if (snapshot.data != null) {
                                              List<Event> lstEventCategory =
                                                  snapshot.data!.events!;

                                              return ListView.builder(
                                                itemCount: snapshot
                                                    .data!.events!.length,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          '/userEventDetails',
                                                          arguments:
                                                              lstEventCategory[
                                                                  index]);
                                                    },
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            width:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    10),
                                                              ),
                                                              border:
                                                                  Border.all(
                                                                color: const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    55,
                                                                    80,
                                                                    92),
                                                                width: 2,
                                                              ),
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                const SizedBox(
                                                                  height: 170,
                                                                ),
                                                                Text(
                                                                  lstEventCategory[
                                                                          index]
                                                                      .title!,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          width:
                                                              double.infinity,
                                                          height: 170,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            border: Border.all(
                                                              color: const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  55,
                                                                  80,
                                                                  92),
                                                              width: 2,
                                                            ),
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  NetworkImage(
                                                                lstEventCategory[
                                                                        index]
                                                                    .eventImage!
                                                                    .replaceAll(
                                                                        '127.0.0.0',
                                                                        '192.168.1.101'),
                                                              ),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              ListTile(
                                                                leading:
                                                                    CircleAvatar(
                                                                        child:
                                                                            Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Colors
                                                                          .grey,
                                                                      width: 1,
                                                                      style: BorderStyle
                                                                          .solid,
                                                                    ),
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          NetworkImage(
                                                                        lstEventCategory[index].eventImage!.replaceAll(
                                                                            '127.0.0.0',
                                                                            '192.168.1.101'),
                                                                      ),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                )),
                                                                title: Text(
                                                                  lstEventCategory[
                                                                          index]
                                                                      .title!,
                                                                  style: const TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                                ),
                                                                trailing:
                                                                    CircleAvatar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .indigo,
                                                                  child:
                                                                      IconButton(
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .bookmark_add_outlined),
                                                                    onPressed:
                                                                        () {},
                                                                  ),
                                                                ),
                                                              ),
                                                              ListTile(
                                                                leading:
                                                                    CircleAvatar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .indigo,
                                                                  child:
                                                                      IconButton(
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .favorite),
                                                                    onPressed:
                                                                        () {},
                                                                  ),
                                                                ),
                                                                trailing:
                                                                    CircleAvatar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .indigo,
                                                                  child:
                                                                      IconButton(
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .share_rounded),
                                                                    onPressed:
                                                                        () {},
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            } else {
                                              return Center(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pushNamed(context,
                                                        '/editProfile');
                                                  },
                                                  child: const Text(
                                                      'Edit Profile'),
                                                ),
                                              );
                                            }
                                          } else if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          } else if (snapshot.hasError) {
                                            return Text("${snapshot.error}");
                                          } else {
                                            return Center(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context, '/editProfile');
                                                },
                                                child:
                                                    const Text('Edit Profile'),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ));
                  } else {
                    return Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/editProfile');
                        },
                        child: const Text('Edit Profile'),
                      ),
                    );
                  }
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else {
                  return Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/editProfile');
                      },
                      child: const Text('Edit Profile'),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Select the Image source'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ElevatedButton.icon(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
            label: const Text('Close'),
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Camera'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Gallery'),
        ),
      ],
    );
  }
}
