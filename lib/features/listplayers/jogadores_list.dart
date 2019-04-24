import 'package:clubeathleticoparanaense/common/clazz/jogador.dart';
import 'package:clubeathleticoparanaense/common/utils/nav.dart';
import 'package:clubeathleticoparanaense/features/home/repository/home_repository.dart';
import 'package:clubeathleticoparanaense/features/listplayers/detail/jogador_page.dart';
import 'package:flutter/material.dart';

class JogadoresListView extends StatefulWidget {
  final String posicao;

  const JogadoresListView(this.posicao);

  @override
  _JogadoresListViewState createState() => _JogadoresListViewState();
}

class _JogadoresListViewState extends State<JogadoresListView>
    with AutomaticKeepAliveClientMixin<JogadoresListView> {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return __body();
  }

  Container __body() {

    // todo: Fazer o VM
    final repo = HomeRepository();

    Future future = widget.posicao == ""
            ? repo.getJogadores()
            : repo.getJogadoresPorPosicao(widget.posicao);

    return Container(
      padding: EdgeInsets.only(top: 16, left: 16, right: 16),
      child: FutureBuilder<List<Jogador>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                  child: Text(
                "Nenhum jogador na lista do servidor.",
                style: TextStyle(fontSize: 25, color: Colors.redAccent),
              ));
            } else if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return _listView(snapshot.data);
            }
          }),
    );
  }

  _listView(List<Jogador> jogadores) {
    return ListView.builder(
        itemCount: jogadores.length,
        itemBuilder: (ctx, idx) {
          final jogador = jogadores[idx];

          return InkWell(
            onTap: () {
              _onClickDetails(context, jogador);
            },
            child: Container(
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("img/cap.png"), fit: BoxFit.cover)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: EdgeInsets.only(top: 20, right: 20),
                              child: Image.network(jogador.urlFoto, width: 100,),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            color: Colors.black45,
                            child: Center(
                              child: Text(
                                jogador.nome,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            ),
                          )
                        ],
                      ),
                      ButtonTheme.bar(
                        // make buttons use the appropriate styles for cards
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('DETALHES'),
                              onPressed: () {
                                _onClickDetails(context, jogador);
                              },
                            ),
                            FlatButton(
                              child: const Text('SHARE'),
                              onPressed: () {
                                /* ... */
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void _onClickDetails(BuildContext context, Jogador jogador) {
    push(context, JogadorPage(jogador));
  }
}
