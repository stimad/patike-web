import 'package:intl/intl.dart';

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
    if (fromDate != null && toDate != null) {
      final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
      return {
        "model": model,
        "color": color,
        "size": size,
        "available": available,
        "fromDate": dateFormat.format(fromDate!),
        "toDate": dateFormat.format(toDate!)
      };
    }
    return {
      "model": model,
      "color": color,
      "size": size,
      "available": available
    };
  }
}
