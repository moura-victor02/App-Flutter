import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  var valorCodigoBarras = '';
  Future<void> escanearCodigodeBarras() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancelar', true, ScanMode.BARCODE);

    if (barcodeScanRes == '-1') {
      Get.snackbar('Canceled', "Leitura foi de arrasta");
    } else {
      valorCodigoBarras = barcodeScanRes;
      update();
    }
  }
}
