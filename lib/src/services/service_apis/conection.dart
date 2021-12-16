import 'package:health_and_hope/src/share_prefs/preferencias_usuario.dart';

class ApiConnection {

  static String getUrlApi(){
    // return "192.168.2.20:8080";
    return "healthandhope.tk";
  }

  // final String _apiKey = "cd";
  static String getApiKey(){
    // return "Gur18FeD.sJNc4OyAGNty2ASwgVImdpPzGqF8BOwS";
    return "OyOeCHBD.cOZLJJfTHPEmYXiVyzYgrT5SaOmTXGYu";
  } 

  static Future<Map<String, String>> getHeaderApiKeyTokenUser() async {
    return {
      "Content-Type": "application/json",
      "charset": "UTF-8",
      'X-Api-Key': ApiConnection.getApiKey(),
      "Authorization": "Bearer ${await PreferencesUserApp().getAccessToken()}",
    };
  }

  static Future<Map<String, String>> getHeaderApiKey() async {
    return {
      "Content-Type": "application/json",
      "charset": "UTF-8",
      'X-Api-Key': ApiConnection.getApiKey(),
    };
  }

}