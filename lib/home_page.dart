import 'package:flutter/material.dart';
import './home_page_controller.dart';
import 'package:get/get.dart';

class Homepage extends StatelessWidget {
  Homepage() {
    Get.put(HomePageController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BarCode Scanner'),
        ),
        body: SizedBox.expand(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Valor código de barras:',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.red,
                    fontSize: 25)),
            GetBuilder<HomePageController>(
              builder: (controller) {
                return Text(controller.valorCodigoBarras,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 15));
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextButton.icon(
              icon: Image.asset(
                'assets/icon.png',
                width: 50,
              ),
              label: Text(
                'Ler código de barras',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
              ),
              onPressed: () {
                Get.find<HomePageController>().escanearCodigodeBarras();
              },
            )
          ]),
        ));
  }
}
