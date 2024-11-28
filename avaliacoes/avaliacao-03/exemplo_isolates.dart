void main() {
  print('Alencar Júnior'); // Print do meu nome
  print('Executando o exemplo de isolates:');
  startIsolateExample();
}

// Função para executar o exemplo de isolates
void startIsolateExample() async {
  // Código do exemplo do GitHub
  print('Iniciando exemplo...');
  await Future.delayed(Duration(seconds: 1));
  print('Exemplo finalizado.');
}
