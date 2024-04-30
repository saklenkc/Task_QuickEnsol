import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shivam_food_delivery_app/pages/homePage.dart';
import 'package:shivam_food_delivery_app/pages/signUp.dart';
import 'package:shivam_food_delivery_app/widgets/widget_support.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _finalKey = GlobalKey<FormState>();

  String? email, password;

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text("Login Successfully", style: TextStyle(fontSize: 20.0))));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text("Email doesn't Exist", style: TextStyle(fontSize: 20.0))));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Wrong Password", style: TextStyle(fontSize: 20.0))));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                  color: Color.fromARGB(181, 0, 170, 255),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 2.5),
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
                child: Column(
                  children: [
                    Center(child: Image.asset("assets/logo.png")),
                    SizedBox(height: 50.0),
                    Material(
                      borderRadius: BorderRadius.circular(20.0),
                      elevation: 5.0,
                      child: Container(
                        margin: EdgeInsets.only(right: 20.0, left: 20.0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 1.8,
                        child: Form(
                          key: _finalKey,
                          child: Column(
                            children: [
                              SizedBox(height: 25.0),
                              Text("Login",
                                  style: AppWidget.textHeadLineWidget()),
                              SizedBox(height: 25.0),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter Email";
                                  }
                                  return null;
                                },
                                controller: emailController,
                                decoration: InputDecoration(
                                  hintText: "Enter Email",
                                  prefixIcon: Icon(Icons.email),
                                ),
                              ),
                              SizedBox(height: 30.0),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter Password";
                                  }
                                  return null;
                                },
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "Enter Password",
                                  prefixIcon: Icon(Icons.password),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                alignment: Alignment.topRight,
                                child: Text("Forgot Password?",
                                    style: AppWidget.textBoldWidget()),
                              ),
                              SizedBox(height: 80.0),
                              GestureDetector(
                                onTap: () {
                                  if (_finalKey.currentState!.validate()) {
                                    setState(() {
                                      email = emailController.text;
                                      password = passwordController.text;
                                    });
                                    userLogin();
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 100.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Color.fromARGB(181, 0, 170, 255),
                                  ),
                                  child: Text("Login",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 23.0)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Text("Don't Have An Account? Sign Up",
                          style: AppWidget.textBoldWidget()),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
