import 'package:shared/shared.dart';


part 'create_body.freezed.dart';
part 'create_body.g.dart';

@freezed
class CreateBody with _$CreateBody {
    const factory CreateBody({
    required String address,
    required String category,
    double? lendLimit,
    double? monthlyIncome,
    double? monthlySpending,
    required String name,
    required String nib,
    required String npwp,
    String? phoneNumber,
    }) = _CreateBody;

    factory CreateBody.fromJson(Map<String, dynamic> json) => _$CreateBodyFromJson(json);
}
