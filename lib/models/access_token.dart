import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'access_token.g.dart';

abstract class AccessToken implements Built<AccessToken, AccessTokenBuilder> {
  factory AccessToken(
      [AccessTokenBuilder updates(AccessTokenBuilder builder)]) = _$AccessToken;

  AccessToken._();


  @BuiltValueField(wireName: 'access_token')
  String? get accessToken;


  @BuiltValueField(wireName: 'refresh_token')
  String? get refreshToken;


  @BuiltValueField(wireName: 'expires_in')
  int? get expiresIn;

  static Serializer<AccessToken> get serializer => _$accessTokenSerializer;
}
