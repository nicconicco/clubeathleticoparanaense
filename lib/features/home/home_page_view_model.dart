import 'package:clubeathleticoparanaense/common/clazz/jogador.dart';
import 'package:clubeathleticoparanaense/common/utils/prefs.dart';
import 'package:clubeathleticoparanaense/features/home/repository/home_repository.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePageViewModel extends Model {

  // Variavel
  Future<List<Jogador>> _jogadores;

  // get da Variavel
  Future<List<Jogador>> get jogadores => _jogadores;

  // set da variavel que avisa a view
  set jogador(Future<List<Jogador>> value) {
    _jogadores = value;
    notifyListeners();
  }

  Future<bool> setJogadores() async {
    _jogadores = HomeRepository().getJogadores();
    return jogadores != null;
  }

  Future<int> getTabSaved() async {
    return Prefs.getInt("tabIndex");
  }
}
