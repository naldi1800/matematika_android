import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whiteboard/whiteboard.dart';

class SoalController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var currentQuiz = 0.obs;
  var isLastQuiz = false.obs;
  var answer = [].obs;
  var tf = [].obs;
  var selected = "".obs;
  var isFinish = false.obs;
  var isWhiteboard = false.obs;
  var showNumber = false.obs;

  RxList<WhiteBoardController> papan = RxList<WhiteBoardController>();
  // var papan = [].obs;

  Stream<QuerySnapshot<Map<String, dynamic>>> getData() {
    var soal = firestore.collection('soals');
    return soal.snapshots();
  }

  void setSelected(String s) {
    selected.value = s;
    answer[currentQuiz.value] = s;
  }

  void saveAnswer(id) async {
    var users = firestore.collection('users').doc(id);
    var b = 0, s = 0;
    for (int i = 0; i < answer.length; i++) {
      if (tf[i]) {
        b += 1;
      } else {
        s += 1;
      }
    }
    var presentasi = (b / (b + s)) * 100;
    Map<Object, Object> u = {
      "answer": FieldValue.arrayUnion(answer),
      "isTest": true,
      "value": presentasi,
    };
    users.update(u);
  }

  //   @override
  // void onInit() {
  //   super.onInit();
  //   loadDrawingDataFromStorage(WhiteBoardController());
  // }
  // @override
  // void dispose() {
  //   super.dispose();
  //   saveDrawingDataToStorage(WhiteBoardController());
  // }
  // void loadDrawingDataFromStorage(c) {
  //   // Handle potential errors and null cases
  //   final storedData = drawSave.get('drawing_data');
  //   if (storedData != null) {
  //     c.loadData(storedData);
  //   }
  // }
  // void saveDrawingDataToStorage(c) {
  //   // Save current drawing data to storage
  //   final data = c.getData();
  //   drawSave.put('drawing_data', data);
  // }
}
