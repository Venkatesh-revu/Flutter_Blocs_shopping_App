class ProductModel {
  int? id;
  String? title;
  String? price;
  String? description;
  String? category;
  String? image;
  String? rate;
  int? count;

  ProductModel(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.image,
      this.rate,
      this.count});
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'].toString();
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rate = json['rating']['rate'].toString();
    count = json['rating']['count'];
  }
}
