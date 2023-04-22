import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../besniees_logic/bloc/internet_bloc.dart';
import '../../besniees_logic/cubit/items_cubit.dart';
import '../../core/colors.dart';

class CheckInternetWidget extends StatelessWidget {
  const CheckInternetWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetBloc, InternetState>(
      builder: (context, state) {
        if (state is NotConnectState) {
          return Positioned(
            top: 0,
            left: 10,
            right: 10,
            child: Card(
              color: AppColors.myRed,
              child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(state.message,
                        style: const TextStyle(color: AppColors.myWhite)),
                  )),
            ),
          );
        } else {
          if (
          BlocProvider.of<ItemsCubit>(context).items.isEmpty) {
            BlocProvider.of<ItemsCubit>(context).getMoreItemsList();
          }
          return const SizedBox();
        }
      },
    );
  }
}