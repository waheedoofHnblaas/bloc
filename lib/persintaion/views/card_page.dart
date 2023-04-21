import 'package:bloc_app/besniees_logic/cubit/card/card_cubit.dart';
import 'package:bloc_app/besniees_logic/cubit/card/card_cubit.dart';
import 'package:bloc_app/core/colors.dart';
import 'package:bloc_app/data/model/ItemModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardPage extends StatelessWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: BlocBuilder<CardCubit, CardState>(
        builder: (context, state) {
          if (state is AppCardState) {
            if (state.items.isEmpty) {
              return const Center(
                child: Text('Empty'),
              );
            } else {
              return SingleChildScrollView(
                primary: true,
                child: Column(
                  children: [
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        primary: true,
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: state.items.length,
                        itemBuilder: (context, index) {
                          List<ItemModel> itemsModel =
                              state.items.keys.toList();
                          int count = state.items.values.toList()[index];
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  BlocProvider.of<CardCubit>(context)
                                      .removeItem(itemsModel[index]);
                                },
                                child: Container(
                                  color: AppColors.myWhite,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width /
                                              10,
                                      vertical:
                                          MediaQuery.of(context).size.width /
                                              12,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: Text(itemsModel[index]
                                              .user
                                              .name
                                              .toString()),
                                        ),
                                        Text(count.toString()),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 0,
                              )
                            ],
                          );
                        }),
                  ],
                ),
              );
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
