import 'package:bloc_app/besniees_logic/cubit/card/card_cubit.dart';
import 'package:bloc_app/besniees_logic/cubit/items/items_cubit.dart';
import 'package:bloc_app/core/colors.dart';
import 'package:bloc_app/persintaion/widgets/item_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../besniees_logic/bloc/internet_bloc/internet_bloc.dart';
import '../../core/routs.dart';
import '../../data/model/ItemModel.dart';
import '../widgets/checkInternet.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<ItemModel> allItems;
  List<ItemModel> searchedItems = [];
  bool isSearching = false;
  final TextEditingController _searchTextEditController =
      TextEditingController();

  Widget buildSearchTextField() {
    return TextFormField(
      style: TextStyle(color: AppColors.myTextColor),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
      controller: _searchTextEditController,
      autofocus: true,
      onChanged: (chars) {
        addItemsToSearchList(chars);
      },
    );
  }

  buildAppBarTitle() {
    return const Text('BLoc Images');
  }

  void addItemsToSearchList(String chars) {
    searchedItems = allItems
        .where((element) => element.user.username!
            .toLowerCase()
            .startsWith(_searchTextEditController.text))
        .toList();
    print(_searchTextEditController.text);
    setState(() {});
  }

  List<Widget> buildAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
          onPressed: () {
            stopSearch();
          },
          icon: const Icon(Icons.clear),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: startSearch,
          icon: const Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppPages.settingsScreen);
          },
          icon: const Icon(Icons.settings),
        ),
      ];
    }
  }

  void startSearch() {
    setState(() {
      isSearching = true;
    });
    ModalRoute.of(context)!.addLocalHistoryEntry(
      LocalHistoryEntry(onRemove: stopSearch),
    );
  }

  void stopSearch() {
    if (_searchTextEditController.text == '') {
      isSearching = false;
      setState(() {});
      ModalRoute.of(context)!.willPop();
    } else {
      clearSearch();
      setState(() {});
    }
  }

  void clearSearch() {
    _searchTextEditController.text = '';
  }

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    await BlocProvider.of<ItemsCubit>(context).getItemsList();
    scrollController.addListener(() async {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        print('===getMoreItemsList==${scrollController.offset.toString()}=');
        await BlocProvider.of<ItemsCubit>(context).getMoreItemsList();
      }
    });
  }

  Widget buildItemsList() {
    return BlocBuilder<ItemsCubit, ItemsState>(
      builder: (context, state) {
        if (state is ItemsLoadedState) {
          allItems = (state).items;
          return listWidget();
        } else if (state is ItemsLoadingState) {
          return loadingWidget();
        } else if (state is ErrorState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                state.message,
                style: const TextStyle(
                  color: AppColors.myRed,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.myRed),
                ),
                onPressed: () async {
                  await BlocProvider.of<ItemsCubit>(context).getItemsList();
                },
                child: const Text('Try Again'),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget listWidget() {
    return RefreshIndicator(
      color: AppColors.myRed,
      backgroundColor: AppColors.myWhite,
      onRefresh: () async {
        await BlocProvider.of<ItemsCubit>(context).getItemsList();
      },
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            gridBuilder(),
            allItems.isNotEmpty && !isSearching
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget gridBuilder() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: Get.height / 2.5,
        childAspectRatio: Get.width / (Get.height / 4),
      ),
      shrinkWrap: true,
      itemCount: isSearching ? searchedItems.length : allItems.length,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return ItemCardWidget(
          itemModel: isSearching ? searchedItems[index] : allItems[index],
        );
        if (index <= allItems.length - 1) {}
      },
    );
  }

  Widget loadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  floatingWidgets() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: 'c',
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppPages.cardScreen,
            );
          },
          child: Column(
            children: [
              const Icon(Icons.luggage),
              BlocBuilder<CardCubit, CardState>(
                builder: (context, state) {
                  if (state is AppCardState) {
                    return Text(state.items.length.toString());
                  } else {
                    return Text('0');
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  leading() {
    return isSearching
        ? IconButton(
            onPressed: () {
              stopSearch();
            },
            icon: const Icon(Icons.arrow_back_ios))
        : Container();
  }

  title() {
    return isSearching ? buildSearchTextField() : buildAppBarTitle();
  }

  appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: leading(),
      title: title(),
      actions: buildAppBarActions(),
    );
  }

  Future<bool> alterExitApp() {
    if (Get.isSnackbarOpen) {
      return Future.value(true);
    } else {
      Get.showSnackbar(
        GetSnackBar(
          message: 'Exit ? click again',
          duration: const Duration(seconds: 2),
          onTap: (snack) {
            print(snack.snackbarStatus);
          },
        ),
      );
      return Future.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingWidgets(),
      appBar: appBar(),
      body: WillPopScope(
        onWillPop: alterExitApp,
        child: CheckNetworkHandelWidget(
          widget: buildItemsList(),
        ),
      ),
    );
  }
}
