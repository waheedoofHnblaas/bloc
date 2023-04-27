import 'package:bloc_app/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../besniees_logic/bloc/internet_bloc/internet_bloc.dart';
import '../../besniees_logic/cubit/items/items_cubit.dart';

class CheckNetworkHandelWidget extends StatelessWidget {
  CheckNetworkHandelWidget({Key? key, required this.widget}) : super(key: key);

  Widget widget;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InternetBloc, InternetState>(
      listener: (context, state) {
        if (state is NotConnectState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.myRed,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Connection'),
              duration: Duration(seconds: 3),
              backgroundColor: Colors.green,
            ),
          );
          if (BlocProvider.of<ItemsCubit>(context).items.isEmpty) {
            BlocProvider.of<ItemsCubit>(context).getMoreItemsList();
          }
        }
      },
      builder: (context, state) {
        return Center(
          child: Stack(
            children: [widget],
          ),
        );
      },
    );
  }
}
