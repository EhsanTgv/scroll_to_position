import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var fruits = [
    'Apple',
    'Banana',
    'Cherry',
    'Grape',
    'Kiwi',
    'Mango',
    'Orange',
    'Pear',
    'Strawberry',
    'Watermelon',
    'Elderberry',
    'Eggfruit',
    'Evergreen',
    'Huckleberry',
    'Entawak',
    'Grapefruit',
    'Grapes',
    'Gooseberries',
    'Guava',
    'Honeydew',
    'Kumquat',
    'Lemon',
    'Lime',
    'Lychee',
    'Mandarina',
    'Mango',
  ];

  List<GlobalKey> _fruitKeys = [];

  @override
  void initState() {
    _fruitKeys = fruits.map((e) => GlobalKey()).toList();
    super.initState();
  }

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Scroll to position"),
      ),
      body: Center(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: fruits.length,
          itemBuilder: (context, index) {
            return ListTile(
              key: _fruitKeys[index],
              title: Text(fruits[index]),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'Scroll to Mandarina',
        onPressed: _scrollToWidget,
        label: const Text('Scroll to Mandarina'),
        icon: const Icon(Icons.arrow_upward_rounded),
      ),
    );
  }

  void _scrollToWidget() async {
    final index = fruits.indexOf('Mandarina');
    final key = _fruitKeys[index];
    var box = key.currentContext?.findRenderObject();

    if (box == null) {
      double scrollSpeed;

      var currentKeyIndex = _fruitKeys.indexWhere(
          (element) => element.currentContext?.findRenderObject() != null);

      scrollSpeed = currentKeyIndex > index ? 100 : -100;

      while (box == null) {
        var offset = _scrollController.offset - scrollSpeed;
        await _scrollController.animateTo(
          offset,
          duration: const Duration(milliseconds: 1),
          curve: Curves.easeInOut,
        );
        box = key.currentContext?.findRenderObject();
      }
    }

    _scrollController.position.ensureVisible(
      box,
      alignment: 0.2,
      duration: const Duration(milliseconds: 200),
    );
  }
}
