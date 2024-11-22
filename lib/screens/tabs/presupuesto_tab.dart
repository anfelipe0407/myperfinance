import 'package:flutter/material.dart';
import 'package:myperfinance/controllers/presupuesto.controller.dart';
import 'package:myperfinance/models/transaction.model.dart';
import 'package:provider/provider.dart';

class PresupuestoTab extends StatefulWidget {
  @override
  _PresupuestoTabState createState() => _PresupuestoTabState();
}

class _PresupuestoTabState extends State<PresupuestoTab> {
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController montoController = TextEditingController();
  String frecuencia = 'mensual';
  String tipoTransaccion = 'ingreso'; // 'ingreso' o 'gasto'
  int? diaSeleccionado;
  bool mostrarFormulario = false; // Controla la visibilidad del formulario

  @override
  Widget build(BuildContext context) {
    final presupuestoController = Provider.of<PresupuestoController>(context);

    // Calcular balance total
    double balanceTotal = presupuestoController.transacciones.fold(
      0.0,
      (prev, transaccion) => transaccion.tipo == 'ingreso'
          ? prev + transaccion.monto
          : prev - transaccion.monto,
    );

    // Validar si el botón debe estar deshabilitado
    bool botonGuardarDeshabilitado = tipoTransaccion == 'gasto' &&
        (double.tryParse(montoController.text) ?? 0) > balanceTotal;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Mostrar balance total
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.attach_money, color: Colors.green, size: 24),
              Text(
                balanceTotal.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: balanceTotal >= 0 ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Botón "Agregar Movimiento"
          ElevatedButton(
            onPressed: () {
              setState(() {
                mostrarFormulario = true;
              });
            },
            child: const Text('Agregar Movimiento'),
          ),

          // Formulario para agregar movimiento
          if (mostrarFormulario)
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Botón cerrar
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          mostrarFormulario = false;
                        });
                      },
                      child: const Icon(Icons.close, color: Colors.red),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Campos de descripción y monto
                  TextField(
                    controller: descripcionController,
                    decoration: InputDecoration(labelText: 'Descripción'),
                  ),
                  TextField(
                    controller: montoController,
                    decoration: InputDecoration(labelText: 'Monto'),
                    keyboardType: TextInputType.number,
                    onChanged: (_) {
                      setState(() {}); // Actualizar estado al cambiar el monto
                    },
                  ),
                  const SizedBox(height: 10),

                  // Radio buttons para tipo de transacción
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio<String>(
                        value: 'ingreso',
                        groupValue: tipoTransaccion,
                        onChanged: (value) {
                          setState(() {
                            tipoTransaccion = value!;
                          });
                        },
                      ),
                      const Text('Ingreso'),
                      Radio<String>(
                        value: 'gasto',
                        groupValue: tipoTransaccion,
                        onChanged: (value) {
                          setState(() {
                            tipoTransaccion = value!;
                          });
                        },
                      ),
                      const Text('Gasto'),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Dropdown para frecuencia
                  DropdownButton<String>(
                    value: frecuencia,
                    items: ['mensual', 'semanal', 'casual']
                        .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        frecuencia = value!;
                        diaSeleccionado = null; // Resetear selección de día
                      });
                    },
                  ),

                  // Campo adicional dependiendo de la frecuencia
                  if (frecuencia == 'mensual') ...[
                    const SizedBox(height: 10),
                    DropdownButton<int>(
                      value: diaSeleccionado,
                      hint: const Text('Seleccione el día del mes'),
                      items: List.generate(
                        28,
                        (index) => DropdownMenuItem(
                          value: index + 1,
                          child: Text('Día ${index + 1}'),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          diaSeleccionado = value;
                        });
                      },
                    ),
                  ] else if (frecuencia == 'semanal') ...[
                    const SizedBox(height: 10),
                    DropdownButton<String>(
                      value: diaSeleccionado != null
                          ? ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo']
                              [diaSeleccionado!]
                          : null,
                      hint: const Text('Seleccione el día de la semana'),
                      items: ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo']
                          .asMap()
                          .entries
                          .map((entry) => DropdownMenuItem(
                                value: entry.value,
                                child: Text(entry.value),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          diaSeleccionado = [
                            'Lunes',
                            'Martes',
                            'Miércoles',
                            'Jueves',
                            'Viernes',
                            'Sábado',
                            'Domingo'
                          ].indexOf(value!);
                      });
                    }),
                  ],
                  const SizedBox(height: 20),

                  // Botón para guardar transacción
                  ElevatedButton(
                    onPressed: botonGuardarDeshabilitado
                        ? null // Deshabilitar si el monto supera el balance
                        : () {
                            presupuestoController.agregarTransaccion(
                              Transaccion(
                                tipo: tipoTransaccion,
                                descripcion: descripcionController.text,
                                monto: double.tryParse(montoController.text) ?? 0,
                                frecuencia: frecuencia,
                                dia: diaSeleccionado,
                              ),
                            );

                            descripcionController.clear();
                            montoController.clear();
                            setState(() {
                              frecuencia = 'mensual';
                              diaSeleccionado = null;
                              tipoTransaccion = 'ingreso';
                              mostrarFormulario = false; // Ocultar formulario
                            });
                          },
                    child: const Text('Guardar'),
                  ),

                  // Mensaje de error si el monto supera el balance
                  if (botonGuardarDeshabilitado)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'El gasto no puede superar el balance disponible.',
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ),
                ],
              ),
            ),

          // Lista de transacciones
          Expanded(
            child: ListView.builder(
              itemCount: presupuestoController.transacciones.length,
              itemBuilder: (context, index) {
                final transaccion = presupuestoController.transacciones[index];
                return ListTile(
                  title: Text(transaccion.descripcion),
                  subtitle: Text(
                      '${transaccion.monto} - ${transaccion.frecuencia} - Día: ${transaccion.dia ?? 'N/A'}'),
                  trailing: Text(
                    transaccion.tipo == 'ingreso' ? '+${transaccion.monto}' : '-${transaccion.monto}',
                    style: TextStyle(
                      color: transaccion.tipo == 'ingreso' ? Colors.green : Colors.red,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
