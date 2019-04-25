import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
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

    if (apiResponse.success) {
      print("> ${apiResponse.result}");
      for (var testObject in apiResponse.result) {
        print("ParseObject" + ": " + testObject.toString());
      }
    }

    final mapJogadores =
        json.decode(apiResponse.result.toString()).cast<Map<String, dynamic>>();

    final jogadores =
        mapJogadores.map<Jogador>((json) => Jogador.fromJson(json)).toList();

    return jogadores;
  }

  static Future<Jogador> salvar(Jogador c, File file) async {
    if (file != null) {
      final fotoResponse = await upload(file);
      c.urlFoto = fotoResponse.urlFoto;
    }

    final url = "http://livrowebservices.com.br/rest/carros";
    print("> post: $url");

    final headers = {"Content-Type": "application/json"};
    final body = convert.json.encode(c.toMap());
    print("   > $body");

    final response = await http
        .post(url, headers: headers, body: body)
        .timeout(Duration(seconds: 10), onTimeout: () {
      print("Estorou o tempo limite do timeout");
    });

    final s = response.body;
    print("   < $s");

    final r = Jogador.fromJson(convert.json.decode(s));

    return r;
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

    final mapJogadores =
        json.decode(apiResponse.result.toString()).cast<Map<String, dynamic>>();

    final jogadores =
        mapJogadores.map<Jogador>((json) => Jogador.fromJson(json)).toList();

    return jogadores;
  }

  static Future<Jogador> upload(File file) async {
    final url = "http://livrowebservices.com.br/rest/carros/postFotoBase64";

    List<int> imageBytes = file.readAsBytesSync();
    String base64Image = convert.base64Encode(imageBytes);

    String fileName = path.basename(file.path);

    var body = {"fileName": fileName, "base64": base64Image};
    print("http.upload >> " + body.toString());

    final response = await http
        .post(url, body: body)
        .timeout(Duration(seconds: 10), onTimeout: () {
      print("Estorou o tempo limite do timeout");
    });

    print("http.upload << " + response.body);

    Map<String, dynamic> map = convert.json.decode(response.body);

    var r = Jogador.fromJson(map);

    return r;
  }
}
