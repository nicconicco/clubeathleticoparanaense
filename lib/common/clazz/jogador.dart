class Posicao {
  static const String atacante = "Atacante";
  static const String goleiro = "Goleiro";
  static const String meio_centro = "Meio Centro";
  static const String ponta_direita = "Ponta Direita";
  static const String ponta_esquerda = "Ponta Esquerda";
  static const String defesa = "Defesa";
}

class Jogador {
  final int id;
  String nome;
  String posicao;
  String urlFoto;
  String descricao;

  Jogador({this.id, this.nome, this.urlFoto, this.posicao, this.descricao});

  factory Jogador.fromJson(Map<String, dynamic> parsedJson) {
    return Jogador(
      id: parsedJson['id'] as int,
      nome: parsedJson['nome'] as String,
      posicao: parsedJson['posicao'] as String,
      urlFoto: parsedJson['urlFoto'] as String,
      descricao: parsedJson['descricao'] as String,
    );
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "nome": nome,
      "posicao": posicao,
      "urlFoto": urlFoto,
      "descricao": descricao,
    };

    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Jogador[$id]: $nome";
  }
}
