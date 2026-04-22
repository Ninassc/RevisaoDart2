import 'dart:convert';
import 'dart:io';
import '../lib/ingresso.dart';

void salvarDados(List<IngressoShow> carregarIngressos) {
  final arquivo = File("./vendas.json");

  List<Map<String, dynamic>> dadosSalvos =
      carregarIngressos.map((dados) => dados.toJson()).toList();

  arquivo.writeAsStringSync(jsonEncode(dadosSalvos));
}

void mostrarIngressos(List<IngressoShow> carregarIngressos) {
  for (var dado in carregarIngressos) {
    print("Código ${dado.codigo}");
    print("Valor Base = ${dado.pegarValorBase}");
    print("Setor = ${dado.setor}");
  }
}

void main(List<String> arguments) {
  try {
    List<IngressoShow> carregarIngressos = [];

    final arquivo = File("./vendas.json");

    if (arquivo.existsSync()) {
      List<dynamic> dados = jsonDecode(arquivo.readAsStringSync());

      for (var dado in dados) {
        int codigo = dado["codigo"];
        String setor = dado["setor"];
        double valorBase = dado["valor base"];

        IngressoShow ingresso = IngressoShow(setor, codigo);
        ingresso.setValorBase(valorBase);

        carregarIngressos.add(ingresso);
      }
    }

    while (true) {
      stdout.write(
          "Digite\n[1] para MOSTRAR VENDAS\n[2] para CADASTRAR\n[3] para SAIR\n--> ");

      int opcao = int.parse(stdin.readLineSync()!);

      switch (opcao) {
        case 1:
          mostrarIngressos(carregarIngressos);
          break;

        case 2:
          stdout.write("Código: ");
          int codigo = int.parse(stdin.readLineSync()!);

          stdout.write("Valor Base: ");
          double valorBase = double.parse(stdin.readLineSync()!);

          stdout.write("Setor: ");
          String setor = stdin.readLineSync()!.toLowerCase();

          IngressoShow ingressoShow = IngressoShow(setor, codigo);
          ingressoShow.setValorBase(valorBase);

          if (setor == "vip") {
            ingressoShow.taxaConvencional();
          }

          carregarIngressos.add(ingressoShow);

          salvarDados(carregarIngressos);
          break;

        case 3:
          return;
      }
    }
  } catch (error) {
    print(error);
  }
}
