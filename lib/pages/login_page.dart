import 'package:flutter/material.dart';
import 'package:testapp/pages/home_page.dart';
import 'package:testapp/bloc/login_bloc.dart';



class LoginPage  extends StatefulWidget{
  _login createState()=> _login();
}
class _login extends State<LoginPage>{
  changePage(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Homepage()));
  }
  @override
  Widget build(BuildContext context) {
    final bloc = Login_bloc();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize:  MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder<String>(
                stream: bloc.email,
                builder: (context,snapshot) =>TextField(
                  onChanged: bloc.emailChanged,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText:"Enter Email",
                    labelText: "Email",
                    errorText: snapshot.error
                  ),
                ),
              ),
              SizedBox( height: 20.0,),
              StreamBuilder<String>(
                stream: bloc.password,
                builder: (context,snapshot) =>TextField(
                  onChanged: bloc.passwordchanged,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter password",
                    labelText: "Password",
                    errorText: snapshot.error
                  ),

                ),
              ),
              SizedBox(height:  20.0,),
              StreamBuilder<bool>(
                stream: bloc.submitCheck,
                builder: (context,snapshot) => RaisedButton(
                  color: Colors.tealAccent,
                  onPressed: snapshot.hasData?() => changePage(context)
                      :null,
                  child: Text("Submit"),
                )
              )
            ],
          ),
        ),
      ),
    );
  }

}
