import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moeda_app/configs/app_settings.dart';
import 'package:moeda_app/pages/moedas_detalhes_page.dart';
import 'package:moeda_app/repositories/favoritas_repository.dart';
import 'package:moeda_app/repositories/moeda_repository.dart';
import 'package:provider/provider.dart';

import '../models/moeda.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({super.key});

  @override
  State<MoedasPage> createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  final tabela = MoedaRepository.tabela;
  late NumberFormat real;
  late Map<String, String> loc;
  List<Moeda> select = [];
  late FavoritasRepository favoritas;

  readNumberFormat() {
    loc = context.watch<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
  }

  changeLanguageButton() {
    final locale = loc['locale'] == 'pt_BR' ? 'en_US' : 'pt_BR';
    final name = loc['locale'] == 'pt_BR' ? '\$' : 'R\$';

    return PopupMenuButton(
        icon: const Icon(Icons.language),
        itemBuilder: (context) => [
              PopupMenuItem(
                  child: ListTile(
                leading: const Icon(Icons.swap_vert),
                title: Text('Usar $locale'),
                onTap: () {
                  context.read<AppSettings>().setLocale(locale, name);
                  Navigator.pop(context);
                },
              ))
            ]);
  }

  appBarDinamica() {
    if (select.isEmpty) {
      return AppBar(
        title: const Center(
          child: Text('App Moedas'),
        ),
        actions: [
          changeLanguageButton(),
        ],
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

  mostrarDetalhes(Moeda moeda) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MoedasDetalhesPage(moeda: moeda),
      ),
    );
  }

  limparSelecionadas() {
    setState(() {
      select = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    // favoritas = Provider.of<FavoritasRepository>(context);
    favoritas = context.watch<FavoritasRepository>();
    readNumberFormat();
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
              title: Row(
                children: [
                  Text(
                    tabela[moeda].nome,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (favoritas.lista
                      .any((fav) => fav.sigla == tabela[moeda].sigla))
                    const Icon(Icons.star_border_purple500,
                        color: Colors.purpleAccent, size: 8)
                ],
              ),
              trailing: Text(real.format(tabela[moeda].preco)),
              selected: select.contains(tabela[moeda]),
              selectedTileColor: Colors.purple[50],
              onLongPress: () {
                setState(() {
                  (select.contains(tabela[moeda]))
                      ? select.remove(tabela[moeda])
                      : select.add(tabela[moeda]);
                });
              },
              onTap: () => mostrarDetalhes(tabela[moeda]),
            );
          },
          padding: const EdgeInsets.all(16),
          separatorBuilder: (_, __) => const Divider(),
          itemCount: tabela.length,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: select.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                favoritas.saveAll(select);
                limparSelecionadas();
              },
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
