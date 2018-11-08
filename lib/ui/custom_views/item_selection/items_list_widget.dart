import 'package:flutter/material.dart';
import 'package:random_users_flutter/model/Item.dart';
import 'package:random_users_flutter/ui/custom_views/item_selection/items_base_widget.dart';

class ItemsListWidget extends ItemsBaseWidget {

  ItemsListWidget(List<Item> list, didItemSelected) : super(list, didItemSelected);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: numberOfItems(),
        itemBuilder: (BuildContext context, int index) => createCardViewForListView(index));
  }

  Widget createCardViewForListView(int index) {
    Item item = getItem(index);
    return Card(
      child: ListTile(
          contentPadding: const EdgeInsets.all(10.0),
          leading: createAvatar(item),
          title: createTitle(item),
          subtitle: Text(item.subtitle),
          onTap: () => didItemSelected(item)),
    );
  }

  Widget createAvatar(Item item, {double radius: 35.0}) {
    return CircleAvatar(backgroundImage: NetworkImage(item.image), radius: radius);
  }
}