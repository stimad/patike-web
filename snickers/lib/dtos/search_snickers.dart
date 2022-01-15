class SearchSnickersDTO {
  final String? model;
  final String? color;
  final int? size;
  final bool? available;
  final DateTime? fromDate;
  final DateTime? toDate;

  SearchSnickersDTO(this.model, this.color, this.size, this.available,
      {this.fromDate, this.toDate});

  Map toJson() {
    return {
      "model": model,
      "color": color,
      "size": size,
      "available": available
    };
  }
}
