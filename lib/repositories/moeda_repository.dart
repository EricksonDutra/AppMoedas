import 'package:moeda_app/models/moeda.dart';

class MoedaRepository {
  static List<Moeda> tabela = [
    Moeda(
      icone: 'moeda.png',
      nome: 'Bitcoin',
      preco: 40000.22,
      sigla: 'BTC',
    ),
    Moeda(
      icone: 'moeda.png',
      nome: 'Dollar',
      preco: 5.22,
      sigla: 'U\$\$',
    ),
    Moeda(
      icone: 'moeda.png',
      nome: 'moeda',
      preco: 7.25,
      sigla: 'EUR',
    ),
    Moeda(
      icone: 'moeda.png',
      nome: 'Real',
      preco: 1.22,
      sigla: 'R\$',
    ),
  ];
}
