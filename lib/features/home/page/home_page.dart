

import 'package:clubeathleticoparanaense/common/clazz/jogador.dart';
import 'package:clubeathleticoparanaense/common/utils/nav.dart';
import 'package:clubeathleticoparanaense/common/utils/prefs.dart';
import 'package:clubeathleticoparanaense/features/listplayers/jogadores_favorite_list.dart';
import 'package:clubeathleticoparanaense/features/listplayers/jogadores_list.dart';
import 'package:clubeathleticoparanaense/features/newplayer/new_player.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 5, vsync: this);

    Prefs.getInt("tabIndex").then((idx) {
      tabController.index = idx;
    });

    tabController.addListener(() async {
      int idx = tabController.index;
      Prefs.setInt("tabIndex", idx);
      print("tabIndex = $idx");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clube Atlhetico Paranaense"),
        bottom: TabBar(controller: tabController, tabs: [
//          Tab(
//            icon: Icon(Icons.directions_run),
//            text: "Todos",
//          ),
          Tab(
            icon: Icon(Icons.directions_run),
            text: "Atacantes",
          ),
          Tab(
            icon: Icon(Icons.directions_run),
            text: "Meia",
          ),
          Tab(
            icon: Icon(Icons.directions_run),
            text: "Defesa",
          ),
          Tab(
            icon: Icon(Icons.accessibility),
            text: "Goleiro",
          ),
          Tab(
            icon: Icon(Icons.favorite),
            text: "Favoritos",
          ),
        ]),
      ),
      body: TabBarView(controller: tabController, children: [
//        JogadoresListView(""),
        JogadoresListView(Posicao.atacante),
        JogadoresListView(Posicao.meio_centro),
        JogadoresListView(Posicao.defesa),
        JogadoresListView(Posicao.goleiro),
        JogadoresFavoriteListView(),
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          push(context, NewPlayer());
        },
      ),
    );
  }
}
