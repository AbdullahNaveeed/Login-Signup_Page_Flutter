import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:login_signup_page/Chats.dart';
import 'package:login_signup_page/backgroundImageList.dart';
import 'package:shared_preferences/shared_preferences.dart';

class signUpPageScreen extends StatefulWidget {
  static const String id = 'signUp_Screen';
  const signUpPageScreen({super.key});

  @override
  State<signUpPageScreen> createState() => _signUpPageScreenState();
}

class _signUpPageScreenState extends State<signUpPageScreen> {
  bool? isChecked = false;
  bool isHover = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController1 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();

  Future<void> _saveSignUpDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setString('password', _passwordController1.text);
    await prefs.setBool('isLoggedIn', true);
  }

  void _handleSignUp() async {
    if (_nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController1.text.isNotEmpty &&
        _passwordController2.text.isNotEmpty) {
      if (_passwordController1.text.toString() ==
          _passwordController2.text.toString()) {
        await _saveSignUpDetails();
        Navigator.pushNamed(context, ChatScreenPage.id);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Password does not match"),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Enter correct email and password"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(bgImageList[0]), fit: BoxFit.fill),
        ),
        child: Container(
          width: double.infinity,
          height: 500,
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
            color: Colors.black.withOpacity(0.1),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      "Name",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    Container(
                      height: 35,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.white),
                        ),
                      ),
                      child: Form(
                        child: Expanded(
                          child: TextFormField(
                            controller: _nameController,
                            keyboardType: TextInputType.name,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.supervised_user_circle,
                                color: Colors.white,
                              ),
                              fillColor: Colors.white,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      "Email",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    const Spacer(),
                    Container(
                      height: 35,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.white),
                        ),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Expanded(
                          child: TextFormField(
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                              fillColor: Colors.white,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Password",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    Container(
                      height: 35,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.white),
                        ),
                      ),
                      child: TextFormField(
                        controller: _passwordController1,
                        keyboardType: TextInputType.visiblePassword,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          fillColor: Colors.white,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      "Repeat Password",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    Container(
                      height: 35,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.white),
                        ),
                      ),
                      child: TextFormField(
                        controller: _passwordController2,
                        keyboardType: TextInputType.visiblePassword,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          fillColor: Colors.white,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Flexible for Checkbox and Text
                        Container(
                          width: MediaQuery.of(context).size.width *
                              0.4, // 40% of screen width
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                fillColor:
                                    MaterialStatePropertyAll(Colors.white),
                                checkColor: Colors.black,
                                value: isChecked,
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    isChecked = newValue;
                                  });
                                },
                                side: BorderSide.none, // No border
                              ),
                              const Expanded(
                                // Wrap the text in an Expanded for flexible width
                                child: Text(
                                  "Remember Me",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14, // Responsive font size
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Flexible for FORGET PASSWORD
                      ],
                    ),
                    const Spacer(),
                    const Spacer(),
                    SizedBox(
                      height: 40,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _handleSignUp();
                          }
                        },
                        child: const Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
