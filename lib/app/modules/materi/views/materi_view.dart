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
            child: Container(
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
                      Get.toNamed(Routes.VIDEO, arguments: {
                        "idVideo": "1",
                      });
                    },
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(UI.object)),
                    child: const Text(
                      "Video 1",
                      style: TextStyle(color: UI.action),
                    ),
                  ),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.VIDEO, arguments: {
                        "idVideo": "2",
                      });
                    },
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(UI.object)),
                    child: const Text(
                      "Video 2",
                      style: TextStyle(color: UI.action),
                    ),
                  ),
                  const SizedBox(height: 5),

                  ElevatedButton(
                    onPressed: () {
                      Get.defaultDialog(
                        title: "Info",
                        textConfirm: "Mulai",
                        textCancel: "Batal",
                        middleText: "Apakah anda ingin memulai menjawab soal?",
                        backgroundColor: UI.foreground,
                        titleStyle: const TextStyle(color: UI.action),
                        middleTextStyle: const TextStyle(color: UI.action),
                        cancelTextColor: UI.action,
                        onConfirm: () {
                          Get.back();
                          Get.offAndToNamed(Routes.SOAL,
                              arguments: Get.arguments);
                        },
                      );
                    },
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(UI.object)),
                    child: const Text(
                      "Soal",
                      style: TextStyle(color: UI.action),
                    ),
                  ),

                  ],
              ),
            ),
          ),
          Menu.user,
        ],
      ),
    );
  }
}
