import 'dart:async';

import 'package:event_booking/models/event.dart';
import 'package:event_booking/models/story.dart';
import 'package:event_booking/pages/home/widget/custom_appbar.dart';
import 'package:event_booking/pages/profile/profile.dart';
import 'package:event_booking/repository/event_repositories.dart';
import 'package:event_booking/repository/story_repository.dart';
import 'package:event_booking/response/get_event_response.dart';
import 'package:event_booking/response/story_response.dart';
import 'package:event_booking/shared_preferences/jwt_auth_token.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:shake/shake.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Update Event
  _likeEvent(eventID) async {
    try {
      bool isUpdated = await EventRepository().likeEvent(eventID);
      if (isUpdated) {
        _displayMessage(true);
      } else {
        _displayMessage(false);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Display message
  _displayMessage(bool isUpdated) {
    if (isUpdated) {
      MotionToast.success(description: const Text("You Liked Event"))
          .show(context);
    } else {
      MotionToast.error(description: const Text("Already Liked")).show(context);
    }
  }

  late ShakeDetector _ShakeDetector;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  // storage: FlutterSecureStorage();
  bool _isNear = false;
  late StreamSubscription<dynamic> _streamSubscription;
  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  Future<void> listenSensor() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (foundation.kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      }
    };
    _streamSubscription = ProximitySensor.events.listen((int event) {
      setState(() {
        _isNear = (event > 0) ? true : false;
        // print('check proximity sensor');
        if (_isNear == true) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const ProfilePage();
          }));
        }
      });
    });
  }

  late ShakeDetector detector;
  @override
  void initState() {
    detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        Authcontroller.removeAuthToken();

        setState(() {
          Navigator.pushNamed(context, "/login");
        });
      },
    );
    super.initState();
    listenSensor().then((value) {
      setState(() {
        return value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        key: Key('CustomAppBar'),
      ),
      body: ListView(
        children: [
          Column(
            children: [
// ---------------------- Story Section --------------------------
              SizedBox(
                height: 200,
                child: FutureBuilder<StoryResponse?>(
                  future: StoryRepository().getAllStories(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data != null) {
                        List<Story> lstStory = snapshot.data!.stories!;

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: lstStory.length,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/addStory');
                                },
                                splashColor:
                                    const Color.fromARGB(234, 223, 210, 210),
                                child: const SizedBox(
                                  height: 200,
                                  width: 150,
                                  child: Card(
                                    elevation: 10,
                                    color: Colors.blueAccent,
                                    child: Icon(Icons.add_a_photo),
                                  ),
                                ),
                              );
                            }
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/story',
                                    arguments: lstStory[index]);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                width: 130,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 141, 139, 139),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      lstStory[index].image!.replaceAll(
                                          '127.0.0.0', '192.168.1.101'),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Text(
                                  lstStory[index].title!,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text("No data"),
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
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
// ---------------------- Live Event Section --------------------------

          Row(
            children: [
              const Expanded(
                flex: 1,
                child: Text(
                  'Live Events',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/seeAll');
                },
                child: const Text(
                  'See all',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 280,
            child: FutureBuilder<EventResponse?>(
              future: EventRepository().getEvents(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data != null) {
                    List<Event> lstEventCategory = snapshot.data!.events!;

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.events!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/eventDetails',
                                arguments: lstEventCategory[index]);
                          },
                          child: Card(
                            elevation: 10,
                            child: Stack(
                              children: [
                                Container(
                                    margin: const EdgeInsets.all(10),
                                    width: 300,
                                    height: 270,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 170,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              lstEventCategory[index].title!,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              lstEventCategory[index]
                                                  .eventDate!,
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              lstEventCategory[index].content!,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Rs.${lstEventCategory[index].ticketPrice!}",
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(lstEventCategory[index]
                                                .location!),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    )),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  width: 300,
                                  height: 170,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color:
                                          const Color.fromARGB(255, 55, 80, 92),
                                      width: 2,
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        lstEventCategory[index]
                                            .eventImage!
                                            .replaceAll(
                                                '127.0.0.0', '192.168.1.101'),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ListTile(
                                        leading: CircleAvatar(
                                            child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 1,
                                              style: BorderStyle.solid,
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                lstEventCategory[index]
                                                    .eventImage!
                                                    .replaceAll('127.0.0.0',
                                                        '192.168.1.101'),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )),
                                        title: Text(
                                          lstEventCategory[index].title!,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                        ),
                                      ),
                                      ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.indigo,
                                          child: IconButton(
                                            icon: const Icon(Icons.thumb_up),
                                            onPressed: () {
                                              _likeEvent(
                                                  lstEventCategory[index].id!);
                                            },
                                          ),
                                        ),
                                        trailing: CircleAvatar(
                                          backgroundColor: Colors.indigo,
                                          child: IconButton(
                                            icon:
                                                const Icon(Icons.share_rounded),
                                            onPressed: () {
                                              Share.share(
                                                  "check out this Event: https://192.168.1.101/events/${lstEventCategory[index].title}",
                                                  subject: 'Look what I made!');
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("No data"),
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
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
// ---------------------- Upcomming Event Section --------------------------

          Row(
            children: [
              const Expanded(
                flex: 1,
                child: Text(
                  'Upcomming Events',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/seeAll');
                },
                child: const Text(
                  'See all',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 300,
            child: FutureBuilder<EventResponse?>(
              future: EventRepository().getEvents(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data != null) {
                    List<Event> lstEventCategory = snapshot.data!.events!;

                    lstEventCategory
                        .sort((a, b) => a.eventDate!.compareTo(b.eventDate!));

                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 60,
                      ),
                      itemCount: snapshot.data!.events!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/eventDetails',
                                arguments: lstEventCategory[index]);
                          },
                          child: Card(
                            elevation: 10,
                            child: Stack(
                              children: [
                                Container(
                                    margin: const EdgeInsets.all(10),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 55, 80, 92),
                                        width: 2,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 190,
                                        ),
                                        Text(
                                          lstEventCategory[index].title!,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    )),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  width: double.infinity,
                                  height: 170,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color:
                                          const Color.fromARGB(255, 55, 80, 92),
                                      width: 2,
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        lstEventCategory[index]
                                            .eventImage!
                                            .replaceAll(
                                                '127.0.0.0', '192.168.1.101'),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("No data"),
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
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
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
}

Widget displayStories(Story story, BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pushNamed(context, '/story'),
    child: Container(
      margin: const EdgeInsets.all(10),
      width: 130,
      decoration: BoxDecoration(
        border: Border.all(
            color: const Color.fromARGB(255, 141, 139, 139), width: 1),
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(
            story.image!.replaceAll('127.0.0.0', '192.168.1.101'),
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Text(
        story.title!,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    ),
  );
}
