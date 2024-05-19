import 'package:flutter/material.dart';
import 'package:panelizer/panelizer.dart';

void main() {
  runApp(const AppWrapper());
}

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) => const PanelizerWindow(
        left: [
          PanelizerTile(
            title: 'Tile 1',
            child: Center(child: Text('Tile 1 content')),
          ),
          PanelizerTile(
            title: 'Tile 2',
            child: Center(child: Text('Tile 2 content')),
          ),
        ],
        right: [
          PanelizerTile(
            title: 'Tile 3',
            child: Center(child: Text('Tile 3 content')),
          ),
        ],
        bottom: [
          PanelizerTile(
            title: 'Tile 4',
            child: Center(child: Text('Tile 4 content')),
          ),
          PanelizerTile(
            title: 'Tile 5',
            child: Center(child: Text('Tile 5 content')),
          ),
        ],
        content: MyApp(),
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
}
