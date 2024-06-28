import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerErrorWidget extends StatelessWidget {
  const ScannerErrorWidget({super.key, required this.error, required this.area});
  final double area;
  final MobileScannerException error;

  @override
  Widget build(BuildContext context) {
    String errorMessage;

    switch (error.errorCode) {
      case MobileScannerErrorCode.controllerUninitialized:
        errorMessage = 'Controller not ready.';
        break;
      case MobileScannerErrorCode.permissionDenied:
        errorMessage = 'Permission denied';
        break;
      case MobileScannerErrorCode.unsupported:
        errorMessage = 'Scanning is unsupported on this device';
        break;
      default:
        errorMessage = 'Oops! Something went wrong. Please try again.';
        break;
    }

    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: SizedBox(
          height: area - 10,
          width: area - 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 15, bottom: 15, left: 15),
                child: Icon(Icons.error, color: Colors.white),
              ),
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                error.errorDetails?.message ?? '',
                style: const TextStyle(color: Colors.white),
              )
            ]
          ),
        )
      )
    );
  }
}
