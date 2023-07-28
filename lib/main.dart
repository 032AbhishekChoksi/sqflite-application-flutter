import 'package:flutter/material.dart';
import 'package:sqflite_application/sql_helper.dart';

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
      title: 'Flutter SQL Lite App',
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
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  showForm(int? id) async {
    if (id != null) {
      final existingRecord =
          studList.firstWhere((element) => element['id'] == id);
      nameController.text = existingRecord['name'];
      emailController.text = existingRecord['email'];
    }

    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 120,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Enter Name'),
              keyboardType: TextInputType.name,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Enter Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (id == null) {
                  await addStudents();
                }
              },
              child: Text(id == null ? 'Create New' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getStudentList() async {
    final data = await SQLHelper.getList();
    setState(() {
      studList = data;
    });
  }

  Future<void> addStudents() async {
    final id = await SQLHelper.addStudent(
        nameController.text.toString(), emailController.text.toString());
    if (id > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Student Inserted Successfully')));
    }
    getStudentList();
  }

  @override
  void initState() {
    getStudentList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SQL Lite App',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => showForm(null),
          backgroundColor: Colors.lightBlueAccent,
          child: const Icon(Icons.add, color: Colors.black)),
      body: ListView.builder(
          itemCount: studList.length,
          itemBuilder: (context, index) => Card(
                color: Colors.lightBlueAccent,
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(studList[index]['name']),
                  subtitle: Text(studList[index]['email']),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () => showForm(studList[index]['id']),
                            icon: const Icon(Icons.edit)),
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
