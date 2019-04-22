import 'package:clubeathleticoparanaense/common/clazz/jogador.dart';
import 'package:flutter/material.dart';

class JogadorPage extends StatefulWidget {
  final Jogador jogador;

  const JogadorPage(this.jogador);

  @override
  _JogadorPageState createState() => _JogadorPageState();
}

class _JogadorPageState extends State<JogadorPage> {
  get jogador => widget.jogador;

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
    return ListView(padding: EdgeInsets.all(16), children: <Widget>[
      Container(
        padding: EdgeInsets.only(bottom: 16),
        child: Image.network(
          jogador.urlFoto,
          height: 200,
        ),
      ),
      _bloco1(),
      _bloco2(),
    ]);
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
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                jogador.posicao,
                style: TextStyle(fontSize: 22, color: Colors.grey[500]),
              )
            ],
          ),
        ),
        InkWell(
          onTap: _onClickFavorite(),
          child: Icon(
            Icons.favorite,
            color: Colors.red,
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

  _onClickFavorite() {}

  _bloco2() {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Informações ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
          SizedBox(height: 10,),
          Text(jogador.descricao, style: TextStyle(fontSize: 16),),
        ],
      ),
    );
  }
}
