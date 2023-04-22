import 'package:bloc_app/besniees_logic/cubit/card/card_cubit.dart';
import 'package:bloc_app/core/colors.dart';
import 'package:bloc_app/core/routs.dart';
import 'package:bloc_app/data/model/ItemModel.dart';
import 'package:bloc_app/persintaion/views/card_page.dart';
import 'package:bloc_app/persintaion/widgets/appcachiamge.dart';
import 'package:bloc_app/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ItemCardWidget extends StatelessWidget {
  const ItemCardWidget({Key? key, required this.itemModel}) : super(key: key);

  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.myWhite,
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
      margin: const EdgeInsets.all(1),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppPages.cardScreen,
              );
            },
            child: AppCachedImage(
              imageUrl: itemModel.urls?.thumb ?? '',
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.myRed,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: Get.width / 4,
                      child: Text(
                        itemModel.user.username ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.myWhite,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Get.width / 10,
                      height: Get.width / 10,
                      child: IconButton(
                        onPressed: () {
                          context.read<CardCubit>().addItem(itemModel);
                          Get.showSnackbar(const GetSnackBar(
                            snackPosition: SnackPosition.TOP,

                            backgroundColor: AppColors.myRed,
                            message: 'Add Item',
                            duration: Duration(seconds: 1),
                          ));
                        },
                        icon:
                            const Icon(Icons.add, color: AppColors.myTextColor),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
