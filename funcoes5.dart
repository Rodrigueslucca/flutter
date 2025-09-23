//Funções anônimas

void main() {
  var lista = [1, 2, 3];

  lista.forEach((n) {
    print("Número: $n");
  });

  //Arrow Function
  lista.forEach((n) => print("Dobro ${n * 2}"));
}
