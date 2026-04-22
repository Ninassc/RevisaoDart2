abstract class Avatar {
  String nome = "";
  String classe = "";
  int _pontosForca = 0;

  Avatar(this.nome, this.classe);

  void setPontos(int pontos){
    if(pontos > 1 && pontos < 20){
      _pontosForca = pontos;
    }
    else{
      throw Exception("Atributo fora do limite permitido (1-20)");
    }
  }

  int get pegarPontosForca => _pontosForca;

  void aplicarFuria(){
    _pontosForca += 5;
  }

  Map<String, dynamic> toJson();

}

class Heroi extends Avatar{
  String armaFavorita = "";

  Heroi(this.armaFavorita, super.nome, super.classe);

  @override
  Map<String, dynamic> toJson(){
    return {
      "nome" : nome,
      "classe" : classe,
      "pontos" : pegarPontosForca,
      "arma favorita" : armaFavorita
    };
  }
}