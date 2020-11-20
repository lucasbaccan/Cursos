import 'package:flutter/material.dart';
import 'package:gourmet_mobile/util/app_route.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text("Comanda"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, AppRoute.SETTINGS),
          )
        ],
      ),
      body: Container(
        constraints: BoxConstraints(maxWidth: 500),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/login_background.png"),
            fit: BoxFit.cover,
            repeat: ImageRepeat.repeat,
            // colorFilter: new ColorFilter.mode(
            //   Colors.black.withOpacity(0.2),
            //   BlendMode.srcATop,
            // ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Colors.black.withOpacity(0.6),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/logo.png",
                          height: 80,
                          width: 80,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        // controller: emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Usuário",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                        onSubmitted: (_) {
                          FocusScope.of(context).nextFocus();
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 15.0),
                      TextField(
                        // controller: senhaController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Senha",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                        obscureText: true,
                        // onSubmitted: (_) => _realizarLogin(),
                        textInputAction: TextInputAction.send,
                      ),
                      SizedBox(height: 20.0),
                      // SizedBox(
                      //   height: 45,
                      //   child: isLoading
                      //       ? Center(child: CircularProgressIndicator())
                      //       :
                      RaisedButton(
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor.computeLuminance() > 0.5
                                  ? Colors.black
                                  : Colors.white),
                        ),
                        onPressed: () {},
                        // onPressed: () => _realizarLogin(),
                        elevation: 5,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        color: Theme.of(context).primaryColor,
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      // ),
                      SizedBox(height: 15.0),
                      Center(
                        child: Text(
                          "AppInfo.version()",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Image.asset(
//               "assets/login_background.png",
//               width: size.width,
//               height: size.height,
//               fit: BoxFit.cover,
//             )
