import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NlpProvider{
  String _API_KEY = 'AIzaSyDHc53FyhBfg_9j_Trz1lnCXflNLAsSE0c';
  String _url = 'https://language.googleapis.com/v1beta2/documents:analyzeEntities?key=';
  String val = '';

  Future<String> getRpta(String val) async{
    final url = _url+_API_KEY;

    final resp = await http.post(url,
    body: jsonEncode(<String, dynamic>{
      "document":{ 
        "type"    :  "PLAIN_TEXT",
        "language": "es",
        "content" : val
      },
      "encodingType": "UTF8"
    })
    );
    print(resp.body);
    return resp.body;
  }

}