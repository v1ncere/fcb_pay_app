import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fcb_pay_app/global_widgets/global_widgets.dart';
import 'package:fcb_pay_app/pages/pin/pin.dart';

class CreateNumPad extends StatelessWidget {
  const CreateNumPad({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(64, 0, 64, 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Row(
              children: [
                Expanded(
                  child: ButtonNumPad(
                    num: "1",
                    onPressed: () => BlocProvider.of<CreatePinBloc>(context).add(const CreatePinAddEvent(1))
                  )
                ),
                const SizedBox(width: 40),
                Expanded(
                  child: ButtonNumPad(
                    num: "2",
                    onPressed: () => BlocProvider.of<CreatePinBloc>(context).add(const CreatePinAddEvent(2))
                  )
                ),
                const SizedBox(width: 40),
                Expanded(
                  child: ButtonNumPad(
                    num: "3",
                    onPressed: () => BlocProvider.of<CreatePinBloc>(context).add(const CreatePinAddEvent(3))
                  )
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Flexible(
            child: Row(
              children: [
                Expanded(
                  child: ButtonNumPad(
                    num: "4",
                    onPressed: () => BlocProvider.of<CreatePinBloc>(context).add(const CreatePinAddEvent(4))
                  )
                ),
                const SizedBox(width: 40),
                Expanded(
                  child: ButtonNumPad(
                    num: "5",
                    onPressed: () => BlocProvider.of<CreatePinBloc>(context).add(const CreatePinAddEvent(5))
                  )
                ),
                const SizedBox(width: 40),
                Expanded(
                  child: ButtonNumPad(
                    num: "6",
                    onPressed: () => BlocProvider.of<CreatePinBloc>(context).add(const CreatePinAddEvent(6))
                  )
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Flexible(
            child: Row(
              children: [
                Expanded(
                  child: ButtonNumPad(
                    num: "7",
                    onPressed: () => BlocProvider.of<CreatePinBloc>(context).add(const CreatePinAddEvent(7))
                  )
                ),
                const SizedBox(width: 40),
                Expanded(
                  child: ButtonNumPad(
                    num: "8",
                    onPressed: () => BlocProvider.of<CreatePinBloc>(context).add(const CreatePinAddEvent(8))
                  )
                ),
                const SizedBox(width: 40),
                Expanded(
                  child: ButtonNumPad(
                    num: "9",
                    onPressed: () => BlocProvider.of<CreatePinBloc>(context).add(const CreatePinAddEvent(9))
                  )
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Flexible(
            child: Row(
              children: [
                const Expanded(
                  child: SizedBox()),
                const SizedBox(width: 50),
                Expanded(
                  child: ButtonNumPad(
                    num: "0",
                    onPressed: () => BlocProvider.of<CreatePinBloc>(context).add(const CreatePinAddEvent(0))
                  )
                ),
                const SizedBox(width: 50),
                Expanded(
                  child: IconButton(
                    icon: const Icon(Icons.backspace),
                    onPressed: () => BlocProvider.of<CreatePinBloc>(context).add(CreatePinEraseEvent())
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}