import 'package:app/API/db_authentication.dart';
import 'package:app/Components/error.dart';
import 'package:app/Notifiers/notifier_auth.dart';
import 'package:flutter/material.dart';
import 'package:app/Components/image_banner.dart';
import 'package:provider/provider.dart';
import 'package:app/Model/user.dart';


class Register extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return RegisterState();
  }
}

class RegisterState extends State<Register>
{
  final _regFormKey = GlobalKey<FormState>();
  String fullname, username, password, email;
  String age;
  bool isSpeaker=false;
  bool isMod=false;
  String type = 'Normal';

  @override
  void initState() {
    super.initState();

  AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
  initializeCurrentUser(authNotifier);

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        body: new Stack(
          children: <Widget>[
            ImageBanner("assets/images/login.png", MediaQuery.of(context).size.height),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, 15.0),
                              blurRadius: 15.0),
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, -10.0),
                              blurRadius: 10.0),
                        ]
                    ),
                    child:

                    Form(

                        key: _regFormKey,
                        child:
                        Padding(
                            padding: EdgeInsets.all(25.0),

                          child: Column(
                            children: <Widget>[
                              Text("Register", style:
                                TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                )
                                ,),
                              Text("Create your account. It's free and it only takes a minute.", style:
                              TextStyle(
                                fontSize: 12.5,
                                color: Colors.black54,
                              )),
                              TextFormField(
                                validator: (input) => noEmptyFields(input),
                                decoration: InputDecoration(
                                    labelText: 'Username'
                                ),
                                onSaved: (input) => username = input,
                              ),
                              TextFormField(
                                validator: (input) => noEmptyFields(input),
                                decoration: InputDecoration(
                                    labelText: 'Full Name'
                                ),
                                onSaved: (input) => fullname = input,
                              ),
                              TextFormField(
                                validator: (input) => noEmptyFields(input),
                                decoration: InputDecoration(
                                    labelText: 'Email'
                                ),
                                onSaved: (input) => email = input,
                              ),
                              TextFormField(
                                validator: (input) => longerPassword(input),
                                decoration: InputDecoration(
                                    labelText: 'Password'
                                ),
                                onSaved: (input) => password = input,
                                obscureText: true,
                              ),
                              TextFormField(
                                validator: (input) => noEmptyFields(input),
                                decoration: InputDecoration(
                                    labelText: 'Age'
                                ),
                                onSaved: (input) => age = input,
                              ),

                              DropdownButton<String>(
                                value: type,
                                onChanged: (String newValue){
                                  setState(() {
                                    type = newValue;
                                  });
                                },
                                items: <String> ['Normal','Speaker','Admin'].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value)
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: 20.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  RaisedButton(
                                    padding: const EdgeInsets.fromLTRB(5.0, 4.0, 5.0, 4.0),
                                    textColor: Colors.white,
                                    color: Colors.blue,
                                    onPressed: ()
                                    {
                                      Navigator.pop(context,);
                                    },
                                    child: Text('Back'),
                                  ),

                                  RaisedButton(
                                    padding: const EdgeInsets.fromLTRB(5.0, 4.0, 5.0, 4.0),
                                    textColor: Colors.white,
                                    color: Colors.blue,
                                    onPressed: submitForm,
                                    child: Text('Submit'),
                                  ),

                                ],
                              ),

                            ],
                          )
                        )
                    )

                )
              ],
            )
          ],
        )
    );
  }

  submitForm(){
    if (!_regFormKey.currentState.validate()) {
      return;
    }
    _regFormKey.currentState.save();

    register(fullname, username, password, email, age, type);

    Navigator.pop(context, ); //Nao faz login imediatamente
  }
}