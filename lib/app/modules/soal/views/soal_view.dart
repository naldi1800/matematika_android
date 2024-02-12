import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:matematika/app/routes/app_pages.dart';
// import 'package:matematika/app/util/menu.dart';
import 'package:matematika/app/util/ui.dart';

import '../controllers/soal_controller.dart';
import 'package:whiteboard/whiteboard.dart';
// import 'package:whiteboard_sdk_flutter/whiteboard_sdk_flutter.dart';

class SoalView extends GetView<SoalController> {
  const SoalView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var layar = MediaQuery.of(context).size;
    var cardWitdh = (layar.width / 4) + (layar.width / 2) + (layar.width / 10);
    var optHeight = 50.0;
    double fontSizeAnswer = 25;
    // WhiteBoardController papan = WhiteBoardController();
    RxList<WhiteBoardController> papan = RxList<WhiteBoardController>();

    var ukuranPensil = 4.0.obs;
    var ukuranPensilOld = 4.0.obs;
    var sp = true.obs;
    var erase = false.obs;
    return Scaffold(
      backgroundColor: UI.backgroud,
      body: SafeArea(
        child: Stack(
          children: [
            //UTAMA
            Container(
              width: double.infinity,
              height: layar.height / 3,
              decoration: const BoxDecoration(
                color: UI.foreground,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
            ),
            StreamBuilder(
                stream: controller.getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    var datas = snapshot.data!.docs;
                    controller.answer.value = List.filled(datas.length, "");
                    controller.tf.value = List.filled(datas.length, false);
                    papan.value = List.filled(
                      datas.length,
                      WhiteBoardController(),
                    );
                    return Obx(() {
                      var d = datas[controller.currentQuiz.value].data();
                      controller.isLastQuiz.value =
                          datas.length - 1 == controller.currentQuiz.value;

                      return Stack(
                        children: [
                          // Quis
                          Visibility(
                            visible: !controller.isFinish.value,
                            child: SingleChildScrollView(
                              physics: (sp.value)
                                  ? const AlwaysScrollableScrollPhysics()
                                  : const NeverScrollableScrollPhysics(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 35),
                                  Container(
                                    width: cardWitdh,
                                    height: layar.height / 3,
                                    decoration: const BoxDecoration(
                                      color: UI.object,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SingleChildScrollView(
                                          child: Text(
                                            "${d['cerita']}", //TEXT QUIZ
                                            style: const TextStyle(
                                                overflow: TextOverflow.clip,
                                                fontSize: 15,
                                                color: UI.action),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  GestureDetector(
                                    onTap: () => controller.setSelected("A"),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: optHeight,
                                      width: cardWitdh,
                                      decoration: BoxDecoration(
                                        color: UI.action,
                                        border: Border.all(
                                          color: (controller.selected.value ==
                                                      "A" ||
                                                  controller.answer[controller
                                                          .currentQuiz.value] ==
                                                      "A")
                                              ? Colors.green
                                              : Colors.transparent,
                                          width: 3,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(25),
                                        ),
                                      ),
                                      child: Text(
                                        "${d['a']}",
                                        style: TextStyle(
                                          overflow: TextOverflow.clip,
                                          fontSize: fontSizeAnswer,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  GestureDetector(
                                    onTap: () => controller.setSelected("B"),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: optHeight,
                                      width: cardWitdh,
                                      decoration: BoxDecoration(
                                        color: UI.action,
                                        border: Border.all(
                                          color: (controller.selected.value ==
                                                      "B" ||
                                                  controller.answer[controller
                                                          .currentQuiz.value] ==
                                                      "B")
                                              ? Colors.green
                                              : Colors.transparent,
                                          width: 3,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(25),
                                        ),
                                      ),
                                      child: Text(
                                        "${d['b']}",
                                        style: TextStyle(
                                          overflow: TextOverflow.clip,
                                          fontSize: fontSizeAnswer,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  GestureDetector(
                                    onTap: () => controller.setSelected("C"),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: optHeight,
                                      width: cardWitdh,
                                      decoration: BoxDecoration(
                                        color: UI.action,
                                        border: Border.all(
                                          color: (controller.selected.value ==
                                                      "C" ||
                                                  controller.answer[controller
                                                          .currentQuiz.value] ==
                                                      "C")
                                              ? Colors.green
                                              : Colors.transparent,
                                          width: 3,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(25),
                                        ),
                                      ),
                                      child: Text(
                                        "${d['c']}",
                                        style: TextStyle(
                                          overflow: TextOverflow.clip,
                                          fontSize: fontSizeAnswer,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  GestureDetector(
                                    onTap: () => controller.setSelected("D"),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: optHeight,
                                      width: cardWitdh,
                                      decoration: BoxDecoration(
                                        color: UI.action,
                                        border: Border.all(
                                          color: (controller.selected.value ==
                                                      "D" ||
                                                  controller.answer[controller
                                                          .currentQuiz.value] ==
                                                      "D")
                                              ? Colors.green
                                              : Colors.transparent,
                                          width: 3,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(25),
                                        ),
                                      ),
                                      child: Text(
                                        "${d['d']}",
                                        style: TextStyle(
                                          overflow: TextOverflow.clip,
                                          fontSize: fontSizeAnswer,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () =>
                                            (controller.currentQuiz.value == 0)
                                                ? null
                                                : {
                                                    controller
                                                        .currentQuiz.value--,
                                                    controller.selected.value =
                                                        "",
                                                  },
                                        style: ButtonStyle(
                                          maximumSize: MaterialStatePropertyAll(
                                              Size(cardWitdh, 75)),
                                          backgroundColor:
                                              const MaterialStatePropertyAll(
                                                  Colors.grey),
                                        ),
                                        child: Text(
                                          "Pref",
                                          style: TextStyle(
                                              fontSize: fontSizeAnswer,
                                              color: UI.action),
                                        ),
                                      ),
                                      //NEXT
                                      if (!controller.isLastQuiz.value)
                                        ElevatedButton(
                                          onPressed: () =>
                                              (controller.isLastQuiz.value)
                                                  ? null
                                                  : {
                                                      controller
                                                          .selected.value = "",
                                                      controller
                                                          .currentQuiz.value++,
                                                    },
                                          style: ButtonStyle(
                                            maximumSize:
                                                MaterialStatePropertyAll(
                                                    Size(cardWitdh, 75)),
                                            backgroundColor:
                                                const MaterialStatePropertyAll(
                                                    Colors.greenAccent),
                                          ),
                                          child: Text(
                                            "Next",
                                            style: TextStyle(
                                                fontSize: fontSizeAnswer,
                                                color: UI.action),
                                          ),
                                        ),

                                      if (controller.isLastQuiz.value)
                                        ElevatedButton(
                                          onPressed: () =>
                                              controller.isFinish.value = true,
                                          style: ButtonStyle(
                                            maximumSize:
                                                MaterialStatePropertyAll(
                                              Size(
                                                cardWitdh,
                                                75,
                                              ),
                                            ),
                                            backgroundColor:
                                                const MaterialStatePropertyAll(
                                              Colors.greenAccent,
                                            ),
                                          ),
                                          child: Text(
                                            "Finish",
                                            style: TextStyle(
                                              fontSize: fontSizeAnswer,
                                              color: UI.action,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  ElevatedButton(
                                    onPressed: () => controller.showNumber
                                        .value = !controller.showNumber.value,
                                    style: ButtonStyle(
                                      maximumSize: MaterialStatePropertyAll(
                                          Size(cardWitdh, 75)),
                                      backgroundColor:
                                          const MaterialStatePropertyAll(
                                              Colors.greenAccent),
                                    ),
                                    child: Text(
                                      "select number",
                                      style: TextStyle(
                                          fontSize: fontSizeAnswer,
                                          color: UI.action),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Column(
                                    children:
                                        List.generate(datas.length, (index) {
                                      return Offstage(
                                        offstage:
                                            controller.currentQuiz.value !=
                                                index,
                                        child: Container(
                                          alignment: Alignment.center,
                                          width:
                                              layar.width - (layar.width / 6),
                                          height: layar.height / 1.5,
                                          // child: WhiteBoard(
                                          //   strokeWidth: ukuranPensil.value,
                                          //   isErasing: erase.value,
                                          //   controller: controller.papan[index],
                                          // ),
                                          child: WhiteBoard(
                                            strokeWidth: ukuranPensil.value,
                                            isErasing: erase.value,
                                            controller: papan[
                                                controller.currentQuiz.value],
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          sp.value = !sp.value;
                                        },
                                        icon: Icon(
                                          (sp.value)
                                              ? Icons.edit_note
                                              : Icons.close,
                                          color: (sp.value)
                                              ? UI.action
                                              : Colors.red,
                                        ),
                                      ),
                                      if (!sp.value)
                                        PopupMenuButton(
                                          initialValue:
                                              ukuranPensil.value.toString(),
                                          icon: Icon(
                                            Icons.circle,
                                            size: (ukuranPensil.value * 2.5),
                                            color: UI.action,
                                          ),
                                          itemBuilder: (c) => [
                                            PopupMenuItem(
                                              value: "slider",
                                              child: SizedBox(
                                                width: 200,
                                                child: Slider(
                                                  min: 1,
                                                  max: 10,
                                                  value: ukuranPensil.value,
                                                  secondaryTrackValue:
                                                      ukuranPensilOld.value,
                                                  label: ukuranPensil.value
                                                      .toString(),
                                                  onChanged: (double value) {
                                                    ukuranPensilOld.value =
                                                        ukuranPensil.value;
                                                    ukuranPensil.value = value;
                                                    Get.back();
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                          onSelected: (v) {
                                            if (v == "slider") {
                                              // Do any additional actions here if needed
                                            }
                                          },
                                        ),
                                      if (!sp.value)
                                        IconButton(
                                          onPressed: () {
                                            erase.value = !erase.value;
                                          },
                                          icon: Icon(
                                            (!erase.value)
                                                ? Icons.delete
                                                : Icons.edit,
                                            color: UI.action,
                                          ),
                                        ),
                                      // if (!sp.value)
                                      //   IconButton(
                                      //     onPressed: () {
                                      //       papan[controller.currentQuiz.value]
                                      //           .undo();
                                      //     },
                                      //     icon: const Icon(
                                      //       Icons.arrow_back,
                                      //       color: UI.action,
                                      //     ),
                                      //   ),
                                      // if (!sp.value)
                                      //   IconButton(
                                      //     onPressed: () {
                                      //       papan[controller.currentQuiz.value]
                                      //           .redo();
                                      //     },
                                      //     icon: const Icon(
                                      //       Icons.arrow_forward,
                                      //       color: UI.action,
                                      //     ),
                                      //   ),
                                      // if (!sp.value)
                                      //   IconButton(
                                      //     onPressed: () {
                                      //       print(
                                      //           "Number ${controller.currentQuiz.value}");
                                      //       papan[controller.currentQuiz.value]
                                      //           .clear();
                                      //     },
                                      //     icon: const Icon(
                                      //       Icons.clear_all,
                                      //       color: UI.action,
                                      //     ),
                                      //   ),
                                   
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Show number
                          Visibility(
                            visible: controller.showNumber.value,
                            child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    width: layar.width - (layar.width / 3),
                                    height: layar.height / 2,
                                    decoration: const BoxDecoration(
                                      color: UI.foreground,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(25),
                                      ),
                                    ),
                                    child: GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                      ),
                                      itemCount: datas.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            controller.currentQuiz.value =
                                                index;
                                            controller.showNumber.value = false;
                                          },
                                          child: Card(
                                            color: (controller
                                                        .currentQuiz.value ==
                                                    index)
                                                ? Colors.grey
                                                : ((controller.answer[index] !=
                                                        "")
                                                    ? Colors.lightGreenAccent
                                                    : Colors.redAccent),
                                            child: Center(
                                              child: Text(
                                                "${index + 1}",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      controller.showNumber.value = false;
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Finish
                          Visibility(
                            visible: controller.isFinish.value,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      controller.isFinish.value = false;
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: layar.height - layar.height / 3,
                                      width: cardWitdh,
                                      color: UI.object,
                                      child: ListView.builder(
                                        itemCount: controller.answer.length,
                                        itemBuilder: (context, index) {
                                          var d = datas[index].data();
                                          var pList1 =
                                              "${d['q1'][0]}X ${d['q1'][3]} ${d['q1'][1]}Y = ${d['q1'][2]}";
                                          var pList2 =
                                              "${d['q1'][0]}X ${d['q1'][3]} ${d['q1'][1]}Y = ${d['q1'][2]}";

                                          controller.tf[index] = d['answer'] ==
                                              controller.answer[index];
                                          return Container(
                                            margin: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color:
                                                  (controller.answer[index] !=
                                                          "")
                                                      ? Colors.greenAccent
                                                      : UI.action,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(25)),
                                            ),
                                            child: ListTile(
                                              tileColor: UI.backgroud,
                                              onTap: () {
                                                controller.isFinish.value =
                                                    false;
                                                controller.currentQuiz.value =
                                                    index;
                                              },
                                              title: Text(
                                                "${index + 1}. $pList1, $pList2",
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                              subtitle: Text(
                                                (controller.answer[index] != "")
                                                    ? "Terjawab"
                                                    : "Belum Dijawab",
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  ElevatedButton(
                                      onPressed: () {
                                        // SAVE
                                        controller.saveAnswer(Get.arguments);
                                        //END SAVE
                                        //TO finish
                                        Get.offAndToNamed(Routes.HOME,
                                            arguments: Get.arguments);
                                        Get.toNamed(Routes.FINISH,
                                            arguments: controller.answer);
                                        // Get.offAndToNamed(Routes.FINISH);
                                      },
                                      style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                UI.foreground),
                                      ),
                                      child: const Text(
                                        "Finish Now",
                                        style: TextStyle(
                                            fontSize: 15, color: UI.action),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    });
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),

            // Menu
            // Menu.user,
          ],
        ),
      ),
    );
  }
}
