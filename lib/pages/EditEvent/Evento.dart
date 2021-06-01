class Evento {
  final String nome;
  final String dia;
  final String hora;
  final String local;
  final String tipo;
  final String idOrganizador;
  final String imagem;
  final dynamic eventoRef;
  final String id;

  const Evento({
    this.id = '',
    this.nome = "",
    this.dia = "",
    this.hora = "",
    this.local = "",
    this.tipo = "",
    this.idOrganizador = "",
    this.imagem = "",
    this.eventoRef,
  });
}
