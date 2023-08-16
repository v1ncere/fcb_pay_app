import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:fcb_pay_app/app/app.dart';
import 'package:fcb_pay_app/pages/scanner/scanner.dart';
import 'package:fcb_pay_app/pages/scanner/widgets/widgets.dart';
import 'package:fcb_pay_app/utils/utils.dart';

class ScannerView extends StatefulWidget {
  const ScannerView({super.key});
  
  @override
  State<ScannerView> createState() => ScannerViewState();
}

class ScannerViewState extends State<ScannerView> {
  final _controller = MobileScannerController(detectionSpeed: DetectionSpeed.normal);

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    double area = screen.width < 400 || screen.height < 400 ? 250.0 : 360.0;
    final rect = Rect.fromLTWH((screen.width - area)/ 2, (screen.height - area)/ 2, area, area);

    return Scaffold(
      appBar: AppBar(actions: [toggleTorch()]),
      body: BlocListener<ScannerCubit, ScannerState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status.isSuccess) {
            context.flow<AppStatus>().update((state) => AppStatus.scannerTransaction);
          }
          if (state.status.isError) {
            ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Stack(
          children: [
            MobileScanner(
              controller: _controller,
              placeholderBuilder: (_, __) => Container(color: Colors.black),
              errorBuilder: (_, __, ___) => ScannerErrorText(area: area),
              scanWindow: rect,
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  context.read<ScannerCubit>().saveQRCode(barcode.rawValue!);
                }
              }
            ),
            Positioned.fill(
              child: Container(
                decoration: ShapeDecoration(
                  shape: QrScannerOverlayShape(
                    borderColor: const Color(0xFF02AE08),
                    borderRadius: 10,
                    borderLength: 20,
                    borderWidth: 8,
                    cutOutSize: area
                  )
                )
              )
            ),
            const ScannerText()
          ]
        )
      )
    );
  }

  Widget toggleTorch() {
    return  IconButton(
      color: Colors.white,
      iconSize: 32.0,
      icon: ValueListenableBuilder(
        valueListenable: _controller.torchState,
        builder: (_, torch, __) {
          switch (torch) {
            case TorchState.off:
              return const Icon(
                FontAwesomeIcons.bolt,
                size: 18,
                color:Colors.grey
              );
            case TorchState.on:
              return const Icon(
                FontAwesomeIcons.bolt,
                size: 18, 
                color:Colors.yellow
              );
          }
        }
      ),
      onPressed: () => _controller.toggleTorch()
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}