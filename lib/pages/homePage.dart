import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:random_string/random_string.dart';
import 'package:shivam_food_delivery_app/database/database.dart';
import 'package:shivam_food_delivery_app/pages/all_Registration.dart';
import 'package:shivam_food_delivery_app/pages/loginPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController designationController = TextEditingController();

  uploadData() async {
    String id = randomAlphaNumeric(10);
    Map<String, dynamic> userData = {
      "Name": nameController.text,
      "Designation": designationController.text,
      "Id": id
    };
    await DatabaseMethods().addUserDetails(userData, id).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Information Added Successfully..",
        style: TextStyle(fontSize: 20.0),
      )));
    });
  }

////
  ///
  Stream? BookingStream;

  getOnTheLoad() async {
    BookingStream = await DatabaseMethods().getBooking();
    setState(() {});
  }

  @override
  void initState() {
    getOnTheLoad();
    super.initState();
  }

  Widget allBooking() {
    return StreamBuilder(
        stream: BookingStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Material(
                      elevation: 10.0,
                      borderRadius: BorderRadius.circular(30.0),
                      child: Container(
                        padding: EdgeInsets.only(top: 50.0, bottom: 50.0),
                        margin: EdgeInsets.only(
                            left: 10.0, right: 10.0, bottom: 20.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          gradient: LinearGradient(colors: [
                            Color(0xFFB91635),
                            Color(0xff621d3c),
                            Color(0xFF311937),
                          ]),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 10.0),
                            Text(
                              "Name : " + ds["Name"],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              "Designation : " + ds["Designation"],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 40.0),
                            GestureDetector(
                              onTap: () async {
                                await DatabaseMethods().DeleteBooking(ds.id);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 60.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.orange,
                                ),
                                child: Text("Delete",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0)),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            GestureDetector(
                              onTap: () async {
                                await DatabaseMethods().UpdateUserData(
                                    nameController.text,
                                    designationController.text,
                                    ds.id);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 60.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.orange,
                                ),
                                child: Text("Update",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0)),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.only(top: 100.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              margin: EdgeInsets.only(right: 20.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Text("Logout",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              margin: EdgeInsets.only(right: 20.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllUsers()));
                        },
                        child: Text("Fetch All Users",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: nameController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter Employee Name",
                hintStyle: TextStyle(color: Colors.white),
                label: Text("Name"),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: designationController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter Employee Designation",
                hintStyle: TextStyle(color: Colors.white),
                label: Text("Designation"),
              ),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                uploadData();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                child: Text(
                  "Add",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Divider(),
            SizedBox(height: 70.0),
            Expanded(
              child: allBooking(),
            ),
          ],
        ),
      ),
    );
  }
}
