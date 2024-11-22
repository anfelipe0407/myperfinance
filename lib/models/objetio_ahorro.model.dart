class ObjetivoAhorro {
  final String descripcion;
  final double montoObjetivo;
  final double montoActual;

  ObjetivoAhorro({
    required this.descripcion,
    required this.montoObjetivo,
    this.montoActual = 0.0,
  });
}
