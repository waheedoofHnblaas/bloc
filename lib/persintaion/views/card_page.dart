import 'package:bloc_app/besniees_logic/cubit/card/card_cubit.dart';
import 'package:bloc_app/core/colors.dart';
import 'package:bloc_app/data/model/ItemModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../besniees_logic/cubit/download/download_cubit.dart';

class CardPage extends StatelessWidget {
  const CardPage({Key? key}) : super(key: key);

  itemCard(context, Map<ItemModel, int> items, int index) {
    List<ItemModel> itemsModelsList = items.keys.toList();
    int count = items.values.toList()[index];

    return InkWell(
      onTap: () {
        BlocProvider.of<CardCubit>(context).removeItem(itemsModelsList[index]);
      },
      child: Container(
        color: AppColors.myTextColor,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 10,
            vertical: MediaQuery.of(context).size.width / 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  itemsModelsList[index].urls!.thumb.toString(),
                ),
                radius: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  itemsModelsList[index].user.name.toString(),
                ),
              ),
              Text(count.toString()),
            ],
          ),
        ),
      ),
    );
  }

  downloadItem(state,BuildContext context) async {
    Map mapItems = context.read<CardCubit>().items;
    try {
      ItemModel item = mapItems.keys.first;

      if (state is DownloadedState || state is DownloadInitial) {
        if (await context.read<DownloadCubit>().download(item)) {
          // context.read<CardCubit>().removeItem(item);

          BlocProvider.of<CardCubit>(context).removeItem(item);
          Get.snackbar(
            item.user.firstName.toString(),
            'success download',
          );
          if (mapItems.isNotEmpty) {
            downloadItem(state, context);
          }
        } else {
          Get.snackbar('error', 'cannot to download');
        }
      }
    }catch(e){
      Get.snackbar('error', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      floatingActionButton: BlocBuilder<DownloadCubit, DownloadState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () async {
              await downloadItem(state, context);
            },
            child: state is DownloadingState
                ? CircularProgressIndicator()
                : Icon(Icons.download),
          );
        },
      ),
      body: BlocBuilder<CardCubit, CardState>(
        builder: (context, state) {
          if (state is AppCardState) {
            if (state.items.isEmpty) {
              return Center(
                child: Text('No Item ...',
                    style: TextStyle(color: Theme.of(context).primaryColor)),
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
                          return Column(
                            children: [
                              itemCard(context, state.items, index),
                              const Divider(
                                thickness: 1,
                              )
                            ],
                          );
                        }),
                  ],
                ),
              );
            }
          } else {
            return Center(
              child: Text('No Item ...',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
            );
          }
        },
      ),
    );
  }
}
