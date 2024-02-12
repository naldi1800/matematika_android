import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var isTest = false.obs;
  Stream<DocumentSnapshot<Map<String, dynamic>>> getData(id) {
    var soal = firestore.collection('users').doc(id);
    return soal.snapshots();
  }
}
