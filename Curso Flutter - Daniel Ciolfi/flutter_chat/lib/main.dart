import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

void main() async {
  runApp(MyApp());
}

final ThemeData kIOSTheme =
ThemeData(primarySwatch: Colors.orange, primaryColor: Colors.grey[100], primaryColorBrightness: Brightness.light);

final ThemeData kDefaultTheme = ThemeData(primarySwatch: Colors.purple, accentColor: Colors.orange[400]);

final googleSingIn = GoogleSignIn();
final auth = FirebaseAuth.instance;

Future<Null> _ensureLoggedIn() async {
  GoogleSignInAccount user = googleSingIn.currentUser;
  if (user == null) {
    user = await googleSingIn.signInSilently();
  }
  if (user == null) {
    user = await googleSingIn.signIn();
  }

  if (await auth.currentUser() == null) {
    GoogleSignInAuthentication credentials = await googleSingIn.currentUser.authentication;

    await auth.signInWithCredential(
        GoogleAuthProvider.getCredential(idToken: credentials.idToken, accessToken: credentials.accessToken));
  }
}

final _textController = TextEditingController();

_handleSubmitted(String texto) async {
  await _ensureLoggedIn();

  _sendMessage(texto: texto);
}

void _sendMessage({String texto, String imageUrl}) {
  Firestore.instance.collection("messages").add({
    "texto": texto,
    "imageUrl": imageUrl,
    "senderName": googleSingIn.currentUser.displayName,
    "senderPhotoUrl": googleSingIn.currentUser.photoUrl
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Achouuuuuuuuuuuuu",
        debugShowCheckedModeBanner: false,
        theme: Theme
            .of(context)
            .platform == TargetPlatform.iOS ? kIOSTheme : kDefaultTheme,
        home: ChatScreen());
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Chat App"),
            centerTitle: true,
            elevation: Theme
                .of(context)
                .platform == TargetPlatform.iOS ? 0 : 4,
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: StreamBuilder(
                    stream: Firestore.instance.collection("messages").snapshots(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        default:
                          return ListView.builder(
                              reverse: true,
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (context, index) {
                                List r = snapshot.data.documents.reversed.toList();
                                return ChatMessage(r[index].data);
                              });
                      }
                    }),
              ),
              Divider(
                height: 1,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .cardColor,
                ),
                child: TextComposer(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TextComposer extends StatefulWidget {
  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  bool _isComposing = false;

  void _reset() {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(color: Theme
          .of(context)
          .accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: Theme
            .of(context)
            .platform == TargetPlatform.iOS
            ? BoxDecoration(border: Border(top: BorderSide(color: Colors.grey[200])))
            : null,
        child: Row(
          children: <Widget>[
            Container(
              child: IconButton(icon: Icon(Icons.photo_camera), onPressed: () async {
                await _ensureLoggedIn();
                File imgFile = await ImagePicker.pickImage(source: ImageSource.camera,maxHeight: 480, maxWidth: 640);
                if (imgFile == null) return;

                StorageUploadTask task = FirebaseStorage.instance.ref().child(googleSingIn.currentUser.id.toString() +
                    DateTime
                        .now()
                        .millisecondsSinceEpoch
                        .toString()).putFile(imgFile);
                StorageTaskSnapshot taskSnapshot = await task.onComplete;
                String url = await taskSnapshot.ref.getDownloadURL();
                _sendMessage(imageUrl: url);
              }),
            ),
            Expanded(
              child: TextField(
                controller: _textController,
                decoration: InputDecoration.collapsed(hintText: "Enviar uma mensagem"),
                onChanged: (text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
                onSubmitted: (texto) {
                  _handleSubmitted(texto);
                  _reset();
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Theme
                  .of(context)
                  .platform == TargetPlatform.iOS
                  ? CupertinoButton(
                child: Text("Enviar"),
                onPressed: _isComposing
                    ? () {
                  _handleSubmitted(_textController.text);
                  _reset();
                }
                    : null,
              )
                  : IconButton(
                icon: Icon(Icons.send),
                onPressed: _isComposing
                    ? () {
                  _handleSubmitted(_textController.text);
                  _reset();
                }
                    : null,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final Map<String, dynamic> data;

  ChatMessage(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundImage: NetworkImage(data["senderPhotoUrl"]),
            ),
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data["senderName"],
                    style: Theme
                        .of(context)
                        .textTheme
                        .subhead,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: data["imageUrl"] != null
                        ? Image.network(
                      data["imageUrl"],
                      width: 250,
                    )
                        : Text(data["texto"]),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
