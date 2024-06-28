import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../utils/utils.dart';

class LoadingLayer extends StatelessWidget {
  const LoadingLayer({
    super.key, 
    required this.child, 
    required this.isLoading,
    required this.isProgress,
    this.progress,
  });

  final Widget child;
  final bool isLoading;
  final bool isProgress;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        isProgress && !isLoading
        ? Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black54,
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * .2,
                width: MediaQuery.of(context).size.width * .40,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CircularProgressIndicator.adaptive(
                        value: progress,
                        strokeWidth: 5.0,
                        backgroundColor: Colors.grey,
                        valueColor: const AlwaysStoppedAnimation(Colors.white),
                      ),
                      Text(
                        '${(progress! * 100).toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorString.white
                        )
                      ),
                      Text(
                        'uploading...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorString.white
                        )
                      )
                    ]
                  ),
                ),
              ),
            ),
          )
        : isLoading && !isProgress 
          ? Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black54,
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * .2,
                  width: MediaQuery.of(context).size.width * .40,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SpinKitThreeBounce(
                          color: Colors.white,
                          size: 30,
                        ),
                        Text(
                          'loading...',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorString.white
                          )
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox.shrink()
      ]
    );
  }
}
