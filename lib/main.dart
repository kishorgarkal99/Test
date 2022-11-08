import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Metamask Integration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MetamaskConnect(),
    );
  }
}

class MetamaskConnect extends StatefulWidget {
  const MetamaskConnect({super.key});

  @override
  State<MetamaskConnect> createState() => _MetamaskConnectState();
}

class _MetamaskConnectState extends State<MetamaskConnect> {
  var connector = WalletConnect(
    bridge: "https://bridge.walletconnect.org",
    clientMeta: const PeerMeta(
      name: "Deme",
      description: "NFT App",
      url: "https://walletconnect.org",
      icons: [
        "https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media"
      ],
    ),
  );

  var _session, _uri, Data = "Please Click Play Button To Encrypt Message";
  var userkey;

  LoginUsingMetamask(BuildContext context) async {
    if (!connector.connected) {
      try {
        var session = await connector.createSession(onDisplayUri: (uri) async {
          _uri = uri;
          await launchUrlString(uri, mode: LaunchMode.externalApplication);
        });
        setState(() {
          _session = session;
        });
        // var key = await connector.sendCustomRequest(
        //     method: 'eth_getEncryptionPublicKey',
        //     params: [session.accounts[0].toString()]);
        // setState(() {
        //   userkey = key;
        // });
      } catch (error) {
        print(error);
      }
    } else {
      print("Connection Successful");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await testerFunction(WalletConnectCipher()
              .generateKey(length: 32, random: Random.secure()));
        },
        child: const Icon(Icons.play_arrow),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
            child: Center(
          child: _session == null
              ? ElevatedButton(
                  onPressed: () async {
                    //connect wallet here
                    await LoginUsingMetamask(context);
                  },
                  child: const Text("Connect Wiith Metamask"))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ">>Account Connected \n >>Wallet ID: ${_session.accounts[0]}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      Data,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
        )),
      ),
    );
  }

  testerFunction(key) async {
    var batchSize = 10000;
    random(length) {
      String chars;
      chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
      late String str = "";
      for (int i = 0; i < length; i++) {
        str += charAt(chars, Random().nextInt(chars.length));
      }
      return str;
    }

    //-------------------------------------------user creation ----------------------------------------------------
    if (kDebugMode) {
      print("Processing.....");
    }
    var startTime = DateTime.now();
    try {
      for (int i = 0; i < batchSize; i++) {
        var secretMessage = random(1000);
        await WalletConnectCipher()
            .encrypt(data: ascii.encode(secretMessage), key: await key);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    var endTime = DateTime.now();

    if (kDebugMode) {
      print(
          "Encrypted $batchSize messages in ${endTime.difference(startTime).inMilliseconds} ms");
    }
    setState(() {
      Data =
          "Encrypted $batchSize messages in ${endTime.difference(startTime).inMilliseconds} ms";
    });
  }
}

String charAt(String subject, int position) {
  // ignore: unnecessary_type_check
  if (subject is! String ||
      subject.length <= position ||
      subject.length + position < 0) {
    return '';
  }

  int realPosition = position < 0 ? subject.length + position : position;

  return subject[realPosition];
}
