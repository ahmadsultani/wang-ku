import 'package:shared/shared.dart';

part 'create_response.freezed.dart';
part 'create_response.g.dart';

@freezed
class CreateResponse with _$CreateResponse {
  const factory CreateResponse({
    required CreateResponseData data,
  }) = _CreateResponse;

  factory CreateResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateResponseFromJson(json);
}

@freezed
class CreateResponseData with _$CreateResponseData {
  const factory CreateResponseData({
    required String address,
    required String category,
    required int createdAt,
    required String id,
    double? lendLimit,
    double? monthlyIncome,
    double? monthlySpending,
    required String name,
    required String nib,
    required String npwp,
    String? phoneNumber,
    required int updatedAt,
    required String userEmail,
    required String userId,
    required String userName,
    required String userPhoneNumber,
  }) = _CreateResponseData;

  factory CreateResponseData.fromJson(Map<String, dynamic> json) =>
      _$CreateResponseDataFromJson(json);
}
