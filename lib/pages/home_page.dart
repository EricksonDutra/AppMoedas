import 'package:flutter/material.dart';
import 'package:moeda_app/pages/moedas_page.dart';

import 'favoritas_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pagAtual = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: pagAtual);
  }

  setPagAtual(pagina) {
    setState(() {
      pagAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        onPageChanged: setPagAtual,
        children: const [
          MoedasPage(),
          FavoritasPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pagAtual,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'todas'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'favoritas')
        ],
        onTap: (pag) => pc.animateToPage(
          pag,
          duration: const Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        backgroundColor: Colors.grey[100],
      ),
    );
  }
}
