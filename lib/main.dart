import 'package:clubeathleticoparanaense/features/home/home_page_view_model.dart';
import 'package:clubeathleticoparanaense/features/home/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

final HomePageViewModel mainPageVM = HomePageViewModel();

void main() => runApp(MyApp(mainPageVM: mainPageVM));

class MyApp extends StatefulWidget {
  final HomePageViewModel mainPageVM;
  MyApp({@required this.mainPageVM});

  @override
  _MyAppState createState() => _MyAppState(mainPageVM);
}

class _MyAppState extends State<MyApp> {
  _MyAppState(HomePageViewModel mainPageVM);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initData());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clube Athletico Paranaense',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(viewModel: widget.mainPageVM),
    );
  }
}

Future<void> initData() async {
  // Initialize parse
  Parse().initialize("ntAhu42wPmEvdbCYhOWkDRk3N4TQWRop4gjgBcc5",
      "https://parseapi.back4app.com/",
      clientKey: "bZtUIRfj7TSj7CEQrXehFPbntl2SKyl12Nbv5jde", debug: true);

  // Check server is healthy and live - Debug is on in this instance so check logs for result
  final ParseResponse response = await Parse().healthCheck();
  if (response.success) {
    print("Parse is Ok");
  } else {
    print('Server health check failed');
  }
}
