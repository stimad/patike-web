import 'package:snickers/dtos/snickers.dart';

class SearchSnickersDTO {
  final String? model;
  final String? color;
  final int? size;
  final bool? available;

  SearchSnickersDTO(this.model, this.color, this.size, this.available);

  Map toJson() {
    return {
      "model": model,
      "color": color,
      "size": size,
      "available": available
    };
  }
}
