import 'package:example_firebase/service/user_service.dart';
import 'package:example_firebase/view/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/loginmodel.dart';
import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var height = Get.height;
  var width = Get.width;
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool visable = true;
  bool isCheckBox = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          color: Colors.white,
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text(
          'LOG IN',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Form(
              key: _form,
              child: Column(
                children: [
                  SizedBox(
                    height: height * .02,
                  ),
                  Text(
                    'Let\'s Sign You In',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: height * .008,
                  ),
                  Text(
                    'Welcome back , you\'ve been missed!',
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                  SizedBox(
                    height: height * .008,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    controller: _email,
                    decoration: buildInputDecoration().copyWith(
                      labelText: "Username",
                    ),
                    validator: (value) {
                      RegExp regex = RegExp(
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                      if (!regex.hasMatch(value!)) {
                        return "Enter valid Email";
                      }
                    },
                  ),
                  SizedBox(
                    height: height * .008,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _password,
                    obscureText: visable,
                    decoration: buildInputDecoration().copyWith(
                      labelText: "Password",
                      suffixIcon: IconButton(
                          splashRadius: 20,
                          onPressed: () {
                            setState(() {
                              visable = !visable;
                            });
                          },
                          icon: visable == false
                              ? const Icon(
                                  Icons.visibility,
                                  color: Colors.grey,
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                )),
                    ),
                    validator: (value) {
                      RegExp regex = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                      if (!regex.hasMatch(value!)) {
                        return "Enter valid password";
                      }
                    },
                  ),
                  SizedBox(
                    height: height * .04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: isCheckBox,
                            onChanged: (value) {
                              setState(() {
                                isCheckBox = value!;
                              });
                            },
                          ),
                          Text(
                            'Remember Me',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          )
                        ],
                      ),
                      InkWell(
                          child: Text(
                        'Forgot Password ?',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_form.currentState!.validate()) {
                        loginmodel _info = loginmodel();

                        _info.username = _email.text;
                        _info.password = _password.text;
                        bool status =
                            await SigninService.singin(_info.toJson());

                        if (status == true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Successful'),
                            ),
                          );
                          Get.to(() => HomeScreen());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Invalid User Name or Password'),
                            ),
                          );
                        }
                      }
                    },
                    child: Container(
                      height: height * .07,
                      width: width * .8,
                      decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(40)),
                      child: Center(
                          child: Text(
                        'SIGN UP',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                    ),
                  ),
                  SizedBox(
                    height: height * .09,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: height * .07,
                      width: width * .8,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(40)),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 25,
                            width: 25,
                            child: Image.asset(
                              'assets/photo/GOOGLE.png',
                            ),
                          ),
                          Text(
                            'Continue With Google',
                            style: TextStyle(fontSize: 17, color: Colors.red),
                          ),
                        ],
                      )),
                    ),
                  ),
                  SizedBox(
                    height: height * .015,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: height * .07,
                      width: width * .8,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(40)),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 25,
                            width: 25,
                            child: Image.asset(
                              'assets/photo/12.png',
                            ),
                          ),
                          Text(
                            'Continue With Facebook',
                            style: TextStyle(fontSize: 17, color: Colors.blue),
                          ),
                        ],
                      )),
                    ),
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an Account ?',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(RegisterScreen());
                        },
                        child: Text(
                          'Sign Up',
                          style:
                              TextStyle(color: Colors.deepPurple, fontSize: 18),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration() {
    return InputDecoration(
      labelStyle: TextStyle(color: Colors.grey.shade500),
      focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple)),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple)),
      errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple)),
    );
  }
}
