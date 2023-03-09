import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moeda_app/repositories/moeda_repository.dart';

import '../models/moeda.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({super.key});

  @override
  State<MoedasPage> createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  final tabela = MoedaRepository.tabela;
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  List<Moeda> select = [];

  appBarDinamica() {
    if (select.isEmpty) {
      return AppBar(
        title: const Center(
          child: Text('App Moedas'),
        ),
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              select = [];
            });
          },
        ),
        title: Center(
            child: Text(
          '${select.length} selecionadas',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        )),
        backgroundColor: Colors.purple[50],
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black87),
        foregroundColor: Colors.black87,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDinamica(),
      body: Center(
        child: ListView.separated(
          itemBuilder: (BuildContext context, int moeda) {
            return ListTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                leading: select.contains(tabela[moeda])
                    ? const Icon(Icons.money_off_outlined)
                    : const CircleAvatar(
                        child: Icon(
                          Icons.arrow_back,
                        ),
                      ),
                title: Text(tabela[moeda].nome,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w500)),
                trailing: Text(real.format(tabela[moeda].preco)),
                selected: select.contains(tabela[moeda]),
                selectedTileColor: Colors.purple[50],
                onTap: () {
                  setState(() {
                    (select.contains(tabela[moeda]))
                        ? select.remove(tabela[moeda])
                        : select.add(tabela[moeda]);
                  });
                });
          },
          padding: const EdgeInsets.all(16),
          separatorBuilder: (_, __) => const Divider(),
          itemCount: tabela.length,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: select.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {},
              icon: const Icon(Icons.star),
              label: const Text(
                'Favoritar',
                style: TextStyle(
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
    );
  }
}
