import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../repository/account_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';

class PrivacyUseCase implements BaseUseCase<String> {
  final AccountRepository repository;
  PrivacyUseCase({required this.repository});

  Future<ResponseModel> call() async {
    return BaseUseCaseCall.onGetData<String>(
      await repository.getPrivacy(),
      onConvert,
      tag: 'PrivacyUseCase',
    );
  }

  @override
  ResponseModel<String> onConvert(BaseModel baseModel) {
    try {
      print('Privacy Data: ${baseModel.data}');
      return ResponseModel(
        baseModel.status ?? true,
        baseModel.message,
        data: baseModel.data,
      );
    } catch (e) {
      return ResponseModel(
        baseModel.status ?? false,
        baseModel.message,
        data: baseModel.item,
      );
    }
  }
}
