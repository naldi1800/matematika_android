import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:matematika/app/util/menu.dart';
import 'package:matematika/app/util/ui.dart';

import '../controllers/add_soal_controller.dart';

class AddSoalView extends GetView<AddSoalController> {
  const AddSoalView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var layar = MediaQuery.of(context).size;
    var cardWitdh = (layar.width / 4) + (layar.width / 2) + (layar.width / 10);
    // var optHeight = 50.0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: UI.backgroud,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                width: cardWitdh,
                height: layar.height - 50,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Persamaan 1",
                        style: TextStyle(
                          color: UI.action,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 5),
                      UI.perInput(controller.cQ1),
                      const SizedBox(height: 10),
                      const Text(
                        "Persamaan 2",
                        style: TextStyle(
                          color: UI.action,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 5),
                      UI.perInput(controller.cQ2),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 150,
                        child: UI.textInput(controller.cCerita,
                            label: "cerita", mLine: null, expand: true),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 150,
                        child: UI.textInput(controller.cPenjelasan,
                            label: "penjelasan", mLine: null, expand: true),
                      ),
                      const SizedBox(height: 10),
                      UI.textInput(
                        controller.cOptA,
                        label: "Opsi A",
                      ),
                      const SizedBox(height: 10),
                      UI.textInput(
                        controller.cOptB,
                        label: "Opsi B",
                      ),
                      const SizedBox(height: 10),
                      UI.textInput(
                        controller.cOptC,
                        label: "Opsi C",
                      ),
                      const SizedBox(height: 10),
                      UI.textInput(
                        controller.cOptD,
                        label: "Opsi D",
                      ),
                      const SizedBox(height: 10),
                      UI.textInput(
                        controller.cAnswer,
                        label: "Answer",
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              controller.clear();
                            },
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(UI.action),
                            ),
                            child: const Text(
                              "Clear",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: UI.object),
                            ),
                          ),
                          const SizedBox(width: 5),
                          ElevatedButton(
                            onPressed: () async {
                              controller.save();
                            },
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(UI.action),
                            ),
                            child: const Text(
                              "Save",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: UI.object),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 75),
                    ],
                  ),
                ),
              ),
            ),
            Menu.admin
          ],
        ),
      ),
    );
  }
}
