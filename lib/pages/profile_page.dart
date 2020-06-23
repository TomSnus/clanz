import 'package:clanz/presentaion/clanz_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfilePage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => ProfilePage(),
      );

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        ClanzColors.getPrimaryColor(),
                        ClanzColors.getSecColor()
                      ])),
                  child: Positioned(
                    width: double.infinity,
                    height: height / 3,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
                            ),
                            radius: 50.0,
                          ),
                          SizedBox(
                            height: height / 50,
                          ),
                          Text(
                            "Sentes",
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                              //height: 5.0,
                              ),
                          Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 5.0),
                            clipBehavior: Clip.antiAlias,
                            color: Colors.white,
                            elevation: 5.0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 22.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "DKP",
                                          style: TextStyle(
                                            color:
                                                ClanzColors.getPrimaryColor(),
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                            //height: 5.0,
                                            ),
                                        Text(
                                          "5200",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: ClanzColors.getSecColor(),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "email",
                                          style: TextStyle(
                                            color:
                                                ClanzColors.getPrimaryColor(),
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                            //height: 5.0,
                                            ),
                                        Text(
                                          "sentes@4charitygaming.de",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: ClanzColors.getSecColor(),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "Rank",
                                          style: TextStyle(
                                            color:
                                                ClanzColors.getPrimaryColor(),
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                            //height: 5.0,
                                            ),
                                        Text(
                                          "Admin",
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: ClanzColors.getSecColor(),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
              Positioned(
                right: 0,
                left: 0,
                bottom: -26,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Bio:",
                        style: TextStyle(
                            color: ClanzColors.getPrimaryColor(),
                            fontStyle: FontStyle.normal,
                            fontSize: 25.0),
                      ),
                      SizedBox(
                        height: height / 50,
                      ),
                      Text(
                        'My name is Alice and I am  a freelance mobile app developper.\n'
                        'if you need any mobile app for your company then contact me for more informations',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w300,
                          color: ClanzColors.getSecColor(),
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height / 40,
              ),
              Positioned(
                width: width / 2,
                child: RaisedButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    elevation: 0.0,
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [
                              ClanzColors.getPrimaryColor(),
                              ClanzColors.getSecColor()
                            ]),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: 300.0, minHeight: height / 20),
                        alignment: Alignment.center,
                        child: Text(
                          "Contact me",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26.0,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ));
  }
}
