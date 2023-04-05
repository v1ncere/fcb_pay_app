import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:unicons/unicons.dart';

class ScannerView extends StatefulWidget {
  const ScannerView({super.key});
  @override
  State<ScannerView> createState() => ScannerState();
}

class ScannerState extends State<ScannerView> {
  final cameraController = MobileScannerController();
  
  @override
  Widget build(BuildContext context) {
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
                      return const Icon(UniconsLine.bolt_slash, color: Colors.grey);
                    case TorchState.on:
                      return const Icon(UniconsLine.bolt, color: Colors.yellow);
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
                      return const Icon(UniconsLine.exchange, color: Colors.green);
                    case CameraFacing.back:
                      return const Icon(UniconsLine.exchange_alt, color: Colors.green);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.switchCamera(),
            ),
          ],
        ),
        body: MobileScanner(
          controller: cameraController,
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            //final Uint8List? image = capture.image;
            for (final barcode in barcodes) {
              debugPrint('BARCODE FOUND! ${barcode.rawValue}');
            }
        }),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}