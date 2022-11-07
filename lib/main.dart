import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:convert/convert.dart';
import 'package:web3dart/credentials.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_js/flutter_js.dart';
// import 'package:flutter_js/javascript_runtime.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await initHiveForFlutter();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter GraphQL Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   JavascriptRuntime flutterJs = getJavascriptRuntime();
//   var data = [];

// //read data
//   fetchData() async {
//     HttpLink link = HttpLink("https://rickandmortyapi.com/graphql");
//     GraphQLClient qlient =
//         GraphQLClient(link: link, cache: GraphQLCache(store: HiveStore()));
//     QueryResult result =
//         await qlient.query(QueryOptions(document: gql("""query {
//     characters(){
//       results {
//         image
//         name
//       }
//    }} """)));
//     setState(() {
//       data = result.data!['characters']['results'];
//       isLoading = false;
//     });
//   }

//   bool isLoading = true;
//   TextEditingController nameController = TextEditingController();
//   TextEditingController username = TextEditingController();
//   TextEditingController number = TextEditingController();
//   var _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     fetchData();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     username.dispose();
//     number.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         key: _scaffoldKey,
//         floatingActionButton: FloatingActionButton(
//           onPressed: () async {
//             String blocJs = await rootBundle.loadString("asset/test.js");
//             try {
//               JsEvalResult jsResult = flutterJs.evaluate(blocJs);
//               print(jsResult);
//             } catch (exc) {
//               print(exc);
//             }

//             // showDialog(
//             //     context: _scaffoldKey.currentContext!,
//             //     builder: (BuildContext ctxt) => dialog(context));
//           },
//           child: const Icon(Icons.add),
//         ),
//         appBar: AppBar(
//           title: const Text("Test"),
//         ),
//         body: const Center(
//           child: Text("Please Watch Console For Response Time"),
//         ));
//   }

// //   Widget dialog(BuildContext context) {
// //     return Dialog(
// //       insetPadding: const EdgeInsets.all(15),
// //       child: Padding(
// //         padding: const EdgeInsets.all(15.0),
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             const Text(
// //               "Enter New Data To Add",
// //               style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
// //             ),
// //             const SizedBox(
// //               height: 15,
// //             ),
// //             Container(
// //               margin: const EdgeInsets.symmetric(horizontal: 25),
// //               child: TextField(
// //                 controller: nameController,
// //                 decoration: InputDecoration(
// //                     fillColor: Colors.white,
// //                     filled: true,
// //                     border: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(10)),
// //                     hintText: "Enter Name",
// //                     labelText: "Name"),
// //               ),
// //             ),
// //             const SizedBox(
// //               height: 20,
// //             ),
// //             Container(
// //               margin: const EdgeInsets.symmetric(horizontal: 25),
// //               child: TextField(
// //                 controller: username,
// //                 decoration: InputDecoration(
// //                     fillColor: Colors.white,
// //                     filled: true,
// //                     border: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(10)),
// //                     hintText: "Enter Username",
// //                     labelText: "Username"),
// //               ),
// //             ),
// //             const SizedBox(
// //               height: 20,
// //             ),
// //             Container(
// //               margin: const EdgeInsets.symmetric(horizontal: 25),
// //               child: TextField(
// //                 controller: number,
// //                 keyboardType: TextInputType.phone,
// //                 decoration: InputDecoration(
// //                     fillColor: Colors.white,
// //                     filled: true,
// //                     border: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(10)),
// //                     hintText: "Enter Number",
// //                     labelText: "Number"),
// //               ),
// //             ),
// //             const SizedBox(
// //               height: 20,
// //             ),
// //             Align(
// //               alignment: Alignment.bottomRight,
// //               child: ElevatedButton(
// //                 child: const Text("Save"),
// //                 onPressed: () {
// //                   Navigator.pop(context);
// //                 },
// //               ),
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// }
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  String Data = "Processing...";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isLoading = true;
          });
          testerFunction();
        },
        child: const Icon(Icons.play_arrow),
      ),
      body: Center(
          child: Text(!isLoading ? "Enter Play Button To Start." : Data)),
    );
  }

  testerFunction() async {
    var batchSize = 10;
    List<EthPrivateKey> addressBatch = List.filled(
      batchSize,
      EthPrivateKey.createRandom(Random.secure()),
      growable: true,
    );
    random(length) {
      String chars;
      chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
      late String str = "";
      for (int i = 0; i < length; i++) {
        str += charAt(chars, Random().nextInt(chars.length));
      }
      return str;
    }

    var secretMessage = random(1000);
    print("Processing.....");
    DateTime startTime = DateTime.now();
    for (int i = 0; i < batchSize; i++) {
      addressBatch[i] = EthPrivateKey.createRandom(Random.secure());
    }
    DateTime endTime = DateTime.now();
    for (int i = 0; i < batchSize; i++) {
      print(
          "u[$i]\naddress: ${addressBatch[i].address}\npublickey: ${hex.encode(addressBatch[0].encodedPublicKey)},\nprivateKey: ${hex.encode(addressBatch[0].privateKey)}");
    }
    setState(() {
      Data =
          "Generated $batchSize addresses in ${endTime.difference(startTime).inMilliseconds} ms";
    });
  }
}

String charAt(String subject, int position) {
  if (subject is! String ||
      subject.length <= position ||
      subject.length + position < 0) {
    return '';
  }

  int _realPosition = position < 0 ? subject.length + position : position;

  return subject[_realPosition];
}
