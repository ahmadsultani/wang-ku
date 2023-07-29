import 'package:shared/shared.dart';


part 'sign_up_response.freezed.dart';
part 'sign_up_response.g.dart';

@freezed
class SignUpResponse with _$SignUpResponse {
    const factory SignUpResponse({
    required SignUpResponseData data,
    }) = _SignUpResponse;

    factory SignUpResponse.fromJson(Map<String, dynamic> json) => _$SignUpResponseFromJson(json);
}

@freezed
class SignUpResponseData with _$SignUpResponseData {
    const factory SignUpResponseData({
    required String email,
    }) = _SignUpResponseData;

    factory SignUpResponseData.fromJson(Map<String, dynamic> json) => _$SignUpResponseDataFromJson(json);
}
