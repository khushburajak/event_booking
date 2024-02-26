import 'package:event_booking/shared_preferences/jwt_auth_token.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final token = Authcontroller.getAuthToken();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            const Text(
              "Settings",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: const [
                Icon(
                  Icons.person,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Account",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(
              height: 15,
              thickness: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/changepassword');
                    },
                    child: const Text(
                      "Change Password",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/wearos');
                    },
                    child: const Text(
                      "Connect to WearOS",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/createcategory');
                    },
                    child: const Text(
                      "Create Category",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    )),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Delete Account",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    )),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: const [
                Icon(
                  Icons.volume_up_outlined,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Notifications",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(
              height: 15,
              thickness: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            buildNotificationOptionRow("New for you", true),
            buildNotificationOptionRow("Account activity", true),
            buildNotificationOptionRow("Opportunity", false),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: OutlinedButton(
                  onPressed: () {
                    Authcontroller.removeAuthToken();
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text("SIGN OUT",
                      style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 2.2,
                          color: Colors.black)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row buildNotificationOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        Transform.scale(
            scale: 0.7,
            child: Switch(
              value: isActive,
              onChanged: (bool val) {},
            ))
      ],
    );
  }
}
