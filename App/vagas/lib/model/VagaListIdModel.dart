class VagaListIdModel {
  VagaListIdModel({
    required this.vagaId,
  });

  List<dynamic> vagaId;

  Map<String, dynamic> toJson() {
    return {
      'vagaId': vagaId,
    };
  }

  factory VagaListIdModel.fromJson(Map<String, dynamic> json) {
    return VagaListIdModel(
      vagaId: json['vagaId'],
    );
  }
}
