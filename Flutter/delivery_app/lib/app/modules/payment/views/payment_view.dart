import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:app/app/modules/payment/controllers/payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Realizar pago'),
        centerTitle: true,
      ),
      body: InAppWebView(
        initialUrl:
            "https://pagos.wompi.sv/IntentoPago/Index?idIntentoPago=94d932b9-bebb-4a76-896a-33ca46ab2948&hash=F722D833284FDEA9EE4768924C1FE790C4D872FE05ED3CD3ADBAAEB8C3466805",
        initialHeaders: {},
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            debuggingEnabled: true,
          ),
        ),
        onWebViewCreated: (InAppWebViewController controller) {},
        onLoadStart: (InAppWebViewController controller, String url) {
          print(url);
          if (url.contains("IntentoPago/Gracias?idTransaccion")) {
            Get.offAllNamed(Routes.RESULT);
          }
        },
        onLoadStop: (InAppWebViewController controller, String url) async {},
        onProgressChanged: (InAppWebViewController controller, int progress) {},
      ),
    );
  }
}
