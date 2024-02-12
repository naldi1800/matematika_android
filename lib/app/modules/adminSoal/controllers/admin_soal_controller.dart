import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:matematika/app/util/ui.dart';

class AdminSoalController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> getData() {
    var soal = firestore.collection('soals');
    return soal.snapshots();
  }

  void delete(id) {
    var soal = firestore.collection('soals').doc(id);
    soal.delete();
    UI.warning(msg: "Berhasil dihapus");
  }
}
