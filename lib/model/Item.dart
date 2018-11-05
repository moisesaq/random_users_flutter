
class Item {
  int id;
  String image;
  String title;
  String subtitle;

  Item(this.id, this.image, this.title, { this.subtitle = "No subtitle" });
}