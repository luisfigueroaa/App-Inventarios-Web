import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // 👈 Para decodificar JSON

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Inventarios',
      home: PantallaPrincipal(),
    );
  }
}

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  // Variables que se muestran debajo de cada bloque
  String uid = 'N/A';
  String lote = 'N/A';
  String nombre = 'N/A';
  String vencimiento = 'N/A';
  String registro = 'N/A';
  String uso = 'N/A';
  String terminado = 'N/A';
  String refrigerador = 'N/A';
  String estado = 'N/A';

  // URL del Google Apps Script
  final String url =
      'https://script.google.com/macros/s/AKfycbxoBCbXCLD9pvklx68hPdliY1g9sxcThXKZQ4ZdUIfnC9EUW0mfyGWqvsacb2xodNNG/exec?uid=02084316734120293011741725032810LIQ455';

  // 🔹 Leer los datos del JSON
  Future<void> leerDatos() async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          uid = data['UID'] ?? 'N/A';
          lote = data['Nro de Lote']?.toString() ?? 'N/A';
        });
      } else {
        setState(() {
          uid = 'Error HTTP ${response.statusCode}';
          lote = 'Error HTTP ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        uid = 'Error: $e';
        lote = 'Error: $e';
      });
    }
  }

  void limpiarCampos() {
    setState(() {
      uid = lote = nombre = vencimiento = registro = uso = terminado = refrigerador = estado = 'N/A';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Botones superiores
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: leerDatos,
                    child: const Text('LEER CÓDIGO'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: limpiarCampos,
                    child: const Text('LIMPIAR'),
                  ),
                ],
              ),
            ),

            // 🔹 Cuadrícula 3x3
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: [
                    _buildBloque('UID:', uid),
                    _buildBloque('NUMERO DE LOTE:', lote), // 👈 ahora se llena también
                    _buildBloque('NOMBRE DEL REACTIVO:', nombre),
                    _buildBloque('FECHA DE VENCIMIENTO:', vencimiento),
                    _buildBloque('FECHA Y HORA DE REGISTRO:', registro),
                    _buildBloque('FECHA DE USO:', uso),
                    _buildBloque('FECHA HORA TERMINADO:', terminado),
                    _buildBloque('REFRIGERADOR ACTUAL:', refrigerador),
                    _buildBloque('ESTADO:', estado),
                  ],
                ),
              ),
            ),

            // 🔹 Texto inferior
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'ACTUALIZAR DATOS:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            // 🔹 Botones inferiores
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Acción GUARDAR
                    },
                    child: const Text('GUARDAR'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Acción ENVIAR
                    },
                    child: const Text('ENVIAR'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Bloque reutilizable
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
