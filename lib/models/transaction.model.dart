class Transaccion {
  final String tipo; // 'ingreso' o 'gasto'
  final String descripcion;
  final double monto;
  final String frecuencia; // 'mensual', 'semanal', 'casual'
  final int? dia; // 'mensual', 'semanal', 'casual'
  final int? diaMes; // Solo para mensual
  final String? diaSemana; // Solo para semanal
  final DateTime? fecha; // Solo para casual

  Transaccion({
    required this.tipo,
    required this.descripcion,
    required this.monto,
    required this.frecuencia,
    this.dia,
    this.diaMes,
    this.diaSemana,
    this.fecha,
  });
}
