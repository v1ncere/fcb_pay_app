import 'package:fcb_pay_app/pages/scanner/scanner.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerView extends StatefulWidget {
  const ScannerView({super.key});
  @override
  State<ScannerView> createState() => ScannerState();
}

class ScannerState extends State<ScannerView> {
  final cameraController = MobileScannerController();
  
  @override
  Widget build(BuildContext context) {
    double scanArea = (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400)
      ? 200.0
      : 330.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scan', style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.w300
        )),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state) {
                  case CameraFacing.front:
                    return const FaIcon(FontAwesomeIcons.cameraRotate, color: Colors.green);
                  case CameraFacing.back:
                    return const FaIcon(FontAwesomeIcons.cameraRotate, color: Colors.green);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              //final Uint8List? image = capture.image;
              for (final barcode in barcodes) {
                debugPrint('BARCODE FOUND! ${barcode.rawValue}');
              }
            },
          ),
          Positioned.fill(
            child: Container(
              decoration: ShapeDecoration(
                shape: QrScannerOverlayShape(
                  borderColor: const Color(0xFF02AE08),
                  borderRadius: 10,
                  borderLength: 18,
                  borderWidth: 8,
                  cutOutSize: scanArea,
                )
              )
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}