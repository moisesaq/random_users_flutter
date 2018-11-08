import 'package:flutter/material.dart';
import 'package:random_users_flutter/model/Item.dart';
import 'package:random_users_flutter/ui/custom_views/item_selection/items_base_widget.dart';

class ItemsPageWidget extends ItemsBaseWidget {

  ItemsPageWidget(List<Item> list, didItemSelected) : super(list, didItemSelected);

  final _pageController = PageController(viewportFraction: 0.7);
  PageController get pageController => _pageController;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox.fromSize(
            size: Size.fromHeight(550.0),
            child: PageView.builder(
                controller: _pageController,
                itemCount: numberOfItems(),
                itemBuilder: (BuildContext context, int index) => createCardViewForPageView(index))));
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
                  imageRounded(item),
                  createDecorateBox(),
                  Container(alignment: AlignmentDirectional.bottomCenter,
                      child: createTitle(item, fontSize: 35.0, color: Colors.white))
                ])
        ));
  }
  
  Widget imageRounded(Item item) {
    return ClipRRect(borderRadius: BorderRadius.circular(8.0),
        child: Image.network(item.image, fit: BoxFit.cover));
  }

  Widget createDecorateBox() {
    return DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            gradient: LinearGradient(
                begin: FractionalOffset.bottomCenter,
                end: FractionalOffset.topCenter,
                colors: [
                  Color(0xff000000).withOpacity(0.9),
                  Color(0x00000000).withOpacity(0.01) ]))
    );
  }
}