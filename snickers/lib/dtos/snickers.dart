class Snickers {
  int id;
  String? model;
  String? color;
  int? size;
  int? count;
  double? price;
  String? image;

  Snickers(this.id, this.model, this.color, this.size, this.count, this.price);

  Map toJson() {
    return {
      "id": id,
      "model": model,
      "color": color,
      "size": size,
      "count": count
    };
  }
}
