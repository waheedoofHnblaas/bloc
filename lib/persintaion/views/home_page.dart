import 'package:bloc_app/besniees_logic/cubit/items_cubit.dart';
import 'package:bloc_app/core/colors.dart';
import 'package:bloc_app/persintaion/widgets/item_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
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
      controller: _searchTextEditController,
      autofocus: true,
      onChanged: (chars) {
        addItemsToSearchList(chars);
      },
    );
  }

  buildAppBarTitle() {
    return const Text('BLoC');
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
        // IconButton(
        //   onPressed: () {
        //     context.read<ThemeCubit>().changeTheme();
        //   },
        //   icon: const Icon(Icons.sunny_snowing),
        // ),
        IconButton(
          onPressed: startSearch,
          icon: const Icon(Icons.search),
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
        } else {
          return loadingWidget();
        }
      },
    );
  }

  Widget listWidget() {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          gridBuilder(),
          isSearching
              ? const Text('No Data Yet')
              : const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                )
        ],
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
        if (index <= allItems.length - 1) {
          return ItemCardWidget(
            itemModel: isSearching ? searchedItems[index] : allItems[index],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget loadingWidget() {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.myRed),
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
          child: const Icon(Icons.luggage),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingWidgets(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: isSearching
            ? IconButton(
                onPressed: () {
                  stopSearch();
                },
                icon: const Icon(Icons.arrow_back_ios))
            : Container(),
        title: isSearching ? buildSearchTextField() : buildAppBarTitle(),
        actions: buildAppBarActions(),
      ),
      body: Center(
        child: Stack(
          children: [
            buildItemsList(),
            const CheckInternetWidget()
          ],
        ),
      ),
    );
  }
}

