import 'get_random_product_entity.dart';

class GetRandomProductsResponseEntity {
  final int pageIndex;
  final int pageSize;
  final int count;
  final List<GetRandomProductEntity> products;

  const GetRandomProductsResponseEntity({
    required this.pageIndex,
    required this.pageSize,
    required this.count,
    required this.products,
  });
}
