import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:matematika/app/routes/app_pages.dart';
import 'package:matematika/app/util/menu.dart';
import 'package:matematika/app/util/ui.dart';

import '../controllers/materi_controller.dart';

class MateriView extends GetView<MateriController> {
  const MateriView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var layar = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: UI.backgroud,
      body: Stack(
        children: [
          SafeArea(
            child: StreamBuilder(
                stream: controller.getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    var datas = snapshot.data!.docs;
                    controller.userData();
                    return Obx(() {
                      // print(controller.userLevel);
                      // print(controller.userAnswer);
                      // print(controller.userSelected);
                      print(controller.userLevel);
                      //  print(Get.arguments);
                      return Container(
                        width: layar.width,
                        height: layar.height,
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 15),
                            const Text(
                              "Materi Sistem Persamaan Linear Dua Variabel",
                              style: TextStyle(fontSize: 20, color: UI.action),
                            ),
                            const SizedBox(height: 15),
                            ElevatedButton(
                              onPressed: () {
                                if (controller.user.isNotEmpty) {
                                  if (controller.user['video'] == 0) {
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(Get.arguments)
                                        .update({"video": 1});
                                  }
                                  Get.offAndToNamed(Routes.VIDEO, arguments: {
                                    "idVideo": "1",
                                    "id": Get.arguments,
                                    "user": true,
                                  });
                                } else {
                                  UI.warning(
                                    msg:
                                        "Tunggu sebentar, masih proses load data",
                                  );
                                }
                              },
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(UI.object)),
                              child: const Text(
                                "Video 1",
                                style: TextStyle(color: UI.action),
                              ),
                            ),
                            const SizedBox(height: 5),
                            ElevatedButton(
                              onPressed: () {
                                if (controller.user.isNotEmpty) {
                                  if (controller.user['video'] > 0) {
                                    if (controller.user['video'] == 1) {
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(Get.arguments)
                                          .update({"video": 2});
                                    }
                                    Get.offAndToNamed(Routes.VIDEO, arguments: {
                                      "idVideo": "2",
                                      "id": Get.arguments,
                                      "user": true,
                                    });
                                  } else {
                                    UI.warning(
                                      msg:
                                          "Anda harus menonton Video 1 terlebih dahulu",
                                    );
                                  }
                                }
                              },
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(UI.object)),
                              child: const Text(
                                "Video 2",
                                style: TextStyle(color: UI.action),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              alignment: Alignment.centerLeft,
                              width: double.infinity,
                              child: const Text(
                                "Soal :",
                                style:
                                    TextStyle(fontSize: 20, color: UI.action),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Visibility(
                              visible: controller.onLoad.value,
                              child: Expanded(
                                child: ListView.builder(
                                  itemCount: datas.length,
                                  itemBuilder: (context, index) {
                                    // var d = datas[index].data();
                                    return Container(
                                      padding: const EdgeInsets.all(5),
                                      width: double.infinity,
                                      height: 65,
                                      child: ListTile(
                                        onTap: () {
                                          if (controller.user.isNotEmpty) {
                                            if (controller.user['video'] > 1) {
                                              if (index > 0) {
                                                controller.userAnswer
                                                    .forEach((element) {
                                                  if (datas[index - 1].id ==
                                                      element['idSoal']) {
                                                    if (element['isTrue']) {
                                                      // print(datas[index].id);
                                                      if (!controller.userLevel
                                                          .containsKey(
                                                              datas[index]
                                                                  .id)) {
                                                        Get.offAndToNamed(
                                                          Routes.SOAL,
                                                          arguments: {
                                                            "id_user":
                                                                Get.arguments,
                                                            "id_soal":
                                                                datas[index].id,
                                                          },
                                                        );
                                                      } else {
                                                        if (!controller
                                                                .userLevel[
                                                            datas[index].id]) {
                                                          Get.offAndToNamed(
                                                            Routes.SOAL,
                                                            arguments: {
                                                              "id_user":
                                                                  Get.arguments,
                                                              "id_soal":
                                                                  datas[index]
                                                                      .id,
                                                            },
                                                          );
                                                        } else {
                                                          Get.offAndToNamed(
                                                            Routes.FINISH,
                                                            arguments: {
                                                              "id_user":
                                                                  Get.arguments,
                                                              "id_soal":
                                                                  datas[index]
                                                                      .id,
                                                              "answer": controller
                                                                      .userSelected[
                                                                  datas[index]
                                                                      .id],
                                                            },
                                                          );
                                                        }
                                                      }
                                                    } else {
                                                      UI.warning(
                                                        msg:
                                                            "Selesaikan soal sebelumnya",
                                                      );
                                                    }
                                                  }
                                                });
                                                if (controller
                                                    .userAnswer.isEmpty) {
                                                  UI.warning(
                                                    msg:
                                                        "Selesaikan soal sebelumnya",
                                                  );
                                                }
                                              } else {
                                                if (!controller.userLevel
                                                    .containsKey(
                                                        datas[index].id)) {
                                                  Get.offAndToNamed(
                                                    Routes.SOAL,
                                                    arguments: {
                                                      "id_user": Get.arguments,
                                                      "id_soal":
                                                          datas[index].id,
                                                    },
                                                  );
                                                } else {
                                                  if (!controller.userLevel[
                                                      datas[index].id]) {
                                                    Get.offAndToNamed(
                                                      Routes.SOAL,
                                                      arguments: {
                                                        "id_user":
                                                            Get.arguments,
                                                        "id_soal":
                                                            datas[index].id,
                                                      },
                                                    );
                                                  } else {
                                                    Get.offAndToNamed(
                                                      Routes.FINISH,
                                                      arguments: {
                                                        "id_user":
                                                            Get.arguments,
                                                        "id_soal":
                                                            datas[index].id,
                                                        "answer": controller
                                                                .userSelected[
                                                            datas[index].id],
                                                      },
                                                    );
                                                  }
                                                }
                                              }
                                            } else {
                                              UI.warning(
                                                msg:
                                                    "Anda harus menonton Video 1 dan 2 terlebih dahulu",
                                              );
                                            }
                                          }
                                        },
                                        tileColor: UI.foreground,
                                        title: Text(
                                          "Nomor ${index + 1} ",
                                          style: const TextStyle(
                                            color: UI.action,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
          Menu.user,
        ],
      ),
    );
  }
}
