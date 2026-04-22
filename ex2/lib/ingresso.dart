abstract class Ticket{
  int codigo = 0;
  double _valorBase = 0;

  Ticket(this.codigo);

  void setValorBase(double valorBase){
    if(valorBase > 0){
      _valorBase = valorBase;
    }
    else{
      throw Exception("Ingresso não pode ser gratuito!");
    }
  }

  double get pegarValorBase => _valorBase;

  void taxaConvencional(){
    _valorBase = _valorBase * 1.1;
  }

  Map<String, dynamic> toJson();
}

class IngressoShow extends Ticket{
  String setor = "";

  IngressoShow(this.setor, super.codigo);

  @override
  Map<String, dynamic> toJson(){
    return {
      "codigo" : codigo,
      "valor base" : pegarValorBase,
      "setor" : setor
    };
  }
}