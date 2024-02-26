import 'package:event_booking/models/user.dart';
import 'package:event_booking/repository/user_respository.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cpasswordController = TextEditingController();

  bool isSignup = false;

  _registerUser(User user) async {
    bool isSignup = await UserRepository().registerUser(user);
    if (isSignup) {
      await _displayMessage(true);
    } else {
      await _displayMessage(false);
    }
  }

  _displayMessage(bool isSignup) {
    if (isSignup) {
      Navigator.pushNamed(context, '/login');
      MotionToast.success(
              description: const Text('You are Registered successfully'))
          .show(context);
    } else {
      MotionToast.error(description: const Text('Something went wrong'))
          .show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text('Sign Up for free',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    key: const ValueKey('name'),
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: 'Name',
                      hintText: 'Enter your name',
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your name' : null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    key: const ValueKey('username'),
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: 'UserName',
                      hintText: 'Enter your username',
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your username' : null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    key: const ValueKey('email'),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: 'Email',
                      hintText: 'Enter your email',
                    ),
                    controller: _emailController,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your email' : null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    key: const ValueKey('password'),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: 'Password',
                      hintText: 'Enter your password',
                    ),
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your password' : null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    key: const ValueKey('cpassword'),
                    controller: _cpasswordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: 'Confirm Password',
                      hintText: 'Enter your password again',
                    ),
                    obscureText: true,
                    validator: (value) => value!.isEmpty
                        ? 'Please enter your password again'
                        : null,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    child: Column(
                      children: [
                        const Text(
                            'By signing up, you agree to our,Terms of Service & Privacy Policy',
                            style: TextStyle(fontSize: 12)),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .7,
                          height: 50,
                          child: ElevatedButton(
                            key: const ValueKey('signup'),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (_passwordController.text ==
                                    _cpasswordController.text) {
                                  User user = User(
                                      name: _nameController.text,
                                      username: _usernameController.text,
                                      email: _emailController.text,
                                      password: _passwordController.text);

                                  _registerUser(user);
                                } else {
                                  MotionToast.error(
                                          description: const Text(
                                              'Password does not match'))
                                      .show(context);
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent),
                            child: const Text("Register"),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('Already have an account?',
                            style: TextStyle(fontSize: 14)),
                        SizedBox(
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('/login');
                              },
                              child: const Text(
                                'Sign In',
                              )),
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
                                    Navigator.of(context)
                                        .pushReplacementNamed('/navigation');
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
            ),
          ),
        ),
      ),
    );
  }
}
