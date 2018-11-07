import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:random_users_flutter/model/Item.dart';
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
    return ValueListenableBuilder<StatusItemSelection>(
        valueListenable: widget.statusListenable,
        builder: (context, status, child) {
          switch (status) {
            case StatusItemSelection.LOADING:
              return createMessageView("Loading...");
            case StatusItemSelection.LIST:
              return createListView();
            case StatusItemSelection.PAGE:
              return createPageView();
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

  Widget createListView() {
    return ListView.builder(
        itemCount: numberOfItems(),
        itemBuilder: (BuildContext context, int index) {
          return createCardViewForListView(index);
        });
  }

  Widget createCardViewForListView(int index) {
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

  Widget createPageView() {
    return Center(
        child: SizedBox.fromSize(
          size: Size.fromHeight(550.0),
          child: PageView.builder(
              controller: PageController(viewportFraction: 0.7),
              itemCount: numberOfItems(),
              itemBuilder: (BuildContext context, int index) {
                return createCardViewForPageView(index);
              }))
    );
  }

  Widget createCardViewForPageView(int index) {
    Item item = getItem(index);
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(8.0),
            child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  ClipRRect(borderRadius: BorderRadius.circular(8.0), child: Image.network(item.image, fit: BoxFit.cover)),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                        gradient: LinearGradient(
                            begin: FractionalOffset.bottomCenter,
                            end: FractionalOffset.topCenter,
                            colors: [Colors.black.withOpacity(0.9), Colors.white.withOpacity(0.01)]))
                  ),
                  Container(alignment: AlignmentDirectional.bottomCenter, child: createTitle(item, fontSize: 35.0, color: Colors.white))
            ])
        ));
  }

  Widget contentPage(Item item) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          createAvatar(item, radius: 100.0),
          createTitle(item, fontSize: 35.0)
        ]);
  }

  int numberOfItems() {
    return widget.list != null ? widget.list.length : 0;
  }

  Item getItem(int index) {
    return widget.list[index];
  }

  Widget createAvatar(Item item, {double radius: 35.0}) {
    return CircleAvatar(backgroundImage: NetworkImage(item.image), radius: radius);
  }

  Widget createTitle(Item item, {double fontSize: 17.0, Color color: Colors.black}) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(item.title, style: TextStyle(fontSize: fontSize, color: color)));
  }
}

typedef DidItemSelected = Function(Item);