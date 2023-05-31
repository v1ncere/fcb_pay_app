import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PesoTransfer extends StatelessWidget {
  const PesoTransfer({
    super.key,
    required this.text,
    required this.colors,
    required this.methods,
  });
  final String text;
  final Color colors;
  final Function()? methods;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      width: MediaQuery.of(context).size.width,
      child: ClipRect(
        clipBehavior: Clip.antiAlias,
        child: Material(
          color: colors, 
          borderRadius: BorderRadius.circular(30.0),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    FontAwesomeIcons.share,
                    color: Colors.green,
                  ),
                  onPressed: methods,
                  tooltip: "go",
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                     const Text("PESO TRANSFER",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: ClipRect(
                        child: Material(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(15.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(text,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w300,
                                fontSize: 16.0,
                              ),
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