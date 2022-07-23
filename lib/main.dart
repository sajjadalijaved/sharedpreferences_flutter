import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SharedPreferences? pref;
  String name = '';
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    bild();
    getData();
  }

  void bild() async {
    pref = await SharedPreferences.getInstance();
  }

  setData() async {
    pref!.setString('data', textEditingController.text.toString());
  }

  getData() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      name = pref!.getString('data')!;
    });
  }

  delete() {
    pref!.remove('data');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              TextField(
                controller: textEditingController,
                decoration: const InputDecoration(
                    hintText: 'Enter the data',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.blue, width: 2))),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                name,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
              ElevatedButton(
                  onPressed: () {
                    setData();
                  },
                  child: const Text('Save Data')),
              const SizedBox(
                height: 3,
              ),
              ElevatedButton(
                  onPressed: () {
                    getData();
                  },
                  child: const Text('Get  Data')),
              const SizedBox(
                height: 3,
              ),
              ElevatedButton(
                  onPressed: () {
                    delete();
                  },
                  child: const Text('Remove Data')),
            ])));
  }
}
