import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MateriController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> getData() {
    var s = firestore.collection('soals');
    return s.snapshots();
  }

  var onLoad = false.obs;
  RxList<dynamic> userAnswer = [].obs;
  RxMap<String, dynamic> userLevel = RxMap<String, dynamic>({});
  RxMap<String, dynamic> userSelected = RxMap<String, dynamic>({});
  RxMap<String, dynamic> user = RxMap<String, dynamic>({});
  void userData() {
    var u = firestore.collection('users').doc(Get.arguments);
    u.get().then((value) => user.value = value.data()!);
    u.collection('answers').get().then(
      (value) {
        value.docs.forEach((doc) {
          userAnswer.add(doc.data());
          userLevel.putIfAbsent(
              doc.data()['idSoal'], () => doc.data()['isTrue']);
          userSelected.putIfAbsent(
              doc.data()['idSoal'], () => doc.data()['answer']);
        });
        onLoad.value = true;
      },
    );
  }
}
