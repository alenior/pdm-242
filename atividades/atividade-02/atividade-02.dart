import 'dart:convert';

class Dependente {
  late String _nome;

  Dependente(this._nome);

  Map<String, dynamic> toJson() {
    return {
      'nome': _nome,
    };
  }
}

class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(this._nome, this._dependentes);

  Map<String, dynamic> toJson() {
    return {
      'nome': _nome,
      'dependentes': _dependentes.map((dep) => dep.toJson()).toList(),
    };
  }
}

class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(this._nomeProjeto, this._funcionarios);

  Map<String, dynamic> toJson() {
    return {
      'nomeProjeto': _nomeProjeto,
      'funcionarios': _funcionarios.map((func) => func.toJson()).toList(),
    };
  }
}

void main() {
  // Passo 1: Criar objetos Dependente
  var dependente1 = Dependente("Ana");
  var dependente2 = Dependente("Carlos");
  var dependente3 = Dependente("Julia");
  var dependente4 = Dependente("Lucas");

  // Passo 2: Criar objetos Funcionario com dependentes associados
  var funcionario1 = Funcionario("João", [dependente1, dependente2]);
  var funcionario2 = Funcionario("Maria", [dependente3]);
  var funcionario3 = Funcionario("Pedro", [dependente4]);

  // Passo 4: Criar uma lista de Funcionarios
  var listaFuncionarios = [funcionario1, funcionario2, funcionario3];

  // Passo 5: Criar o objeto EquipeProjeto
  var equipeProjeto = EquipeProjeto("Projeto Alpha", listaFuncionarios);

  // Passo 6: Printar no formato JSON o objeto EquipeProjeto
  var jsonEquipeProjeto = jsonEncode(equipeProjeto.toJson());
  print(jsonEquipeProjeto);
}
