import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:clubeathleticoparanaense/common/clazz/jogador.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class JogadorApi {
  static Future<List<Jogador>> getJogadores() async {

    var connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult);

    if (connectivityResult == ConnectivityResult.none) {
      throw SocketException("Internet indisponível.");
    }

    var apiResponse = await ParseObject('Jogador').getAll();

    print("> apiResponse: $apiResponse");

    if (apiResponse.success){
      print("> ${apiResponse.result}");
      for (var testObject in apiResponse.result) {
        print("ParseObject" + ": " + testObject.toString());
      }
    }

    final mapJogadores = json.decode(apiResponse.result.toString()).cast<Map<String, dynamic>>();

    final jogadores =
        mapJogadores.map<Jogador>((json) => Jogador.fromJson(json)).toList();

    return jogadores;
  }

  static Future<List<Jogador>> getJogadoresPorPosicao(String posicao) async {

    var connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult);

    if (connectivityResult == ConnectivityResult.none) {
      throw SocketException("Internet indisponível.");
    }

    final QueryBuilder<ParseObject> queryBuilder =
    QueryBuilder<ParseObject>(ParseObject('Jogador'))
      ..whereEqualTo("posicao", posicao);

    final ParseResponse apiResponse = await queryBuilder.query();

    final mapJogadores = json.decode(apiResponse.result.toString()).cast<Map<String, dynamic>>();

    final jogadores =
    mapJogadores.map<Jogador>((json) => Jogador.fromJson(json)).toList();

    return jogadores;
  }
}
