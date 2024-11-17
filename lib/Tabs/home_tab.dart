import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {

    Widget _buildBodyBack() => Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 97, 176, 44),
            Color.fromARGB(255, 129, 138, 132)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        )
      ),
    );

    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("Serviços",
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
              ),
                iconTheme: IconThemeData(color: Colors.white)
            ),
            FutureBuilder<QuerySnapshot>(
                future: getData(),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return SliverToBoxAdapter(
                      child: Container(
                        height: 200.0,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          valueColor:AlwaysStoppedAnimation<Color>(Colors.white)
                        ),
                      ),
                    );
                  }else {
                    return SliverStaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 1.0,
                      staggeredTiles: (snapshot.data as QuerySnapshot).docs.map(
                          (doc){
                            return StaggeredTile.count(doc["x"], double.tryParse(doc["y"].toString()));
                          }
                      ).toList(),
                      children: (snapshot.data as QuerySnapshot).docs.map(
                        (doc) {
                          return Padding(
                            padding: EdgeInsets.only(top: doc["pos"] == 0 ? 20.0 : 0.0),
                            child: Stack(children: [

                              Container(
                                child: Image.network(
                                  doc["image"],
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  color: Colors.black.withOpacity(0.5),
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    doc["name"],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                      decoration: TextDecoration.none
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          );
                        },
                      ).toList(),

                    );
                  }
                },
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 100.0),
                child: Column(
                  children: [
                    Text(
                      "Faça seu orçamento",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.instagram, color: Colors.pink, size: 30.0),
                        SizedBox(width: 8.0),
                        Text(
                          "@rrengenharia20",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            decoration: TextDecoration.none
                          ),
                        ),
                        SizedBox(width: 20.0),

                        FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green, size: 30.0),
                        SizedBox(width: 8.0),
                        Text(
                          "+55 85 8991-5316",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            decoration: TextDecoration.none
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

Future<QuerySnapshot> getData() async {
  await Firebase.initializeApp();
  return await FirebaseFirestore.instance.collection("home").orderBy("pos").get();
}