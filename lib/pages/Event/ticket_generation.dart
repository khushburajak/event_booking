import 'package:event_booking/repository/event_repositories.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  // Update Event
  _attendEvent(eventID) async {
    try {
      bool isUpdated = await EventRepository().attendEvent(eventID);
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
      Navigator.pushNamed(context, '/profile');
      MotionToast.success(
              description:
                  const Text("You are Added to Attendee List successfully"))
          .show(context);
    } else {
      MotionToast.error(
              description: const Text("You Already Attended this Event"))
          .show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    String product = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/navigation');
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 10,
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              const SizedBox(
                width: 10,
              ),
              Text(
                product,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    _attendEvent(product);
                    Navigator.pushNamed(context, '/profile');
                  },
                  child: const Text('Generate Ticket')),
            ]),
          ),
        ),
      ),
    );
  }
}
