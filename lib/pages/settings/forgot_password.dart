import 'package:event_booking/repository/user_respository.dart';
import 'package:event_booking/utils/display_message.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();

  _fortgotPassword(email) async {
    try {
      bool isUpdated = await UserRepository().forgotPassword(email);
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
      displaySuccessMessage(
          context, 'Email sent successfully, please check your email');
    } else {
      displayErrorMessage(context, 'Email not found, Please Register');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: SizedBox(
            width: double.infinity,
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter Valid Email',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('Reset Password'),
                    onPressed: () {
                      _fortgotPassword(_emailController.text);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
