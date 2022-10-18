class CvModel {
  CvModel({
    required this.nome,
    required this.emailContatoCV,
    required this.telefone,
    required this.sobre,
    required this.semestre,
    required this.experiencias,
    required this.qualificacoes,
  });

  String nome;
  String emailContatoCV;
  String telefone;
  String sobre;
  String semestre;
  List<dynamic> experiencias;
  List<dynamic> qualificacoes;

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'emailContatoCV': emailContatoCV,
      'telefone': telefone,
      'sobre': sobre,
      'semestre': semestre,
      'experiencias': experiencias,
      'qualificacoes': qualificacoes,
    };
  }

  factory CvModel.fromJson(Map<String, dynamic> json) {
    return CvModel(
      nome: json['nome'],
      emailContatoCV: json['emailContatoCV'],
      telefone: json['telefone'],
      sobre: json['sobre'],
      semestre: json['semestre'],
      experiencias: json['experiencias'],
      qualificacoes: json['qualificacoes'],
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Cv{nome: $nome\nemail: $emailContatoCV\ntelefone: $telefone\nsemestre: $semestre\nexperiencias: $experiencias\nqualificacoes: $qualificacoes}';
  }
}
