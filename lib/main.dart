import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
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
  List<Map<String, dynamic>> studList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text('SQL Lite App',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600,color: Colors.black),),
        backgroundColor: Colors.lightBlueAccent,
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () {},backgroundColor: Colors.lightBlueAccent, child: const Icon(Icons.add,color: Colors.black)),
      body: ListView.builder(
          itemCount: studList.length,
          itemBuilder: (context, index) => Card(
                color: Colors.lightBlueAccent,
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: studList[index]['name'],
                  subtitle: Text(studList[index]['email']),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.delete))
                      ],
                    ),
                  ),
                ),
              )),
    );
  }
}
