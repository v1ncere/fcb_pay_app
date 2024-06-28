import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../app/app.dart';
import '../../../../utils/utils.dart';
import '../../local_authentication.dart';
import '../widgets/widgets.dart';

class UpdatePinView extends StatelessWidget {
  const UpdatePinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          TextString.updatePin,
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
            onPressed: () => context.flow<AppStatus>().update((state) => AppStatus.authenticated),
          )
        ],
        automaticallyImplyLeading: false
      ),
      body: BlocListener<UpdatePinBloc, UpdatePinState>(
        listener: (context, state) {
          // current pincode successful
          if (state.status.isCurrentEquals) {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) => AlertDialog(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                backgroundColor: ColorString.emerald,
                title: Center(
                  child: Text(
                    TextString.currentPinAccepted,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: ColorString.white),
                  )
                ),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'OK',
                      style: TextStyle(color: ColorString.white)
                    )
                  )
                ]
              )
            );
          }
          // current pincode failure
          if (state.status.isCurrentUnequals) {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) => AlertDialog(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                backgroundColor: ColorString.guardsmanRed,
                title: Center(
                  child: Text(
                    TextString.currentPinRejected,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: ColorString.white)
                  )
                ),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'OK',
                      style: TextStyle(color: ColorString.white)
                    )
                  )
                ]
              )
            );
          }
          // update pincode successful
          if (state.status.isUpdateEquals) {
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
                      TextString.updatePinSuccess,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: ColorString.white)
                    )
                  ),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    TextButton(
                      // to force refresh the app
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
          // update pincode failure
          if (state.status.isUpdateUnequals) {
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
                    onPressed: () => Navigator.pop(context),
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
