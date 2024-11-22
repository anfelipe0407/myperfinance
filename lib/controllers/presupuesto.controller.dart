import 'package:flutter/material.dart';
import 'package:myperfinance/models/objetio_ahorro.model.dart';
import 'package:myperfinance/models/transaction.model.dart';

class PresupuestoController with ChangeNotifier {
  List<Transaccion> _transacciones = [];
  List<ObjetivoAhorro> _objetivos = [];

  List<Transaccion> get transacciones => _transacciones;
  List<ObjetivoAhorro> get objetivos => _objetivos;

  void agregarTransaccion(Transaccion transaccion) {
    _transacciones.add(transaccion);
    notifyListeners();
  }

  void agregarObjetivo(ObjetivoAhorro objetivo) {
    _objetivos.add(objetivo);
    notifyListeners();
  }
}
