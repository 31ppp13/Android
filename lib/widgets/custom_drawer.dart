import 'package:flutter/material.dart';

import '../tiles/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {

    Widget _buildDrawerBack() => Container(

      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 97, 176, 44),
                Color.fromARGB(255, 129, 138, 132)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          )

      ),
    );

    return Drawer(

      child: Stack(

        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 15.0,
                      left: 0.0,
                      child: Text("RR center",
                        style: TextStyle(fontSize: 34.0, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Olá,",
                            style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          Text("Seja bem vindo",
                            style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Início", pageController, 0),
              DrawerTile(Icons.list, "Produtos", pageController, 1),
              DrawerTile(Icons.architecture, "Obras", pageController, 2),
            ],
          )

        ],
      ),
    );
  }
}
