import 'package:flutter/material.dart';
import 'package:nirogi/src/bloc/change_theme_bloc.dart';
import 'package:nirogi/src/themes/themes.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 135,
            child: DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    changeThemeBloc.currentState.themeData == kDarkTheme
                        ? 'assets/images/logos/brand-logo-light.png'
                        : 'assets/images/logos/brand-logo-dark.png',
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: <Widget>[
              buildListTile(context, "Home", "assets/images/icons/home.png"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  height: 10,
                  color: Colors.blueGrey[900].withOpacity(0.3),
                ),
              ),
              buildListTile(
                  context, "Diseasaes", "assets/images/icons/disease.png"),
              buildListTile(
                  context, "Symptoms", "assets/images/icons/symptoms.png"),
              buildListTile(
                  context, "Health News", "assets/images/icons/news.png"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  height: 10,
                  color: Colors.blueGrey[900].withOpacity(0.3),
                ),
              ),
              buildListTile(
                  context, "About Us", "assets/images/icons/about.png"),
              buildListTile(
                  context, "Contact Us", "assets/images/icons/contact.png"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  height: 10,
                  color: Colors.blueGrey[900].withOpacity(0.3),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: <Widget>[
                  Text('Theme', style: Theme.of(context).textTheme.body1),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: changeThemeBloc.onLightThemeChange,
                        child: Stack(
                          overflow: Overflow.clip,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xff323639),
                                      blurRadius: 2.0,
                                      spreadRadius: 2.0,
                                    )
                                  ]),
                              height: 60,
                              width: 60,
                            ),
                            changeThemeBloc.currentState.themeData ==
                                    kLightTheme
                                ? Positioned(
                                    top: 10,
                                    left: 10,
                                    right: 10,
                                    bottom: 10,
                                    child: Image.asset(
                                      'assets/images/icons/check.png',
                                      color: Color(0xff323639),
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      GestureDetector(
                        onTap: changeThemeBloc.onDarkThemeChange,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xff323639),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white,
                                      blurRadius: 2.0,
                                      spreadRadius: 2.0,
                                    )
                                  ]),
                              height: 60,
                              width: 60,
                            ),
                            changeThemeBloc.currentState.themeData == kDarkTheme
                                ? Positioned(
                                    top: 10,
                                    left: 10,
                                    right: 10,
                                    bottom: 10,
                                    child: Image.asset(
                                      'assets/images/icons/check.png',
                                      color: Colors.white,
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  ListTile buildListTile(BuildContext context, String name, String imgUrl) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 30),
      leading: Image.asset(
        imgUrl,
        width: 35,
      ),
      title: Text(
        name,
        style: Theme.of(context).textTheme.body1,
      ),
    );
  }
}
