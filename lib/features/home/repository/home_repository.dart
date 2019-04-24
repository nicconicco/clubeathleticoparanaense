import 'package:clubeathleticoparanaense/common/clazz/jogador.dart';
import 'package:clubeathleticoparanaense/features/home/api/JogadorDB.dart';

class HomeRepository {
  Future<bool> exist(Jogador jogador) async {
    return JogadorDB.getInstance().exists(jogador);
  }
}
