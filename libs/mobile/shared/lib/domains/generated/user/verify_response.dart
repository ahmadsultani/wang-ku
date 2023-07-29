import 'package:shared/shared.dart';

part 'verify_response.freezed.dart';
part 'verify_response.g.dart';

@freezed
class VerifyResponse with _$VerifyResponse {
  const factory VerifyResponse({
    required VerifyResponseData data,
  }) = _VerifyResponse;

  factory VerifyResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyResponseFromJson(json);
}

@freezed
class VerifyResponseData with _$VerifyResponseData {
  const factory VerifyResponseData({
    required String birthPlace,
    required int createdAt,
    required String id,
    required String nik,
    String? picture,
    required int updatedAt,
    required String userId,
  }) = _VerifyResponseData;

  factory VerifyResponseData.fromJson(Map<String, dynamic> json) =>
      _$VerifyResponseDataFromJson(json);
}
