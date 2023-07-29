import 'package:shared/shared.dart';


part 'sign_in_response.freezed.dart';
part 'sign_in_response.g.dart';

@freezed
class SignInResponse with _$SignInResponse {
    const factory SignInResponse({
    required SignInResponseData data,
    }) = _SignInResponse;

    factory SignInResponse.fromJson(Map<String, dynamic> json) => _$SignInResponseFromJson(json);
}

@freezed
class SignInResponseData with _$SignInResponseData {
    const factory SignInResponseData({
    required String token,
    required User user,
    }) = _SignInResponseData;

    factory SignInResponseData.fromJson(Map<String, dynamic> json) => _$SignInResponseDataFromJson(json);
}

@freezed
class User with _$User {
    const factory User({
    required String email,
    required String id,
    required String name,
    }) = _User;

    factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
