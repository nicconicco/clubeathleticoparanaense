import 'package:clubeathleticoparanaense/common/clazz/jogador.dart';
import 'package:clubeathleticoparanaense/common/utils/prefs.dart';
import 'package:clubeathleticoparanaense/features/listplayers/jogadores_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          Tab(
            text: "Todos",
          ),
          Tab(
            text: "Atacantes",
          ),
          Tab(
            text: "Meia",
          ),
          Tab(
            text: "Defesa",
          ),
          Tab(
            text: "Goleiro",
          ),
        ]),
      ),
      body: TabBarView(controller: tabController, children: [
        JogadoresListView(""),
        JogadoresListView(Posicao.atacante),
        JogadoresListView(Posicao.meio_centro),
        JogadoresListView(Posicao.defesa),
        JogadoresListView(Posicao.goleiro),
      ]),
    );
  }
}
