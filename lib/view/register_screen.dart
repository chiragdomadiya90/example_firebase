import 'package:example_firebase/model/signupmodel.dart';
import 'package:example_firebase/service/user_service.dart';
import 'package:example_firebase/view/home_screen.dart';
import 'package:example_firebase/view/signin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var height = Get.height;
  var width = Get.width;

  final _username = TextEditingController();
  final _firstname = TextEditingController();
  final _password = TextEditingController();
  final _lastname = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool visable = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Register',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Form(
              key: _form,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * .02,
                    ),
                    Text(
                      'Create Your Account',
                      style:
                          TextStyle(fontSize: 27, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: height * .008,
                    ),
                    Text(
                      'After Your Registration is Complete,',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    Text(
                      'You can see covid Data.',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _firstname,
                      decoration: buildInputDecoration().copyWith(
                        labelText: "FirstName",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "FirstName can't be Empty";
                        }
                      },
                    ),
                    SizedBox(
                      height: height * .008,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _lastname,
                      decoration: buildInputDecoration().copyWith(
                        labelText: "LastName",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "LastName can't be Empty";
                        }
                      },
                    ),
                    SizedBox(
                      height: height * .008,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _username,
                      decoration: buildInputDecoration().copyWith(
                        labelText: "UserName",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "UserName can't be Empty";
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
                      height: height * .05,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_form.currentState!.validate()) {
                          signupmodel info = signupmodel();

                          info.firstName = _firstname.text;
                          info.lastName = _lastname.text;
                          info.username = _username.text;
                          info.password = _password.text;

                          SignUpService.singUp(reqModel: info.toJson())
                              .whenComplete(() => Get.to(() => HomeScreen()));
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
                      height: height * .03,
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
                              style:
                                  TextStyle(fontSize: 17, color: Colors.blue),
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
                          'Already have an Account ?',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(SignInScreen());
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                                color: Colors.deepPurple, fontSize: 18),
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
