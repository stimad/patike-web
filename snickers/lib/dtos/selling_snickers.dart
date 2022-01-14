import 'package:snickers/dtos/snickers.dart';

class SellingSnickers extends Snickers {
  final int soldSnickersId;
  final int soldSnickersCount;
  SellingSnickers(int id, String? model, String? color, int? size, int? count,
      double price, this.soldSnickersId, this.soldSnickersCount)
      : super(id, model, color, size, count, price);
}
