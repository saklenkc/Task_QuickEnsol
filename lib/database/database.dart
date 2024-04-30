import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Detail")
        .doc(id)
        .set(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getBooking() async {
    return await FirebaseFirestore.instance.collection("Detail").snapshots();
  }

  Future DeleteBooking(String id) async {
    return await FirebaseFirestore.instance
        .collection("Detail")
        .doc(id)
        .delete();
  }

  Future UpdateUserData(String name, String designation, String id) async {
    return await FirebaseFirestore.instance
        .collection("Detail")
        .doc(id)
        .update({"Name": name, "Designation": designation});
  }

  Future DoRegistration(Map<String, dynamic> userInfoMap2) async {
    return await FirebaseFirestore.instance
        .collection("Registration")
        .add(userInfoMap2);
  }

  Future<Stream<QuerySnapshot>> getRegistration() async {
    return await FirebaseFirestore.instance
        .collection("Registration")
        .snapshots();
  }
}
