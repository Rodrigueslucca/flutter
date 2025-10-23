class Bebida {
  final int? id;
  final String nome;
  final double valor;
  final String imagem;

  Bebida({
    required this.id,
    required this.nome,
    required this.valor,
    required this.imagem,
  });

  factory Bebida.fromJson(Map<String, dynamic> json) {
    return Bebida(
      id: json['id'],
      nome: json['nome'],
      valor: json['valor'].toDouble(),
      imagem: json['imagem'],
    );
  }
}
