import 'package:shared/shared.dart';


part 'sign_up_body.freezed.dart';
part 'sign_up_body.g.dart';

@freezed
class SignUpBody with _$SignUpBody {
    const factory SignUpBody({
    required int birthDate,
    required String email,
    required String gender,
    required String name,
    required String password,
    required String phoneNumber,
    String? picture,
    }) = _SignUpBody;

    factory SignUpBody.fromJson(Map<String, dynamic> json) => _$SignUpBodyFromJson(json);
}
