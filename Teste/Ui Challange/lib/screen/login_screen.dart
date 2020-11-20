import 'package:flutter/material.dart';
import 'package:gourmet_mobile/provider/app_provider.dart';
import 'package:gourmet_mobile/provider/network_provider.dart';
import 'package:gourmet_mobile/service/api_service.dart';
import 'package:gourmet_mobile/util/app_route.dart';
import 'package:gourmet_mobile/util/shared_preferences_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // _getUsername();
  }

  // void _getUsername() async {
  //   final SharedPreferences preferencia = await SharedPreferences.getInstance();
  //   String username = preferencia.getString(SharedPreferencesHelper.USER_USERNAME);
  //   if (username != null) _usernameController.text = username;
  // }

  // void _setUsername(String userEmail) async {
  //   final SharedPreferences preferencia = await SharedPreferences.getInstance();
  //   preferencia.setString(SharedPreferencesHelper.USER_USERNAME, userEmail);
  // }

  void _realizarLogin(AppProvider appProvider, String ip, String port, String usuario, String senha) {
    setState(() {
      isLoading = true;
    });
    appProvider.realizarLogin(usuario, senha).then(
      (value) {
        // setState(() {
        //   isLoading = false;
        // });
        if (value) {
          // _setUserEmail(emailController.text);
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoute.HOME,
            (Route<dynamic> route) => false,
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Ocorreu um erro"),
                content: Text("Erro ao realizar o login, verifique se o e-mail e a senha estão corretos."),
                actions: <Widget>[
                  // define os botões na base do dialogo
                  new FlatButton(
                    child: new Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of(context);
    final NetworkProvider networkProvider = Provider.of(context);

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, AppRoute.SETTINGS),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/login_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              color: Colors.white.withOpacity(0.93),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 24.0, right: 24.0),
                children: <Widget>[
                  SizedBox(height: 8.0),
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 40.0,
                    child: Image.asset('assets/logo.png'),
                  ),
                  SizedBox(height: 25.0),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: 'Usuário',
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    controller: _senhaController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Senha',
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                  SizedBox(height: 25.0),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    onPressed: () async {
                      if (networkProvider.ipsEncontrados.length <= 0) {
                        await networkProvider.buscarConexaoSistema();
                        appProvider.ip = networkProvider.ipsEncontrados[0];
                        appProvider.porta = "12345";
                      }
                      _realizarLogin(
                        appProvider,
                        appProvider.ip,
                        appProvider.porta,
                        _usernameController.text,
                        _senhaController.text,
                      );
                    },
                    padding: EdgeInsets.all(12),
                    color: Theme.of(context).accentColor,
                    child: Text('Log In', style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(height: 5.0),
                  Center(
                    child: Text(
                      "Versão do sistema: ",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  SizedBox(height: 5.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
