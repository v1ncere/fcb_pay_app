import 'package:fcb_pay_app/pages/dynamic_viewer.dart/dynamic_viewer.dart';
import 'package:fcb_pay_app/utils/utils.dart';
import 'package:fcb_pay_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DynamicViewerView extends StatelessWidget {
  const DynamicViewerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WidgetsBloc, WidgetsState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } 
        if (state.status.isSuccess) {
          return const CustomCardContainer(
            color: Color(0xFFFFFFFF),
            children: [

            ],
          );
        }
        if (state.status.isError) {
          return Center(
            child: Text('${state.errorMsg}'),
          );
        }
        else {
          return const SizedBox.shrink();
        }
      }
    );
  }
}
