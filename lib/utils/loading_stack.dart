import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'utils.dart';

class LoadingStack extends StatelessWidget {
  const LoadingStack({
    super.key, 
    required this.child, 
    required this.isLoading,
  });

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if(isLoading)
          Container(
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
                    ]
                  )
                )
              )
            )
          )
      ]
    );
  }
}