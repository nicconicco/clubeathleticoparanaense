import 'package:clubeathleticoparanaense/common/clazz/jogador.dart';
import 'package:clubeathleticoparanaense/features/home/api/JogadorDB.dart';
import 'package:flutter/material.dart';

class JogadorPage extends StatefulWidget {
  final Jogador jogador;

  const JogadorPage(this.jogador);

  @override
  _JogadorPageState createState() => _JogadorPageState();
}

class _JogadorPageState extends State<JogadorPage> {
  get jogador => widget.jogador;

  bool _isFavorite = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    JogadorDB.getInstance().exists(jogador).then((response) {
      setState(() {
        _isFavorite = response;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(jogador.nome),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      child: ListView(padding: EdgeInsets.all(16), children: <Widget>[
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("img/cap.png"), fit: BoxFit.cover)),
          padding: EdgeInsets.only(bottom: 16, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Image.network(
                jogador.urlFoto,
                width: 100,
                height: 100,
              ),
            ],
          ),
        ),
        Container(
            padding: EdgeInsets.only(top: 10),
            child: _bloco1()),
        _bloco2(),
      ]),
    );
  }

  Row _bloco1() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                jogador.nome,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                jogador.posicao,
                style: TextStyle(fontSize: 16, color: Colors.grey[500]),
              )
            ],
          ),
        ),
        InkWell(
          onTap: () {
            _onClickFavorite(context, jogador);
          },
          child: Icon(
            Icons.favorite,
            color: _isFavorite ? Colors.red : Colors.grey,
            size: 36,
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          child: InkWell(
            onTap: _onClickShare(),
            child: Icon(
              Icons.share,
              size: 36,
            ),
          ),
        ),
      ],
    );
  }

  _onClickShare() {}

  Future _onClickFavorite(BuildContext context, Jogador jogador) async {
    final db = JogadorDB.getInstance();

    final exists = await db.exists(jogador);

    if (exists) {
      db.deleteJogador(jogador.objectId);
      print("deletado com sucesso");
    } else {
      int id = await db.saveJogador(jogador);
      print("id salvo com sucesso $id");
    }

    setState(() {
      _isFavorite = !exists;
    });
  }

  _bloco2() {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Informações ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            jogador.descricao,
            style: TextStyle(fontSize: 16),
          ),
          Text(
            "Id do jogador no database web: " + jogador.objectId,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
