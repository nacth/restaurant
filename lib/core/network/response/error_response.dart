class ErrorResponse {
  int? statusCode;
  String? message;
  Map<String, dynamic>? errors;

  ErrorResponse({this.statusCode, this.message, this.errors, bool? success});

  ErrorResponse.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        statusCode = json['statusCode'],
        errors = json.containsKey('errors')
            ? (json['errors'] as Map<String, dynamic>?)
            : null;
}
