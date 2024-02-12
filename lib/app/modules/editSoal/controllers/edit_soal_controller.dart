import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matematika/app/routes/app_pages.dart';

class EditSoalController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<TextEditingController> cQ1 = [];
  List<TextEditingController> cQ2 = [];
  TextEditingController cAnswer = TextEditingController();
  TextEditingController cOptA = TextEditingController();
  TextEditingController cOptB = TextEditingController();
  TextEditingController cOptC = TextEditingController();
  TextEditingController cOptD = TextEditingController();

  TextEditingController cCerita = TextEditingController();
  TextEditingController cPenjelasan = TextEditingController();
  var load = false.obs;

  @override
  void onInit() {
    clear();
    super.onInit();
  }

  void clear() {
    cAnswer.text = cOptA.text = cOptB.text = cOptC.text = cOptD.text = "";

    cQ1 = List.generate(4, (index) => TextEditingController());
    cQ2 = List.generate(4, (index) => TextEditingController());
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getData(id) async {
    var soal = firestore.collection('soals').doc(id);
    return soal.get();
  }

  Future setData() async {
    var soal = firestore.collection('soals').doc(Get.arguments);
    soal.get().then((value) {
      var datas = value.data() as Map<String, dynamic>;
      var q1 = datas['q1'];
      var q2 = datas['q2'];
      cQ1[0].text = "${q1[0]}";
      cQ2[0].text = "${q2[0]}";
      cQ1[1].text = "${q1[1]}";
      cQ2[1].text = "${q2[1]}";
      cQ1[2].text = "${q1[3]}";
      cQ2[2].text = "${q2[3]}";
      cQ1[3].text = "${q1[2]}";
      cQ2[3].text = "${q2[2]}";
      cOptA.text = datas['a'];
      cOptB.text = datas['b'];
      cOptC.text = datas['c'];
      cOptD.text = datas['d'];
      cPenjelasan.text = datas['penj'];
      cCerita.text = datas['cerita'];
      cAnswer.text = datas['answer'];
      load.value = true;
    });
    // data = getData(Get.arguments);
    // var datas = data;
    // var q1 = datas['q1'];
    // var q2 = datas['q2'];
    // cQ1[0].text = "${q1[0]}";
    // cQ2[0].text = "${q2[0]}";
    // cQ1[1].text = "${q1[1]}";
    // cQ2[1].text = "${q2[1]}";
    // cQ1[2].text = "${q1[3]}";
    // cQ2[2].text = "${q2[3]}";
    // cQ1[3].text = "${q1[2]}";
    // cQ2[3].text = "${q2[2]}";
    // cOptA.text = datas['a'];
    // cOptB.text = datas['b'];
    // cOptC.text = datas['c'];
    // cOptD.text = datas['d'];
    // cPenjelasan.text = datas['penj'];
    // cCerita.text = datas['cerita'];
    // cAnswer.text = datas['answer'];
  }

  Future save(id) {
    var soal = firestore.collection('soals').doc(id);
    var q1 = [
      int.parse(cQ1[0].text),
      int.parse(cQ1[1].text),
      int.parse(cQ1[2].text),
      cQ1[3].text
    ];
    var q2 = [
      int.parse(cQ2[0].text),
      int.parse(cQ2[1].text),
      int.parse(cQ2[2].text),
      cQ2[3].text
    ];
    var data = {
      'q1': FieldValue.arrayUnion(q1),
      'q2': FieldValue.arrayUnion(q2),
      'a': cOptA.text,
      'b': cOptB.text,
      'c': cOptC.text,
      'd': cOptD.text,
      'answer': cAnswer.text,
      'penj': cPenjelasan.text,
      'cerita': cCerita.text,
    };
    clear();
    Get.offAndToNamed(Routes.ADMIN_SOAL);

    return soal.update(data);
  }
}
