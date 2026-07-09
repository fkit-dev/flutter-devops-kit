class HeaderKey {
  const HeaderKey._();

  static const Map<String, dynamic> defaultHeaders = {
    accept: 'application/json',
    contentType: 'application/json',
  };

  static const String accept = 'accept';
  static const String contentType = 'content-type';
  static const String authorization = 'authorization';
  static const String refreshToken = 'refresh-token';
  static const String integrityToken = 'X-Integrity-Token';
  static const String appSecret = 'X-App-Secret';
}