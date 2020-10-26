import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _a = 0;
  int _b = 0;
  int _sum = 0;

  Future<void> _callSum() async {
    /*
    Esse é o canal de comunicação com o pacote nativo
    existe um padrão para realizar essa chamada

    <domínio>/<channel>
    */
    const channel = MethodChannel('lucas.biancogs.com.br/nativo');

    try {
      // Jeito de passar parâmetros para o método invocado
      // Espero então a resposta (toda execução é feita de forma assíncrona)
      final sum = await channel.invokeMethod('calcSum', {"a": _a, "b": _b});

      setState(() {
        _sum = sum;
      });
    } on PlatformException {
      setState(() {
        _sum = 0;
      });
    }

    setState(() {
      _sum = _a + _b;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nativo'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                'Soma: ${_sum}',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) => setState(() {
                  _a = int.tryParse(value) ?? 0;
                }),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) => setState(() {
                  _b = int.tryParse(value) ?? 0;
                }),
              ),
              SizedBox(height: 10),
              RaisedButton(
                onPressed: _callSum,
                child: Text('Somar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
