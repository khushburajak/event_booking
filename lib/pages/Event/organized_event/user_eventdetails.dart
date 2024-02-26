import 'package:badges/badges.dart';
import 'package:event_booking/models/event.dart';
import 'package:flutter/material.dart';

class UserEventDetails extends StatefulWidget {
  const UserEventDetails({Key? key}) : super(key: key);

  @override
  State<UserEventDetails> createState() => _UserEventDetailsState();
}

class _UserEventDetailsState extends State<UserEventDetails> {
  List<SmProduct> products = [];
  final List<SmProduct> smProducts = [
    SmProduct(
        image:
            'https://i0.wp.com/www.mwcshanghai.com/wp-content/uploads/2022/01/hero-2022-general1.jpg?resize=2100%2C720&ssl=1'),
    // SmProduct(image: 'assets/images/product-2.png'),
    // SmProduct(image: 'assets/images/product-3.png'),
    // SmProduct(image: 'assets/images/product-4.png'),
  ];

  @override
  Widget build(BuildContext context) {
    Event event = ModalRoute.of(context)!.settings.arguments as Event;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .35,
              // padding: const EdgeInsets.only(bottom: 30),
              width: double.infinity,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(600),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    event.eventImage!.replaceAll('127.0.0.0', '192.168.1.101'),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(top: 40, right: 14, left: 14),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                event.title!,
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Badge(
                              //   toAnimate: false,
                              //   shape: BadgeShape.square,
                              //   badgeColor: Colors.deepPurple,
                              //   borderRadius: BorderRadius.circular(5),
                              //   badgeContent: Text(event.category!,
                              //       style: const TextStyle(
                              //           color: Colors.white, fontSize: 8)),
                              // ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                event.eventDate!.toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Rs.${event.ticketPrice!}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Text(
                            event.content!,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Going to attend:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 110,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: smProducts.length,
                              itemBuilder: (context, index) => Container(
                                margin: const EdgeInsets.only(right: 6),
                                width: 110,
                                height: 110,
                                child: CircleAvatar(
                                    radius: 30,
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
                                            event.eventImage!.replaceAll(
                                                '127.0.0.0', '192.168.1.101'),
                                            scale: 1.0,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Reviews:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'No reviews yet',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_border,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 5),
                const Text(
                  '0',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/updateEvent',
                      arguments: event);
                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) =>
                  //       _buildPopupDialog(context, event),
                  // );
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text(
                    'Update Event',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SmProduct {
  String? image;

  SmProduct({this.image});
}

// Widget _buildPopupDialog(BuildContext context, Event event) {
//   return AlertDialog(
//     title: const Text(
//       'Confirm Update',
//       style: TextStyle(
//         fontSize: 20,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//     content: Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           "Event:${event.title!}",
//           style: const TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Text(
//           "Rs.${event.ticketPrice!}",
//           style: const TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     ),
//     actions: <Widget>[
//       OutlinedButton(
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         child: const Text('Cancel'),
//       ),
//       ElevatedButton(
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         child: const Text('Confirm'),
//       ),
//     ],
//   );
// }
