import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:fcb_pay_app/pages/payment/payment.dart';
import 'package:fcb_pay_app/pages/scanner/cubit/scanner_cubit.dart';
import 'package:fcb_pay_app/pages/scanner/scanner.dart';

class ScannerView extends StatefulWidget {
  const ScannerView({super.key});
  @override
  State<ScannerView> createState() => ScannerViewState();
}

class ScannerViewState extends State<ScannerView> {
  final cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  @override
  Widget build(BuildContext context) {
    double scanArea = (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400)
      ? 250.0
      : 360.0;
    final screenSize = MediaQuery.of(context).size;
    final rectLeft = (screenSize.width - scanArea) / 2;
    final rectTop = (screenSize.height - scanArea) / 2;
    final rect = Rect.fromLTWH(rectLeft, rectTop, scanArea, scanArea);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(FontAwesomeIcons.boltLightning, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(FontAwesomeIcons.boltLightning, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
        ],
      ),
      body: BlocListener<ScannerCubit, ScannerState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state.status.isSuccess) {
            Navigator.of(context).pushReplacement(PaymentPage.route());
          }
        },
        child: Stack(
          children: [
            MobileScanner(
              controller: cameraController,
              placeholderBuilder: (ctx, widget) {
                return Container(
                  color: Colors.black,
                );
              },
              errorBuilder: (ctx, exception, widget) {
                return Container(
                  color: Colors.black,
                  child: Center(
                    child: SizedBox(
                      height: scanArea - 10,
                      width: scanArea - 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text("Oops! Something went wrong. Please try again.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.redAccent[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              scanWindow: rect,
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  context.read<ScannerCubit>().saveQRCode(barcode.rawValue!);
                }
              },
            ),
            Positioned.fill(
              child: Container(
                decoration: ShapeDecoration(
                  shape: QrScannerOverlayShape(
                    borderColor: const Color(0xFF02AE08),
                    borderRadius: 10,
                    borderLength: 20,
                    borderWidth: 8,
                    cutOutSize: scanArea,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Scan QR Code", 
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                      fontWeight: FontWeight.w900
                    )
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}