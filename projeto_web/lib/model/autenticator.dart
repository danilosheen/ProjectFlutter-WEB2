class Autenticator {
  String? token;

  static final Autenticator _Autenticator = Autenticator._internal();

  factory Autenticator() {
    return _Autenticator;
  }

  Autenticator._internal();
}
