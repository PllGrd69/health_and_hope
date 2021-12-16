import 'dart:convert';

parseReponseBody(String reponseBody) {
  try{
    return jsonDecode(reponseBody);
  }catch (_){
    return reponseBody;
  }
}