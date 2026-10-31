import 'package:agentcollection_newbank/NEW_BANK/core/usecase.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/request/product.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/response/product.dart';
import 'package:agentcollection_newbank/NEW_BANK/data/repository/app_repository.dart';

class ProductUsecase
    extends UseCase<ProductResponseModel, ProductRequestModel> {
  final AppRepository appRepository;

  ProductUsecase(this.appRepository);

  @override
  Future<ProductResponseModel> call(ProductRequestModel params) {
    return appRepository.product(params);
  }
}
