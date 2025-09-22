void main(){
  dynamic valor = "Olá";

  print(valor);

  valor = 123;
  print(valor);
}

//variável dinamica é um tipo especial em dart que permite que a variável mude de tipo durante a execução, ou seja, ela pode ser uma String, depois um int, depois até um list, etc. 

//Embora seja útil em alguns casos, não é recomendado abusar dele, pois pode tornar o código menos seguro e mais dificil de manter.