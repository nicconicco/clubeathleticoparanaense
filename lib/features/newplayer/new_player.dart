import 'dart:io';

import 'package:clubeathleticoparanaense/common/clazz/jogador.dart';
import 'package:clubeathleticoparanaense/common/utils/alert.dart';
import 'package:clubeathleticoparanaense/common/utils/nav.dart';
import 'package:clubeathleticoparanaense/features/home/repository/home_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewPlayer extends StatefulWidget {
  final Jogador jogador;

  NewPlayer({this.jogador});

  @override
  State<StatefulWidget> createState() => new _NewPlayerState();
}

class _NewPlayerState extends State<NewPlayer> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final tNome = TextEditingController();
  final tDesc = TextEditingController();
  final tTipo = TextEditingController();

  int _radioIndex = 0;

  var _showProgress = false;

  File fileCamera;

  get jogador => widget.jogador;

  // Add validate email function.
  String _validateNome(String value) {
    if (value.isEmpty) {
      return 'Informe o nome do jogador.';
    }

    return null;
  }

  @override
  void initState() {
    super.initState();

    if (jogador != null) {
      tNome.text = jogador.nome;
      tDesc.text = jogador.descricao;
      _radioIndex = getTipoInt(jogador);
    }
  }

  getTipoInt(Jogador jogador) {
    switch (jogador.posicao) {
      case "Atacante":
        return 0;
      case "Meio":
        return 1;
      case "Defesa":
        return 2;
      case "Goleiro":
        return 3;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          jogador != null ? jogador.nome : "Novo Jogador",
        ),
      ),
      body: new Container(
        padding: new EdgeInsets.all(16),
        child: _form(),
      ),
    );
  }

  _form() {
    return new Form(
      key: this._formKey,
      child: new ListView(
        children: <Widget>[
          _headerFoto(),
          Text(
            "Clique na imagem para tirar uma foto",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Divider(),
          new Text(
            "Posicao",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
          ),
          _radioTipo(),
          Divider(),
          new TextFormField(
            controller: tNome,
            keyboardType: TextInputType.text,
            validator: _validateNome,
            style: TextStyle(color: Colors.blue, fontSize: 20),
            decoration: new InputDecoration(
              hintText: '',
              labelText: 'Nome',
            ),
          ),
          new TextFormField(
            controller: tDesc,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
            decoration: new InputDecoration(
              hintText: '',
              labelText: 'Descrição',
            ),
          ),
          new Container(
            height: 50,
            margin: new EdgeInsets.only(top: 20.0),
            child: RaisedButton(
              color: Colors.blue,
              child: _showProgress
                  ? CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : new Text(
                      "Salvar",
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
              onPressed: () {
                _onClickSalvar(context);
              },
            ),
          )
        ],
      ),
    );
  }

  _headerFoto() {
    if (fileCamera != null) {
      return InkWell(
        child: Image.file(
          fileCamera,
          height: 150,
        ),
        onTap: _onClickFoto,
      );
    }

    return InkWell(
      child: jogador != null && jogador.urlFoto != null
          ? Image.network(
              jogador.urlFoto,
              height: 150,
            )
          : Image.asset(
              "img/camera.png",
              height: 100,
            ),
      onTap: _onClickFoto,
    );
  }

  _onClickFoto() async {
    fileCamera = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {});
  }

  _radioTipo() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Radio(
            value: 0,
            groupValue: _radioIndex,
            onChanged: _onClickTipo,
          ),
          new Text(
            "Atacante",
            style: TextStyle(color: Colors.blue, fontSize: 10),
          ),
          new Radio(
            value: 1,
            groupValue: _radioIndex,
            onChanged: _onClickTipo,
          ),
          new Text(
            "Meio",
            style: TextStyle(color: Colors.blue, fontSize: 10),
          ),
          new Radio(
            value: 2,
            groupValue: _radioIndex,
            onChanged: _onClickTipo,
          ),
          new Text(
            "Defesa",
            style: TextStyle(color: Colors.blue, fontSize: 10),
          ),
          new Radio(
            value: 3,
            groupValue: _radioIndex,
            onChanged: _onClickTipo,
          ),
          new Text(
            "Goleiro",
            style: TextStyle(color: Colors.blue, fontSize: 10),
          ),
        ],
      ),
    );
  }

  void _onClickTipo(int value) {
    setState(() {
      _radioIndex = value;
    });
  }

  String _getTipo() {
    switch (_radioIndex) {
      case 0:
        return "Atacante";
      case 1:
        return "Meio";
      case 2:
        return "Defesa";
      case 3:
        return "Goleiro";
      default:
        return "Goleiro";
    }
  }

  _onClickSalvar(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    var c = jogador ?? Jogador();
    c.nome = tNome.text;
    c.desc = tDesc.text;
    c.tipo = _getTipo();

    setState(() {
      _showProgress = true;
    });

    final response = await HomeRepository.salvar(c, fileCamera);
    if (response.isOk()) {
      alert(context, "Jogador salvo", response.msg,
          callback: () => pop(context));
    } else {
      alert(context, "Erro", response.msg);
    }

    setState(() {
      _showProgress = false;
    });
  }
}
