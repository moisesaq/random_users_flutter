import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:random_users_flutter/model/Item.dart';

class ItemSelection extends StatefulWidget {

  ItemSelection({@required this.modeListenable, this.streamItems, this.didItemSelected});

  final ValueListenable<int> modeListenable;
  final StreamController<List<Item>> streamItems;
  final List<Item> list = [];
  final DidItemSelected didItemSelected;

  @override
  ItemSelectionState createState() => ItemSelectionState();
}

class ItemSelectionState extends State<ItemSelection> {

  @override
  void initState() {
    super.initState();
    widget.streamItems.stream.listen((items) => setState(() => widget.list.addAll(items)));
  }

  @override
  Widget build(BuildContext context) {
    return getList();
  }

  Widget getList() {
    return ValueListenableBuilder<int>(valueListenable: widget.modeListenable, builder: (context, value, child) {
      switch (value) {
        case 0:
          return createMessageView("Loading...");
        case 1:
          return createListView();
        case 2:
          return createPageView();
        default:
          return createMessageView("Error :(");
      }
    });
  }
  
  Widget createMessageView(String message) {
    return Center(child: Text(message));
  }

  Widget createListView() {
    return ListView.builder(
        itemCount: numberOfItems(),
        itemBuilder: (BuildContext context, int index) {
          return userCardView(index);
        });
  }

  Widget createPageView() {
    return PageView.builder(
        itemCount: numberOfItems(),
        itemBuilder: (BuildContext context, int index) {
          Item item = getItem(index);
          return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    createAvatar(item),
                    createTitle(item)
                  ]));
        });
  }

  int numberOfItems() {
    return widget.list != null ? widget.list.length : 0;
  }

  Widget userCardView(int index) {
    Item item = getItem(index);
    return Card(
        child: ListTile(
            contentPadding: const EdgeInsets.all(10.0),
            leading: createAvatar(item),
            title: createTitle(item),
            subtitle: Text(item.subtitle),
            onTap: () {
              widget.didItemSelected(item);
            }),
    );
  }

  Item getItem(int index) {
    return widget.list[index];
  }

  Widget createAvatar(Item item) {
    return CircleAvatar(backgroundImage: NetworkImage(item.image));
  }

  Widget createTitle(Item item) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(item.title, style: TextStyle(fontSize: 17.0)));
  }
}

typedef DidItemSelected = Function(Item);