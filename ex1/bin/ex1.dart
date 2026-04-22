import 'dart:convert';
import 'dart:io';

import 'package:ex1/personagem.dart';

void salvarDados(List<Heroi> carregarAvatar) {
  final arquivo = File(r"H:\Framework\revisaoparte2\ex1\personagens.json");

  List<Map<String, dynamic>> dadosSalvos =
      carregarAvatar.map((dado) => dado.toJson()).toList();

  arquivo.writeAsStringSync(jsonEncode(dadosSalvos));
}

void mostrarPersonagens(List<Heroi> carregarAvatar) {
  for (var dado in carregarAvatar) {
    String nome = dado.nome;
    String classe = dado.classe;
    int pontos = dado.pegarPontosForca;
    String arma = dado.armaFavorita;

    print("\n");
    print("Nome : $nome");
    print("Classe: $classe");
    print("Pontos de Força: $pontos");
    print("Arma Favorita: $arma");
  }
}

void main(List<String> arguments) {
  try {
    List<Heroi> carregarAvatar = [];

    final arquivo = File(r"H:\Framework\revisaoparte2\ex1\personagens.json");

    if (arquivo.existsSync()) {
      List<dynamic> dados = jsonDecode(arquivo.readAsStringSync());

      for (var dado in dados) {
        String nome = dado["nome"];
        String classe = dado["classe"];
        int pontos = dado["pontos"];
        String arma = dado["arma favorita"];

        Heroi heroi = Heroi(arma, nome, classe);
        heroi.setPontos(pontos);

        carregarAvatar.add(heroi);
      }
    }

    while (true) {
      stdout.write(
          "Digite\n[1] para MOSTRAR PERSONAGENS\n[2] para CADASTRAR PERSONAGEM\n[3] para SAIR\n--> ");
      int opcao = int.parse(stdin.readLineSync()!);

      switch (opcao) {
        case 1:
          mostrarPersonagens(carregarAvatar);
          break;

        case 2:
          print("\n");

          stdout.write("Nome: ");
          String nome = stdin.readLineSync()!;

          stdout.write("Classe: ");
          String classe = stdin.readLineSync()!.toLowerCase();

          stdout.write("Pontos de Força: ");
          int pontos = int.parse(stdin.readLineSync()!);

          stdout.write("Arma Favorita: ");
          String arma = stdin.readLineSync()!;

          Heroi heroi = Heroi(arma, nome, classe);
          heroi.setPontos(pontos);

          if (classe == "orc") {
            heroi.aplicarFuria();
          }

          carregarAvatar.add(heroi);

          salvarDados(carregarAvatar);
          break;

        case 3:
          return;
      }
    }
  } catch (error) {
    print(error);
  }
}
