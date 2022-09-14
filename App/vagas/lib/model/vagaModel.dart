class Vaga {
  Vaga({
    required this.vagaId,
    required this.cargo,
    required this.descricao,
    required this.local,
    required this.horario,
    required this.requisitos,
    required this.remuneracao,
    required this.dataPostada,
  });
  int vagaId;
  String cargo;
  String descricao;
  String local;
  String horario;
  List<dynamic> requisitos;
  num remuneracao;
  String dataPostada;

  Map<String, dynamic> toJson() {
    return {
      'vagaId': vagaId,
      'cargo': cargo,
      'descricao': descricao,
      'local': local,
      'horario': horario,
      'requisitos': requisitos,
      'remuneracao': remuneracao,
      'dataPostada': dataPostada,
    };
  }

  factory Vaga.fromJson(Map<String, dynamic> json) {
    return Vaga(
      vagaId: json['vagaId'],
      cargo: json['cargo'],
      descricao: json['descricao'],
      local: json['local'],
      horario: json['horario'],
      requisitos: json['requisitos'],
      remuneracao: json['remuneracao'],
      dataPostada: json['dataPostada'],
    );
  }
}
