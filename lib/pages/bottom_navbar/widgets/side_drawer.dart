import 'package:firebase_auth/firebase_auth.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../app/app.dart';
import '../../../utils/asset_string.dart';
import '../../home_flow/home_flow.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final email = FirebaseAuth.instance.currentUser?.email;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text(email ?? 'example@email.com'),
            accountName: const Text('Hello'),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Color(0xFF00695C),
              child: ClipOval(
                child: Icon(
                  FontAwesomeIcons.faceSmile,
                  color: Colors.white,
                  size: 50
                )
              )
            ),
            decoration: const BoxDecoration(
              color: Colors.green,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(AssetString.profileBG)
              )
            )
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.circlePlus),
            title: const Text('Add account'),
            onTap: () => context.flow<HomeRouterStatus>().update((state) => HomeRouterStatus.addAccount),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => context.flow<HomeRouterStatus>().update((state) => HomeRouterStatus.settings),
          ),
          const Divider(),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () {
              context.flow<HomeRouterStatus>().complete();
              context.read<AppBloc>().add(AppLogoutRequested());
            }
          )
        ]
      )
    );
  }
}