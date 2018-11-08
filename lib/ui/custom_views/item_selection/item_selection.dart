import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:random_users_flutter/model/Item.dart';
import 'package:random_users_flutter/ui/custom_views/item_selection/dots_indicator.dart';
import 'package:random_users_flutter/ui/custom_views/item_selection/items_list_widget.dart';
import 'package:random_users_flutter/ui/custom_views/item_selection/items_page_widget.dart';
import 'package:random_users_flutter/ui/utils/status_item_selection.dart';

class ItemSelection extends StatefulWidget {

  ItemSelection({@required this.statusListenable, this.streamItems, this.didItemSelected});

  final ValueListenable<StatusItemSelection> statusListenable;
  final StreamController<List<Item>> streamItems;
  final List<Item> list = [];
  final DidItemSelected didItemSelected;

  @override
  ItemSelectionState createState() => ItemSelectionState();
}

class ItemSelectionState extends State<ItemSelection> {
  static const _duration = const Duration(milliseconds: 300);
  static const _curve = Curves.ease;

  @override
  void initState() {
    super.initState();
    widget.streamItems.stream.listen((items) => setState(() => widget.list.addAll(items)));
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<StatusItemSelection>(
        valueListenable: widget.statusListenable,
        builder: (context, status, child) {
          switch (status) {
            case StatusItemSelection.LOADING:
              return createMessageView("Loading...");
            case StatusItemSelection.LIST:
              return ItemsListWidget(widget.list, widget.didItemSelected);
            case StatusItemSelection.PAGE:
              return pageViewWithIndicator();
            case StatusItemSelection.EMPTY:
              return createMessageView("Items not found");
            default:
              return createMessageView("Error :(");
          }
        });
  }
  
  Widget createMessageView(String message) {
    return Center(child: Text(message));
  }

  Widget pageViewWithIndicator() {
    var itemsPage = ItemsPageWidget(widget.list, widget.didItemSelected);
    return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          itemsPage,
          pageIndicator(itemsPage.pageController)
        ]);
  }

  Widget pageIndicator(PageController pageController) {
    return SizedBox(height: 80.0,
        child: DotsIndicator(
        controller: pageController,
        itemCount: widget.list.length,
        color: Colors.black87,
        onPageSelected: (int page) {
          pageController.animateToPage(page, duration: _duration, curve: _curve);
        }));
  }
}

typedef DidItemSelected = Function(Item);