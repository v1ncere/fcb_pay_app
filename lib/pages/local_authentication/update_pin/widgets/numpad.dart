import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widgets/widgets.dart';
import '../../local_authentication.dart';

class NumPad extends StatelessWidget {
  const NumPad({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 0, 50, 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Row(
              children: [
                Expanded(
                  child: ButtonNumPad(
                    num: '1',
                    onPressed: () => BlocProvider.of<UpdatePinBloc>(context).add(const UpdatePinAdded(1))
                  )
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: ButtonNumPad(
                    num: '2',
                    onPressed: () => BlocProvider.of<UpdatePinBloc>(context).add(const UpdatePinAdded(2))
                  )
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: ButtonNumPad(
                    num: '3',
                    onPressed: () => BlocProvider.of<UpdatePinBloc>(context).add(const UpdatePinAdded(3))
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
                    num: '4',
                    onPressed: () => BlocProvider.of<UpdatePinBloc>(context).add(const UpdatePinAdded(4))
                  )
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: ButtonNumPad(
                    num: '5',
                    onPressed: () => BlocProvider.of<UpdatePinBloc>(context).add(const UpdatePinAdded(5))
                  )
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: ButtonNumPad(
                    num: '6',
                    onPressed: () => BlocProvider.of<UpdatePinBloc>(context).add(const UpdatePinAdded(6))
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
                    num: '7',
                    onPressed: () => BlocProvider.of<UpdatePinBloc>(context).add(const UpdatePinAdded(7))
                  )
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: ButtonNumPad(
                    num: '8',
                    onPressed: () => BlocProvider.of<UpdatePinBloc>(context).add(const UpdatePinAdded(8))
                  )
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: ButtonNumPad(
                    num: '9',
                    onPressed: () => BlocProvider.of<UpdatePinBloc>(context).add(const UpdatePinAdded(9))
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
                const SizedBox(width: 30),
                Expanded(
                  child: ButtonNumPad(
                    num: '0',
                    onPressed: () => BlocProvider.of<UpdatePinBloc>(context).add(const UpdatePinAdded(0))
                  )
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: IconButton(
                    icon: const Icon(Icons.backspace),
                    onPressed: () => BlocProvider.of<UpdatePinBloc>(context).add(UpdatePinErased())
                  )
                )
              ]
            )
          )
        ]
      )
    );
  }
}