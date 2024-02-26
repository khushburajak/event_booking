import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:event_booking/repository/user_respository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import '../../utils/display_message.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(text: 'mko0');
  final _passwordController = TextEditingController(text: 'mko0mko0');
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  @override
  void initState() {
    _checkNotificationEnabled();

    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
  }

  int counter = 1;
  _checkNotificationEnabled() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final authstate = authenticated
        ? Navigator.pushNamed(context, '/navigation')
        : Navigator.pushNamed(context, '/login');
    setState(() {});
  }

  _login(String username, String password) async {
    bool isLogin = await UserRepository().login(username, password);
    if (isLogin) {
      _displaymessage(true);
    } else {
      _displaymessage(false);
    }
  }

  _displaymessage(bool isLogin) {
    if (isLogin) {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: counter,
              channelKey: 'basic_channel',
              title: 'User Logged In',
              body: "Logged In Successfully"));
      setState(() {
        counter++;
      });
      Navigator.pushNamed(context, '/navigation');
    } else {
      displayErrorMessage(context, 'Login Failed');
    }
  }

  _noConnection() {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: counter,
            channelKey: 'basic_channel',
            title: 'Connection Error',
            body: "No Internet Connection"));
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Column(
                      children: [
                        Text(
                          'Welcome Back !',
                          style: TextStyle(
                            fontSize: 40,
                            fontFamily: 'poppins',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Log In',
                            key: ValueKey('login'),
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: 'UserName',
                      hintText: 'Enter your username',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: 'Password',
                      hintText: 'Enter your password',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .7,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _login(_usernameController.text,
                                    _passwordController.text);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent),
                            child: const Text('Log In',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (_supportState == _SupportState.unknown)
                          const CircularProgressIndicator()
                        else if (_supportState == _SupportState.supported)
                          Column(
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: _authenticateWithBiometrics,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(_isAuthenticating
                                        ? 'Cancel'
                                        : 'Authenticate: biometrics only'),
                                    const Icon(Icons.fingerprint),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/forgot_password');
                                    },
                                    child: const Text('Forgot Password'),
                                  ),
                                ],
                              )
                            ],
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Don't have an account?",
                            style: TextStyle(fontSize: 14)),
                        SizedBox(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/register');
                            },
                            child: const Text(
                              'Sign Up',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('OR', style: TextStyle(fontSize: 14)),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 60,
                                width: 60,
                                child: InkWell(
                                  onTap: () {}, // Handle your callback.
                                  splashColor:
                                      const Color.fromARGB(255, 54, 68, 202)
                                          .withOpacity(0.5),
                                  child: Ink(
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/google_logo.png'),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              width: 100,
                            ),
                            SizedBox(
                                height: 60,
                                width: 60,
                                child: InkWell(
                                  onTap: () {
                                    AwesomeNotifications().createNotification(
                                        content: NotificationContent(
                                            id: counter,
                                            channelKey: 'basic_channel',
                                            title: 'Connection Failed',
                                            body:
                                                "Not Connected to Internet Source"));
                                    setState(() {
                                      counter++;
                                    });
                                  }, // Handle your callback.
                                  splashColor:
                                      const Color.fromARGB(255, 54, 68, 202)
                                          .withOpacity(0.5),
                                  child: Ink(
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/facebook_logo.png'),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    )));
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
