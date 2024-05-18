import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'home.dart';

class landing_page extends StatefulWidget {
  const landing_page({super.key});

  @override
  State<landing_page> createState() => _landing_page_state();
}

class _landing_page_state extends State<landing_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            children: [
              Material(
                elevation: 10.0,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0)),
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.7,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(),
                  child: ClipRRect(
                    // borderRadius: BorderRadius.only(
                    //     bottomLeft: Radius.circular(20.0),
                    //     bottomRight: Radius.circular(20.0),
                    //     topLeft: Radius.circular(20.0),
                    //     topRight: Radius.circular(20.0),
                    //     ),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    child: Image.asset(
                      'images/landing_page.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: Text(
                  'All the Trending News All Over The Word You Can Read Here!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: Text(
                  'All the Trending News All Over The Word You Can Read Here. Come and learn more about the World More.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Material(
                  elevation: 10.0,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    width: MediaQuery.of(context).size.width / 1.7,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),
                              maintainState: true,
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Get',
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.5,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' Started',
                              style: TextStyle(
                                color: Colors.yellow,
                                letterSpacing: 1.5,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
