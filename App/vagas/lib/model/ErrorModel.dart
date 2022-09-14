class ErrorModel {
  ErrorModel({
    required this.error,
  });

  List<dynamic> error;

  Map<String, dynamic> toJson() {
    return {
      'error': error,
    };
  }

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      error: json['error'],
    );
  }
}
