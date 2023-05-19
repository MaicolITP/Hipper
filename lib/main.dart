import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:torch_controller/torch_controller.dart';

void main() {
  TorchController().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hipper App',
      home: appitp(),
    );
  }
}

Future<void> _showSimulatedSearchDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Estas seguro de salir'),
        content: Text('la aplicacion se cerrara'),
        actions: <Widget>[
          TextButton(
            child: Text('Aceptar'),
            onPressed: () {
              //Navigator.of(context).pop();
              SystemNavigator.pop();
            },
          ),
        ],
      );
    },
  );
}

class appitp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(242, 232, 247, 179),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 70,
                        ),
                      ),
                      Text(
                        'Configuración',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Image.asset(
              //  "assets/logo.png",
              //  height: 40.0,
              //),
              //SizedBox(width: 10.0),
              Text(
                "Hiper App",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Icon(Icons.android),
          Padding(padding: EdgeInsets.symmetric(horizontal: 10.0)),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 3,
        childAspectRatio:
            2.0, // Ajusta este valor para cambiar el tamaño de los botones
        mainAxisSpacing:
            20, // Ajusta este valor para cambiar el espacio vertical entre los botones
        crossAxisSpacing:
            20, // Ajusta este valor para cambiar el espacio horizontal entre los botones
        padding: const EdgeInsets.all(10),
        children: [
          createButton(
            context,
            'Linterna',
            Icons.flash_on,
            Page1(),
          ),
          createButton(
            context,
            'Calculadora',
            Icons.calculate_outlined,
            Page2(),
          ),
          createButton(
            context,
            'QR',
            Icons.qr_code,
            Page2(),
          ),
          //Agrega más botones aquí
        ],
      ),
    );
  }

  Widget createButton(
      BuildContext context, String name, IconData icon, Widget page) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 80, 177, 206),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 3, 52, 75).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(height: 5),
            Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Page1 extends StatelessWidget {
  var isActive = false;
  var controller = TorchController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Linterna'),
      ),
      body: Center(
        child: CircleAvatar(
          minRadius: 26,
          maxRadius: 26,
          child: Transform.scale(
            scale: 1.5,
            child: IconButton(
              onPressed: () {
                controller.toggle();
                isActive = !isActive;
              },
              icon: const Icon(Icons.power_settings_new),
            ),
          ),
        ),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  double firstNumber = 0;
  double secondNumber = 0;
  double result = 0;
  final TextEditingController t1 = TextEditingController(text: "0");
  final TextEditingController t2 = TextEditingController(text: "0");

  void add() {
    setState(() {
      firstNumber = double.parse(t1.text);
      secondNumber = double.parse(t2.text);
      result = firstNumber + secondNumber;
    });
  }

  void subtract() {
    setState(() {
      firstNumber = double.parse(t1.text);
      secondNumber = double.parse(t2.text);
      result = firstNumber - secondNumber;
    });
  }

  void multiply() {
    setState(() {
      firstNumber = double.parse(t1.text);
      secondNumber = double.parse(t2.text);
      result = firstNumber * secondNumber;
    });
  }

  void divide() {
    setState(() {
      firstNumber = double.parse(t1.text);
      secondNumber = double.parse(t2.text);
      result = firstNumber / secondNumber;
    });
  }

  void clear() {
    setState(() {
      t1.text = "0";
      t2.text = "0";
      result = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Resultado: $result",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: t1,
              decoration: InputDecoration(hintText: 'Ingrese el primer número'),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: t2,
              decoration:
                  InputDecoration(hintText: 'Ingrese el segundo número'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(onPressed: add, child: Text('+')),
                ElevatedButton(onPressed: subtract, child: Text('-')),
                ElevatedButton(onPressed: multiply, child: Text('*')),
                ElevatedButton(onPressed: divide, child: Text('/')),
              ],
            ),
            SizedBox(height: 20.0), //Espacio entre botones (20 pixeles
            ElevatedButton(
                onPressed: clear, child: Text('Limpiar')), //Botón de limpiar
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> buttons = [
  {'name': 'Linterna', 'icon': Icons.flash_on},
  {'name': 'Música', 'icon': Icons.music_note},
  {'name': 'Cámara', 'icon': Icons.camera_alt},
];

class ButtonPage extends StatelessWidget {
  const ButtonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Botones'),
        backgroundColor: Colors.black,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(buttons.length, (index) {
          return Center(
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BotonesPage()),
                );
                // Navegar a la página correspondiente
                // en base al índice del botón
              },
              icon: Icon(buttons[index]['icon']),
              label: Text(buttons[index]['name']),
            ),
          );
        }),
      ),
    );
  }
}

class BotonesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Botones'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          BotonConIcono(
            icono: Icons.lightbulb_outline,
            texto: 'Linterna',
          ),
          BotonConIcono(
            icono: Icons.music_note,
            texto: 'Música',
          ),
          BotonConIcono(
            icono: Icons.camera_alt,
            texto: 'Cámara',
          ),
          BotonConIcono(
            icono: Icons.calendar_today,
            texto: 'Calendario',
          ),
          BotonConIcono(
            icono: Icons.email,
            texto: 'Correo',
          ),
        ],
      ),
    );
  }
}

class BotonConIcono extends StatelessWidget {
  final IconData icono;
  final String texto;

  BotonConIcono({required this.icono, required this.texto});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icono),
          SizedBox(height: 8),
          Text(texto),
        ],
      ),
    );
  }
}
