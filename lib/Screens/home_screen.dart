import 'package:flutter/material.dart';
import 'package:mercadinho_app/Tabs/home_tab.dart';
import 'package:mercadinho_app/Tabs/products_tab.dart';
import 'package:mercadinho_app/Tabs/work_tab.dart';

import '../widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children:  [
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 97, 176, 44),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab()
        ),
        Scaffold(
            drawer: CustomDrawer(_pageController),
            body: WorkTab()
        )
      ],
    );
  }
}
