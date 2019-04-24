import 'dart:io';

import 'package:clubeathleticoparanaense/common/clazz/jogador.dart';
import 'package:clubeathleticoparanaense/features/home/repository/api/JogadorDB.dart';
import 'package:clubeathleticoparanaense/features/home/repository/api/jogador_api.dart';

class HomeRepository {
  Future<bool> exist(Jogador jogador) async {
    return JogadorDB.getInstance().exists(jogador);
  }

  Future<List<Jogador>> getJogadoresPorPosicao(String posicao) async {
    return JogadorApi.getJogadoresPorPosicao(posicao);
  }

  Future<List<Jogador>> getJogadores() async {
    return JogadorApi.getJogadores();
  }

  Future getJogadoresFavoritos() {
    return JogadorDB.getInstance().getJogadores();
  }

  static salvar(c, File fileCamera) {

  }
}
