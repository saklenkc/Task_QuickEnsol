import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:random_string/random_string.dart';
import 'package:shivam_food_delivery_app/database/database.dart';
import 'package:shivam_food_delivery_app/pages/homePage.dart';
import 'package:shivam_food_delivery_app/pages/loginPage.dart';
import 'package:shivam_food_delivery_app/widgets/widget_support.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? name, email, password;

  registration() async {
    if (name != null && email != null && password != null) {
      try {
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email!, password: password!);

        Map<String, dynamic> userRegistration = {
          "Name": nameController.text,
          "Email": emailController.text,
          "Password": passwordController.text,
        };
        await DatabaseMethods().DoRegistration(userRegistration).then((value) {
          SnackBar(content: Text("Registration Successfully"));
        });

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Registration Successfully...")));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Weak Password")),
          );
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Email-Already-In-Use")),
          );
        }
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
                        padding: EdgeInsets.only(top: 30.0),
                        margin: EdgeInsets.only(right: 20.0, left: 20.0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 1.3,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Create Your Account",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22.0)),
                                ],
                              ),
                              SizedBox(height: 20.0),
                              Text("Name",
                                  style: TextStyle(
                                      color: Color(0xFFB91635),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0)),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Enter Name";
                                  }
                                  return null;
                                },
                                controller: nameController,
                                decoration: InputDecoration(
                                  hintText: "Name",
                                  prefixIcon: Icon(Icons.person),
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Text("Gmail",
                                  style: TextStyle(
                                      color: Color(0xFFB91635),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0)),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Enter Email";
                                  }
                                  return null;
                                },
                                controller: emailController,
                                decoration: InputDecoration(
                                  hintText: "Gmail",
                                  prefixIcon: Icon(Icons.email_outlined),
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Text("Password",
                                  style: TextStyle(
                                      color: Color(0xFFB91635),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0)),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Enter Password";
                                  }
                                  return null;
                                },
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  prefixIcon: Icon(Icons.password_outlined),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              SizedBox(height: 20.0),
                              GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      name = nameController.text;
                                      email = emailController.text;
                                      password = passwordController.text;
                                    });
                                  }
                                  ;
                                  registration();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      gradient: LinearGradient(colors: [
                                        Color(0xFFB91635),
                                        Color(0xff621d3c),
                                        Color(0xFF311937),
                                      ])),
                                  child: Center(
                                    child: Text(
                                      "SIGN UP",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("Already Have An Account",
                                      style: TextStyle(
                                          color: Color(0xFF311937),
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w300)),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("Sign In",
                                        style: TextStyle(
                                            color: Color(0xFF311937),
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text("Already Have An Acount? Login",
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
