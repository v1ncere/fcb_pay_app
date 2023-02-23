import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:fcb_pay_app/repository/repository.dart';
import 'package:fcb_pay_app/pages/home_transaction_button_pages/home_transaction_button_pages.dart';

class DeleteAccountForm extends StatelessWidget {
  const DeleteAccountForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accounts", style: TextStyle(color: Colors.green)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<AccountsBloc, AccountsState>(
              builder: (context, state) {
                if (state is AccountsInitialState) {
                  return Container();
                }
                if (state is AccountsLoadedState) {
                  return _DisplayListView();
                }
                if (state is AccountsLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                else {
                  return Container();
                }
              },
            )
        ],)
      ),
    );
  }
}

class _DisplayListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Account>("ACCOUNT").listenable(),
      builder: (context, Box<Account> items, child) {
        // list of keys/id for hive data
        List<int> keys = items.keys.cast<int>().toList();
        // ============================================
        return ListView.separated(
          separatorBuilder: (context, index) => const Divider(indent: 5.0, endIndent: 5.0),
          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
          itemCount: keys.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            // getting the key/id using indices
            final int key = keys[index];
            // getting the data using key
            final Account? data = items.get(key);
            // ================================
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              color: Colors.green[200],
              child: ListTile(
                title: Text(
                  data!.account.toString(),
                  style: const TextStyle(fontSize: 22, color: Colors.black)
                ),
                subtitle: Text(
                  data.userID, 
                  style: const TextStyle(fontSize: 12, color:Colors.black38)
                ),
                leading: Text(
                  '$key',
                  style: const TextStyle( fontSize: 18, color: Colors.black)
                ),

                trailing: Text(data.balance.toString()),
                onTap: () {
                  showDialog(
                    builder: (_) => Dialog(
                      backgroundColor: Colors.white,
                        child: Container(
                          padding: const EdgeInsets.all(22.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.white)
                                ),
                                onPressed: () {
                                  BlocProvider.of<AccountsBloc>(context).add(DeleteAccountEvent(account: data));
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        )
                    ), context: context
                  );
                },
              ),
            ); 
          },
        );
      },
    );
  }
}