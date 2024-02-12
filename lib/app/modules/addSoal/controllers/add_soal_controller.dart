import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matematika/app/routes/app_pages.dart';

class AddSoalController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<TextEditingController> cQ1 = [];
  List<TextEditingController> cQ2 = [];
  TextEditingController cAnswer = TextEditingController();
  TextEditingController cCerita = TextEditingController();
  TextEditingController cPenjelasan = TextEditingController();
  TextEditingController cOptA = TextEditingController();
  TextEditingController cOptB = TextEditingController();
  TextEditingController cOptC = TextEditingController();
  TextEditingController cOptD = TextEditingController();

  void clear() {
    cAnswer.text = cOptA.text = cOptB.text = cOptC.text = cOptD.text = "";
    cQ1 = List.generate(4, (index) => TextEditingController());
    cQ2 = List.generate(4, (index) => TextEditingController());
  }

  @override
  void onInit() {
    clear();
    super.onInit();
  }

  Future save() {
    var soal = firestore.collection('soals');

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
    return soal.add(data);
  }
}
