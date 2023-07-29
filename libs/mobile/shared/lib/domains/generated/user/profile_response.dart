import 'package:shared/shared.dart';


part 'profile_response.freezed.dart';
part 'profile_response.g.dart';

@freezed
class ProfileResponse with _$ProfileResponse {
    const factory ProfileResponse({
    required ProfileResponseData data,
    }) = _ProfileResponse;

    factory ProfileResponse.fromJson(Map<String, dynamic> json) => _$ProfileResponseFromJson(json);
}

@freezed
class ProfileResponseData with _$ProfileResponseData {
    const factory ProfileResponseData({
    Business? business,
    required User user,
    }) = _ProfileResponseData;

    factory ProfileResponseData.fromJson(Map<String, dynamic> json) => _$ProfileResponseDataFromJson(json);
}

@freezed
class Business with _$Business {
    const factory Business({
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
    required String userId,
    }) = _Business;

    factory Business.fromJson(Map<String, dynamic> json) => _$BusinessFromJson(json);
}

@freezed
class User with _$User {
    const factory User({
    required int birthDate,
    required String email,
    required String id,
    required String name,
    required String phoneNumber,
    }) = _User;

    factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
