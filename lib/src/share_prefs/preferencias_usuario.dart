import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PreferencesUserApp {
  String _refreshToken='refreshToken';
  String _accessToken="accessToken";
  static final PreferencesUserApp _instancia = PreferencesUserApp._();
  PreferencesUserApp._();

  factory PreferencesUserApp(){
    return _instancia;
  }

  FlutterSecureStorage? _prefs;

  initPrefs() {
    _prefs = FlutterSecureStorage();
  }

  Future<String> getAccessToken() async {
    if (_prefs!=null){
      return await _prefs!.read(key: _accessToken)??'';
    } else {
      return '';
    }
  }

  Future<void> setAccessToken(String token) async {
    if (_prefs!=null){
      await _prefs!.write(key: _accessToken, value: token);
    }
  }

  Future<String> getRefreshToken() async {
    if (_prefs!=null){
      return await _prefs!.read(key: _refreshToken)??'';
    } else {
      return '';
    }
  }

  Future<void> setRefreshToken(String token) async {
    if (_prefs!=null){
      await _prefs!.write(key: _refreshToken, value: token);
    }
  }

}