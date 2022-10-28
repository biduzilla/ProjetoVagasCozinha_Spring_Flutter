import 'package:vagas/model/CvModel.dart';

class MinhaVaga {
  int vagaId;
  String cargo;
  String descricao;
  String local;
  String horario;
  List<dynamic> requisitos;
  num remuneracao;
  String dataPostada;
  List<CvModel> curriculumDtos;

  MinhaVaga({
    required this.vagaId,
    required this.cargo,
    required this.descricao,
    required this.local,
    required this.horario,
    required this.requisitos,
    required this.remuneracao,
    required this.dataPostada,
    required this.curriculumDtos,
  });

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
      'curriculumDtos': curriculumDtos,
    };
  }

  factory MinhaVaga.fromJson(dynamic json) {
    if (json['curriculumDtos'] != null) {
      var cvJson = json['curriculumDtos'] as List;
      List<CvModel> _cv =
          cvJson.map((tagJson) => CvModel.fromJson(tagJson)).toList();

      return MinhaVaga(
        vagaId: json['vagaId'],
        cargo: json['cargo'],
        descricao: json['descricao'],
        local: json['local'],
        horario: json['horario'],
        requisitos: json['requisitos'],
        remuneracao: json['remuneracao'],
        dataPostada: json['dataPostada'],
        curriculumDtos: _cv,
      );
    } else {
      return MinhaVaga(
        vagaId: json['vagaId'],
        cargo: json['cargo'],
        descricao: json['descricao'],
        local: json['local'],
        horario: json['horario'],
        requisitos: json['requisitos'],
        remuneracao: json['remuneracao'],
        dataPostada: json['dataPostada'],
        curriculumDtos: [],
      );
    }
  }
  // factory MinhaVaga.fromJson(Map<String, dynamic> json) {
  //   return MinhaVaga(
  //     vagaId: json['vagaId'],
  //     cargo: json['cargo'],
  //     descricao: json['descricao'],
  //     local: json['local'],
  //     horario: json['horario'],
  //     requisitos: json['requisitos'],
  //     remuneracao: json['remuneracao'],
  //     dataPostada: json['dataPostada'],
  //     curriculumDtos: json['curriculumDtos'],
  //   );
  // }
}
