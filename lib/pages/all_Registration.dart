import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shivam_food_delivery_app/database/database.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({super.key});

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  Stream? BookingStream;

  getOnTheLoad() async {
    BookingStream = await DatabaseMethods().getRegistration();
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
                              "Email : " + ds["Email"],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              "Password : " + ds["Password"],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
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
      body: Container(
        child: allBooking(),
      ),
    );
  }
}
