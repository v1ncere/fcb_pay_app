import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../app/app.dart';
import '../../../../utils/utils.dart';
import '../../local_authentication.dart';
import '../widgets/widgets.dart';

class CreatePinView extends StatelessWidget {
  const CreatePinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          TextString.setupPin, 
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF687ea1)
          )
        ),
        actions: [
          IconButton(
            icon: const Icon(
              FontAwesomeIcons.x, 
              size: 18,
              color: Color(0xFF687ea1)
            ),
            onPressed: () async => Navigator.of(context).pop(),
          )
        ],
        automaticallyImplyLeading: false
      ),
      body: BlocListener<CreatePinBloc, CreatePinState>(
        listener: (context, state) {
          // pincode create successful
          if (state.status.isEquals) {
            showDialog(
              context: context,
              barrierDismissible: false,
              useRootNavigator: false,
              builder: (context) => BlocProvider.value(
                value: BlocProvider.of<AppBloc>(context),
                child: AlertDialog(
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                  backgroundColor: ColorString.emerald,
                  title: Center(
                    child: Text(
                      TextString.confirmPinSuccess,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: ColorString.white)
                    )
                  ),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    TextButton(
                      onPressed: () async => await Navigator.of(context).push(App.route()),
                      child: Text(
                        'OK',
                        style: TextStyle(color: ColorString.white)
                      )
                    )
                  ]
                )
              )
            );
          }
          // pincode unequals
          if (state.status.isUnequals) {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) => AlertDialog(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                backgroundColor: ColorString.guardsmanRed,
                title: Center(
                  child: Text(
                    TextString.confirmPinFailure,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: ColorString.white)
                  )
                ),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'OK',
                      style: TextStyle(color: ColorString.white)
                    )
                  )
                ]
              )
            );
          }
        },
        child: const Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(flex: 2, child: InputPin()),
            Expanded(flex: 3, child: NumPad())
          ]
        )
      )
    );
  }
}
