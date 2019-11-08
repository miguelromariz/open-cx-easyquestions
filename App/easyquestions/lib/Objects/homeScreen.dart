import 'package:flutter/material.dart';
import 'package:easyquestions/Objects/image_banner.dart';

class homeScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Easy Questions')
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ImageBanner("assets/images/home.png", (MediaQuery
                  .of(context)
                  .size
                  .height) / 2.5),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    children: <Widget>[
                      Text(
                          "MON 23 - THU 26 MARCH",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          )
                      ),

                      Text(
                        "< Programming >" + "\n 2020",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 35,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "\nThe 4th International Conference on the" +
                            "\n Art, Science, and Engineering of Programming \n",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      RaisedButton(
                        padding: const EdgeInsets.fromLTRB(5.0, 4.0, 5.0, 4.0),
                        textColor: Colors.white,
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.pushNamed(context, 'loginScreen');
                        },
                        child: new Text("LOGIN"),
                      ),
                      RaisedButton(
                        padding: const EdgeInsets.fromLTRB(5.0, 4.0, 5.0, 4.0),
                        textColor: Colors.white,
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.pushNamed(context, 'registerScreen');
                        },
                        child: new Text("REGISTER"),
                      )
                    ],
                  ),
                ),
              ),
            ]
        )
    );
  }
}