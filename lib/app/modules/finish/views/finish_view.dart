import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:matematika/app/util/ui.dart';

import '../controllers/finish_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class FinishView extends GetView<FinishController> {
  const FinishView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(Get.arguments);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Penjelasan',
          style: TextStyle(color: UI.action),
        ),
        centerTitle: true,
        backgroundColor: UI.foreground,
      ),
      backgroundColor: UI.backgroud,
      body: StreamBuilder(
          stream: controller.getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              var datas = snapshot.data!.docs;
              // print(datas.length);
              return Obx(() {
                if (controller.currentQuiz.value >= datas.length)
                  controller.currentQuiz.value = datas.length - 1;
                // print("number ${controller.currentQuiz.value}");
                // print("Number ele3 ${controller.currentQuiz.value}");
                var d = datas[controller.currentQuiz.value].data();

                controller.isLastQuiz.value =
                    datas.length - 1 == controller.currentQuiz.value;

                controller.change(d['q1'], d['q2']);
                var per1 =
                    "${d['q1'][0]}x ${d['q1'][3]} ${d['q1'][1]}y = ${d['q1'][2]}";
                var per2 =
                    "${d['q2'][0]}x ${d['q2'][3]} ${d['q2'][1]}y = ${d['q2'][2]}";

                final List<XYData> xydata1 = <XYData>[
                  XYData(controller.p1[0][0], controller.p1[0][1]),
                  XYData(controller.p1[1][0], controller.p1[1][1]),
                ];
                final List<XYData> xydata2 = <XYData>[
                  XYData(controller.p2[0][0], controller.p2[0][1]),
                  XYData(controller.p2[1][0], controller.p2[1][1]),
                ];
                controller.changeNumber.value = false;
                // print(xydata1);
                // print(xydata2);F
                if (controller.changeNumber.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            // print(
                            //     "${d['answer']} = ${Get.arguments[controller.currentQuiz.value].toString().toLowerCase()}");
                            return Container(
                              width: 50,
                              margin: const EdgeInsets.all(7),
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.currentQuiz.value = index;
                                  controller.changeNumber.value = true;
                                  print(
                                      "Number ele ${controller.currentQuiz.value}");
                                },
                                style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(UI.foreground
                                          // (d['answer'] ==
                                          //         Get.arguments[controller
                                          //                 .currentQuiz.value]
                                          //             .toString()
                                          //             .toLowerCase())
                                          //     ? Colors.greenAccent
                                          //     : Colors.redAccent,
                                          ),
                                ),
                                child: Text(
                                  "${index + 1}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: UI.action,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: datas.length,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: double.infinity,
                        height: 100,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "${controller.currentQuiz + 1}. Jika $per1 dan $per2 maka x dan y adalah ?",
                          style: const TextStyle(
                            color: UI.action,
                            fontSize: 20,
                          ),
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 100,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Jawaban benar adalah (${d['answer']}. ${d[d['answer'].toString().toLowerCase()]}, jawaban anda ${Get.arguments[controller.currentQuiz.value - 1]})",
                          style:  TextStyle(
                            color:
                                (Get.arguments[controller.currentQuiz.value - 1]
                                            .toString()
                                            .toLowerCase() ==
                                        d['answer'])
                                    ? UI.action
                                    : Colors.red,
                            fontSize: 20,
                          ),
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        // height: 500,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: HtmlWidget(
                          "${d['penj']}",
                          textStyle:
                              const TextStyle(color: UI.action, fontSize: 15),
                        ),
                      ),
                      Container(
                        width: 300,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: SfCartesianChart(
                          primaryXAxis: const NumericAxis(),
                          series: <CartesianSeries>[
                            LineSeries<XYData, double>(
                              dataSource: xydata1,
                              color: Colors.blue,
                              xValueMapper: (XYData d, _) => d.x,
                              yValueMapper: (XYData d, _) => d.y,
                            ),
                            LineSeries<XYData, double>(
                              dataSource: xydata2,
                              color: Colors.green,
                              xValueMapper: (XYData d, _) => d.x,
                              yValueMapper: (XYData d, _) => d.y,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class XYData {
  XYData(this.x, this.y);
  final double x;
  final double y;
}
