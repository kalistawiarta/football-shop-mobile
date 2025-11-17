class ProductEntry {
  String id;
  String name;
  String description;
  int price;
  int stock;
  String category;
  String thumbnail;
  bool bestSeller;
  int? userId;

  ProductEntry({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.category,
    required this.thumbnail,
    required this.bestSeller,
    required this.userId,
  });

  factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
        id: json["id"].toString(),
        name: json["name"] ?? "",
        description: json["description"] ?? "",
        price: (json["price"] is int)
            ? json["price"]
            : (json["price"] is double)
                ? (json["price"] as double).toInt()
                : int.tryParse(json["price"].toString()) ?? 0,
        stock: json["stock"] ?? 0,
        category: json["category"] ?? "",
        thumbnail: json["thumbnail"] ?? "",
        bestSeller: json["best_seller"] ?? false,
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "stock": stock,
        "category": category,
        "thumbnail": thumbnail,
        "best_seller": bestSeller,
        "user_id": userId,
      };
}
