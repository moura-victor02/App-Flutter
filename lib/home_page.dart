import 'package:flutter/material.dart';
import './home_page_controller.dart';
import 'package:get/get.dart';

class Homepage extends StatelessWidget {
  Homepage() {
    Get.put(HomePageController());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Leitor de Código de Barras'),
        backgroundColor: theme.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Valor do código de barras:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                ),
                SizedBox(height: 8.0),
                GetBuilder<HomePageController>(
                  builder: (controller) {
                    return Text(
                      controller.valorCodigoBarras,
                      style: theme.textTheme.bodyText1,
                    );
                  },
                ),
                SizedBox(height: 24.0),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.find<HomePageController>()
                                .escanearCodigodeBarras();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.qr_code_scanner,
                                  color: theme.colorScheme.onPrimary,
                                ),
                                SizedBox(width: 8.0),
                                Text(
                                  'Ler código de barras',
                                  style: TextStyle(
                                    color: theme.colorScheme.onPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
