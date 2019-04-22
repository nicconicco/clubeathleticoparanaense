import 'package:clubeathleticoparanaense/features/home/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
//  DietPlanRepository dietPlanRepo;
//  UserRepository userRepo;

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
      home: HomePage(),
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

