import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Inventarios',
      home: const PantallaPrincipal(),
    );
  }
}

class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Botones arriba
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Acción para leer código
                    },
                    child: const Text('Leer código'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Acción para limpiar datos
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                    ),
                    child: const Text('Limpiar'),
                  ),
                ],
              ),
            ),

            // 🔹 Cuadrícula 3x3 editable
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  crossAxisCount: 3, // 3 columnas
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: [
                    // 🔸 Cada bloque puedes editarlo a tu gusto
                    _buildBloque('UID:', 'N/A'),
                    _buildBloque('NUMERO DE LOTE:', 'N/A'),
                    _buildBloque('NOMBRE DEL REACTIVO:', 'N/A'),
                    _buildBloque('FECHA DE VENCIMIENTO:', 'N/A'),
                    _buildBloque('FECHA Y HORA DE REGISTRO:', 'N/A'),
                    _buildBloque('FECHA DE USO:', 'N/A'),
                    _buildBloque('FECHA HORA TERMINADO:', 'N/A'),
                    _buildBloque('REFRIGERADOR ACTUAL:', 'N/A'),
                    _buildBloque('ESTADO:', 'N/A'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Widget reutilizable para los bloques
  Widget _buildBloque(String titulo, String valor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black26),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              titulo,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              valor,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
