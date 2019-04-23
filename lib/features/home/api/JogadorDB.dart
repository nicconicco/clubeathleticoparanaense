import 'dart:async';
import 'package:clubeathleticoparanaense/common/clazz/jogador.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class JogadorDB {
  static final JogadorDB _instance = new JogadorDB.getInstance();
  factory JogadorDB() => _instance;
  JogadorDB.getInstance();
  static Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }
  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'jogadores.db');
    print("db $path");
    // para testes vc pode deletar o banco
    //await deleteDatabase(path);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }
  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE jogador(id INTEGER PRIMARY KEY, objectId TEXT,  nome TEXT,'
            'posicao TEXT, descricao TEXT, urlFoto TEXT)');
  }
  Future<int> saveJogador(Jogador carro) async {
    var dbClient = await db;
    final sql =
        'insert or replace into jogador (id, objectId, posicao, nome, descricao, urlFoto) VALUES '
        '(?,?,?,?,?,?)';
    print(sql);
    var id = await dbClient.rawInsert(sql, [
      carro.id,
      carro.objectId,
      carro.posicao,
      carro.nome,
      carro.descricao,
      carro.urlFoto
    ]);
    print('id: $id');
    return id;
  }
  Future<List<Jogador>> getJogadores() async {
    final dbClient = await db;
    final mapCarros = await dbClient.rawQuery('select * from jogador');
    final carros = mapCarros.map<Jogador>((json) => Jogador.fromJson(json)).toList();
    return carros;
  }
  Future<int> getCount() async {
    final dbClient = await db;
    final result = await dbClient.rawQuery('select count(*) from jogador');
    return Sqflite.firstIntValue(result);
  }
  Future<Jogador> getJogador(String id) async {
    var dbClient = await db;
    final result = await dbClient.rawQuery('select * from jogador where objectId = ?',[id]);
    if (result.length > 0) {
      return new Jogador.fromJson(result.first);
    }
    return null;
  }
  Future<bool> exists(Jogador jogador) async {
    Jogador c = await getJogador(jogador.objectId);
    var exists = c != null;
    return exists;
  }
  Future<int> deleteJogador(String id) async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from jogador where objectId = ?',[id]);
  }
  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
