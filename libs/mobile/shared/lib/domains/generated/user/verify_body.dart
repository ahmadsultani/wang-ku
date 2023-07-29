import 'package:shared/shared.dart';

part 'verify_body.freezed.dart';
part 'verify_body.g.dart';

@freezed
class VerifyBody with _$VerifyBody {
  const factory VerifyBody({
    required String birthPlace,
    required String nik,
    String? picture,
  }) = _VerifyBody;

  factory VerifyBody.fromJson(Map<String, dynamic> json) =>
      _$VerifyBodyFromJson(json);
}
