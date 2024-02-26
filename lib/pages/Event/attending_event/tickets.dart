import 'package:event_booking/models/event.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Tickets extends StatefulWidget {
  const Tickets({super.key});

  @override
  State<Tickets> createState() => _TicketsState();
}

class _TicketsState extends State<Tickets> {
  @override
  Widget build(BuildContext context) {
    Event event = ModalRoute.of(context)!.settings.arguments as Event;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(event.title!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .25,
              width: MediaQuery.of(context).size.height * .5,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    event.eventImage!.replaceAll('127.0.0.0', '192.168.1.101'),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Event: ${event.title!}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Desc: ${event.content!}",
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Date: ${event.eventDate!}",
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Guest: ${event.specialAppereance!}",
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Location: ${event.location!}",
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            QrImageView(
              data:
                  "Event: ${event.title!}, Date: ${event.eventDate!}, Location: ${event.location!}",
              version: QrVersions.auto,
              size: 300,
              gapless: false,
              embeddedImage: NetworkImage(
                event.eventImage!.replaceAll('127.0.0.0', '192.168.1.101'),
              ),
              embeddedImageStyle: const QrEmbeddedImageStyle(
                size: Size(80, 80),
              ),
            )
          ],
        ),
      ),
    );
  }
}
