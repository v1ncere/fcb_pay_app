import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../app/app.dart';
import '../../../utils/utils.dart';
import '../../home_flow/home_flow.dart';
import '../../local_authentication/local_authentication.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return InactivityDetector(
      onInactive: () => context.flow<HomeRouterStatus>().complete(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Settings',
            style: TextStyle(
              color: ColorString.jewel,
              fontWeight: FontWeight.w700
            )
          ),
          actions: [
            IconButton(
              onPressed: () => context.flow<HomeRouterStatus>().update((state) => HomeRouterStatus.appBar),
              icon: const Icon(FontAwesomeIcons.x, size: 18)
            )
          ]
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Column(
            children: [
              const Divider(),
              BlocBuilder<BiometricCubit, BiometricState>(
                builder: (context, state) {
                  if (state.status.isUnsupported) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              state.message,
                              style: const TextStyle(color: Colors.black45)
                            )
                          )
                        ),
                        Switch.adaptive(
                          activeColor: Colors.cyan,
                          activeTrackColor: Colors.cyanAccent,
                          inactiveThumbColor: Colors.blueGrey.shade600,
                          inactiveTrackColor: Colors.grey.shade400,
                          splashRadius: 50.0,
                          value: false,
                          onChanged: (_) {},
                        )
                      ]
                    );
                  }
                  if (state.status.isDisabled) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              state.message,
                              style: const TextStyle(color: Colors.black45)
                            ),
                          )
                        ),
                        Switch.adaptive(
                          activeColor: Colors.cyan,
                          activeTrackColor: Colors.cyanAccent,
                          inactiveThumbColor: Colors.blueGrey.shade600,
                          inactiveTrackColor: Colors.grey.shade400,
                          splashRadius: 50.0,
                          value: false,
                          onChanged: (_) {},
                        )
                      ]
                    );
                  }
                  if (state.status.isEnabled) {
                    return BlocBuilder<FingerprintCubit, FingerprintState>(
                      builder: (context, fingerPrintState) {
                        if (fingerPrintState.status.isLoading) {
                          return const Center(child: CircularProgressIndicator.adaptive());
                        }
                        if (fingerPrintState.status.isSuccess) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    state.message,
                                    style: const TextStyle(color: Colors.black45)
                                  ),
                                )
                              ),
                              Switch.adaptive(
                                activeColor: Colors.cyan,
                                activeTrackColor: Colors.cyanAccent,
                                inactiveThumbColor: Colors.blueGrey.shade600,
                                inactiveTrackColor: Colors.grey.shade400,
                                splashRadius: 50.0,
                                value: fingerPrintState.biometric,
                                onChanged: (_) => context.read<FingerprintCubit>().toggleBiometricStatus(),
                              )
                            ]
                          );
                        }
                        else {
                          return const SizedBox.shrink();
                        }
                      }
                    );
                  }
                  else {
                    return const SizedBox.shrink();
                  }
                }
              ),
              const Divider(),
              TextButton(
                onPressed: () {
                  context.flow<HomeRouterStatus>().complete();
                  context.flow<AppStatus>().update((state) => AppStatus.updatePin);
                },
                child: const Text('Update Pin')
              ),
              const Divider(),
              TextButton(
                onPressed: () {
                  context.flow<HomeRouterStatus>().update((state) => HomeRouterStatus.updatePassword);
                },
                child: const Text('Update Password')
              ),
              const Divider()
            ]
          )
        )
      ),
    );
  }
}
