import 'package:flutter/material.dart';

class FlexWidgets extends StatelessWidget {
  const FlexWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GeeksforGeeks'),
        backgroundColor: Colors.greenAccent[400],
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
          tooltip: 'Menu',
        )
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              
              
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red
                        )
                      )
                    ),
                    const SizedBox(width: 20),

                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red
                        )
                      )
                    )
                  ]
                )
              ),
              const SizedBox(height: 20),

              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                  width: 380,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue)
                )
              ),
              const SizedBox(height: 20),

              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Container(
                        width: 180,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.cyan
                        )
                      )
                    ),
                    const SizedBox(width: 20),

                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Container(
                        width: 180,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.cyan
                        )
                      )
                    )

                  ]
                )
              )


            ]
          )
        )
      )
    );
  }
}