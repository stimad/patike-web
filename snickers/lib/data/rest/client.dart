import 'dart:convert';

import 'package:http/http.dart' as http;

const _CURRENT_SCHEMA = "https";
const _hostname = "guarded-fjord-66327.herokuapp.com";

Future<Map<dynamic, dynamic>> executeGET(String relativePath) async {
  var response =
      await http.get(createUri(relativePath), headers: _createHeader());
  return jsonDecode(utf8.decode(response.bodyBytes)) as Map;
}

Future<Map<dynamic, dynamic>> executeGETQueryParam(
    String relativePath, Map<String, String> params) async {
  var response = await http.get(createQueryUri(relativePath, params),
      headers: _createHeader());
  return jsonDecode(utf8.decode(response.bodyBytes)) as Map;
}

Future<Map<dynamic, dynamic>> executePOST(String relativePath,
    {Object? body}) async {
  print(body);
  var response = await http.post(createUri(relativePath),
      headers: {"content-type": "application/json"}, body: jsonEncode(body));
  return jsonDecode(utf8.decode(response.bodyBytes)) as Map;
}

Future<Map<dynamic, dynamic>> executeDELETE(String relativePath,
    {Object? body}) async {
  var response = await http.delete(createUri(relativePath),
      headers: {"content-type": "application/json"}, body: jsonEncode(body));
  return jsonDecode(utf8.decode(response.bodyBytes)) as Map;
}

Future<Map<dynamic, dynamic>> executePUT(String relativePath,
    {Object? body}) async {
  var response = await http.put(createUri(relativePath),
      headers: {"content-type": "application/json"}, body: jsonEncode(body));
  return jsonDecode(utf8.decode(response.bodyBytes)) as Map;
}

Uri createUri(String relativePath) => _CURRENT_SCHEMA == "https"
    ? Uri.https(_hostname, relativePath)
    : Uri.http(_hostname, relativePath);

Uri createQueryUri(String relativePath, Map<String, dynamic> params) =>
    _CURRENT_SCHEMA == "https"
        ? Uri.https(_hostname, relativePath, params)
        : Uri.http(_hostname, relativePath, params);

Map<String, String> _createHeader() {
  return {"Access-Control-Allow-Origin": "*", "Accept": "application/json"};
}
