import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Money Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Mi Calculadora de Moneda'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

final datosIngresados = TextEditingController();
final resultado = TextEditingController();
String datoinicial = "COP";
String datofinal = "USD";

List<DropdownMenuItem<String>> listaMoneda = <DropdownMenuItem<String>>[
  DropdownMenuItem(value: "USD", child: Text("USD")),
  DropdownMenuItem(value: "EUR", child: Text("EUR")),
  DropdownMenuItem(value: "COP", child: Text("COP")),
];

class calculadora {
  final titulo;
  final color;
  final icono;

  calculadora(this.titulo, this.color, this.icono);
}

List<calculadora> calculator = <calculadora>[
  calculadora("7", Color.fromARGB(255, 111, 232, 222), Icon(Icons.abc)),
  calculadora("8", Color.fromARGB(255, 111, 232, 222), Icon(Icons.abc)),
  calculadora("9", Color.fromARGB(255, 111, 232, 222), Icon(Icons.abc)),
  calculadora("4", Color.fromARGB(255, 111, 232, 222), Icon(Icons.abc)),
  calculadora("5", Color.fromARGB(255, 111, 232, 222), Icon(Icons.abc)),
  calculadora("6", Color.fromARGB(255, 111, 232, 222), Icon(Icons.abc)),
  calculadora("1", Color.fromARGB(255, 111, 232, 222), Icon(Icons.abc)),
  calculadora("2", Color.fromARGB(255, 111, 232, 222), Icon(Icons.abc)),
  calculadora("3", Color.fromARGB(255, 111, 232, 222), Icon(Icons.abc)),
  calculadora("0", Color.fromARGB(255, 111, 232, 222), Icon(Icons.abc)),
  calculadora("Clean", Color.fromARGB(255, 111, 232, 222),
      Icon(Icons.cleaning_services_sharp)),
  calculadora("=", Color.fromARGB(255, 111, 232, 222), Icon(Icons.abc)),
];

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              children: [
                Text("Moneda Origen : "),
                DropdownButton(
                    value: datoinicial,
                    items: listaMoneda,
                    onChanged: (String? x) {
                      setState(() {
                        datoinicial = x.toString();
                      });
                    }),
                Text("Moneda Destino : "),
                DropdownButton(
                    value: datofinal,
                    items: listaMoneda,
                    onChanged: (String? x) {
                      setState(() {
                        datofinal = x.toString();
                      });
                    }),
              ],
            ),
            TextField(
              controller: datosIngresados,
              decoration: InputDecoration(
                  labelText: "Moneda Origen",
                  hintText: "0",
                  icon: Icon(Icons.monetization_on)),
            ),
            TextField(
                controller: resultado,
                decoration: InputDecoration(
                    labelText: "Moneda Final",
                    hintText: "0",
                    icon: Icon(Icons.monetization_on))),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: calculator.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: calculator[index].color,
                    child: ListTile(
                      title: Center(
                        child: index == 10
                            ? calculator[index].icono
                            : Text(
                                calculator[index].titulo,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 35),
                              ),
                      ),
                      onTap: () {
                        if (index < 10) {
                          datosIngresados.text =
                              datosIngresados.text + calculator[index].titulo;
                        } else if (index == 10) {
                          datosIngresados.clear(); // limpiando opción 1
                          //datosIngresados.text = " ";   // limpiando opción 1
                          resultado.clear();
                        } else {
                          if (datoinicial == "USD" && datofinal == "COP") {
                            resultado.text =
                                (double.parse(datosIngresados.text) * 5100)
                                    .toString();
                          } else if (datoinicial == "COP" &&
                              datofinal == "USD") {
                            resultado.text =
                                (double.parse(datosIngresados.text) / 5100)
                                    .toString();
                          } else if (datoinicial == "EUR" &&
                              datofinal == "COP") {
                            resultado.text =
                                (double.parse(datosIngresados.text) * 4930)
                                    .toString();
                          } else if (datoinicial == "COP" &&
                              datofinal == "EUR") {
                            resultado.text =
                                (double.parse(datosIngresados.text) / 4930)
                                    .toString();
                          } else if (datoinicial == "USD" &&
                              datofinal == "EUR") {
                            resultado.text =
                                (double.parse(datosIngresados.text) * 1.03)
                                    .toString();
                          } else if (datoinicial == "EUR" &&
                              datofinal == "USD") {
                            resultado.text =
                                (double.parse(datosIngresados.text) / 1.03)
                                    .toString();
                          } else {
                            resultado.text = datosIngresados.text;
                          }
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
