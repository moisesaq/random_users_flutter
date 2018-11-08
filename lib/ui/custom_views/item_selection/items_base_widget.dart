import 'package:flutter/material.dart';
import 'package:random_users_flutter/model/Item.dart';
import 'package:random_users_flutter/ui/custom_views/item_selection/item_selection.dart';

abstract class ItemsBaseWidget extends StatelessWidget {

  ItemsBaseWidget(this.list, this.didItemSelected);

  final List<Item> list;
  final DidItemSelected didItemSelected;

  int numberOfItems() {
    return list != null ? list.length : 0;
  }

  Item getItem(int index) {
    return list[index];
  }

  Widget createTitle(Item item, {double fontSize: 17.0, Color color: Colors.black}) {
    return Padding(padding: const EdgeInsets.all(8.0),
        child: Text(item.title, style: TextStyle(fontSize: fontSize, color: color)));
  }
}