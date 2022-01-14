class APIResponse {
  int status;
  dynamic results;

  APIResponse(this.status, this.results);

  factory APIResponse.fromJson(Map<dynamic, dynamic> parsedJson) {
    return APIResponse(parsedJson['status'], parsedJson['results']);
  }
}
