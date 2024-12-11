import 'package:sqlite3/sqlite3.dart';

class Aluno {
  int? id;
  String nome;
  String dataNascimento;

  Aluno({this.id, required this.nome, required this.dataNascimento});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'data_nascimento': dataNascimento,
    };
  }

  @override
  String toString() {
    return 'Aluno(id: $id, nome: $nome, dataNascimento: $dataNascimento)';
  }
}

class AlunoDatabase {
  final database = sqlite3.open('aluno.db');

  AlunoDatabase() {
    _createTable();
  }

  void _createTable() {
    database.execute('''
      CREATE TABLE IF NOT EXISTS TB_ALUNOS (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        data_nascimento TEXT NOT NULL
      )
    ''');
  }

  void insertAluno(Aluno aluno) {
    final stmt = database.prepare(
      'INSERT INTO TB_ALUNOS (nome, data_nascimento) VALUES (?, ?)',
    );
    stmt.execute([aluno.nome, aluno.dataNascimento]);
    stmt.dispose();
  }

  Aluno? getAluno(int id) {
    final stmt = database.prepare('SELECT * FROM TB_ALUNOS WHERE id = ?');
    final result = stmt.select([id]);

    if (result.isEmpty) return null;

    final row = result.first;
    stmt.dispose();

    return Aluno(
      id: row['id'] as int,
      nome: row['nome'] as String,
      dataNascimento: row['data_nascimento'] as String,
    );
  }

  List<Aluno> getAllAlunos() {
    final result = database.select('SELECT * FROM TB_ALUNOS');
    return result.map((row) {
      return Aluno(
        id: row['id'] as int,
        nome: row['nome'] as String,
        dataNascimento: row['data_nascimento'] as String,
      );
    }).toList();
  }

  void updateAluno(Aluno aluno) {
    final stmt = database.prepare(
      'UPDATE TB_ALUNOS SET nome = ?, data_nascimento = ? WHERE id = ?',
    );
    stmt.execute([aluno.nome, aluno.dataNascimento, aluno.id]);
    stmt.dispose();
  }

  void deleteAluno(int id) {
    final stmt = database.prepare('DELETE FROM TB_ALUNOS WHERE id = ?');
    stmt.execute([id]);
    stmt.dispose();
  }

  void close() {
    database.dispose();
  }
}

void main() {
  final db = AlunoDatabase();

  // Inserir alunos
  db.insertAluno(Aluno(nome: 'João', dataNascimento: '2000-01-01'));
  db.insertAluno(Aluno(nome: 'Maria', dataNascimento: '1995-07-15'));

  // Buscar todos os alunos
  print('Todos os alunos:');
  final alunos = db.getAllAlunos();
  for (var aluno in alunos) {
    print(aluno);
  }

  // Buscar um aluno pelo ID
  print('\nBuscar aluno com ID 1:');
  final aluno = db.getAluno(1);
  if (aluno != null) {
    print(aluno);
  } else {
    print('Aluno não encontrado.');
  }

  // Atualizar um aluno
  print('\nAtualizando aluno com ID 1:');
  db.updateAluno(Aluno(id: 1, nome: 'João Atualizado', dataNascimento: '2000-01-01'));
  print(db.getAluno(1));

  // Deletar um aluno
  print('\nDeletando aluno com ID 2:');
  db.deleteAluno(2);

  // Exibir todos os alunos novamente
  print('\nTodos os alunos após deleção:');
  final alunosRestantes = db.getAllAlunos();
  for (var aluno in alunosRestantes) {
    print(aluno);
  }

  db.close();
}
