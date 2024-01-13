import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hackathon_app/utils/web_socket_helper.dart';

class PartyPage extends StatefulWidget {
  const PartyPage({Key? key}) : super(key: key);

  @override
  State<PartyPage> createState() => _PartyPageState();
}

class _PartyPageState extends State<PartyPage> {
  final WebSocket _socket = WebSocket("");
  bool _isConnected = false;
  void connect(BuildContext context) async {
    _socket.connect();
    setState(() {
      _isConnected = true;
    });
  }

  void disconnect() {
    _socket.disconnect();
    setState(() {
      _isConnected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => connect(context),
                    child: const Text("Connect"),
                  ),
                  ElevatedButton(
                    onPressed: disconnect,
                    child: const Text("Disconnect"),
                  ),
                ],
              ),
              const SizedBox(
                height: 50.0,
              ),
              _isConnected
                  ? StreamBuilder(
                      stream: _socket.stream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }

                        if (snapshot.connectionState == ConnectionState.done) {
                          return const Center(
                            child: Text("Connection Closed"),
                          );
                        }
                        return Image.memory(
                          Uint8List.fromList(
                            base64Decode(
                              (snapshot.data.toString()),
                            ),
                          ),
                          gaplessPlayback: true,
                          excludeFromSemantics: true,
                        );
                      },
                    )
                  : const Text("Initiate Connection")
            ],
          ),
        ),
      ),
    );
  }
}