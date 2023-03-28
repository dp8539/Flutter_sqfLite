import 'package:flutter/material.dart';
import 'package:sqf_lite_database/sqf_lite_database/sqf_db.dart';

class SQLiteDemo extends StatefulWidget {
  const SQLiteDemo({super.key});

  @override
  State<SQLiteDemo> createState() => _SQLiteDemoState();
}

class _SQLiteDemoState extends State<SQLiteDemo> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();

  TextEditingController updateName = TextEditingController();
  TextEditingController updateEmail = TextEditingController();
  TextEditingController updateId = TextEditingController();

  SqliteDb sqliteDb = SqliteDb();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sqliteDb.createDb();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('SQF Lite Database'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: txtName,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: txtEmail,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            sqliteDb.addData(
                              name: txtName.text,
                              email: txtEmail.text,
                            );
                            await sqliteDb.selectData();
                            txtName.clear();
                            txtEmail.clear();
                            setState(() {});
                          },
                          child: const Text('add'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            print('****');
                            await sqliteDb.selectData();
                            setState(() {});
                          },
                          child: const Text('Show'),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: List.generate(
                      data.length,
                      (index) => ListTile(
                        leading: Text('${data[index]['id']}'),
                        title: Text(data[index]['name']),
                        subtitle: Text(data[index]['email']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  // barrierDismissible: false,
                                  context: context,
                                  builder: (context) => SimpleDialog(
                                    contentPadding: const EdgeInsets.all(15),
                                    title: const Text('Update Data'),
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Text(
                                              'ID : ${data[index]['id']}')),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: TextField(
                                          controller: updateName
                                            ..text = data[index]['name'],
                                          decoration: const InputDecoration(
                                            labelText: 'Name',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: TextField(
                                          controller: updateEmail
                                            ..text = data[index]['email'],
                                          decoration: const InputDecoration(
                                            labelText: 'Email',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await sqliteDb.updateData(
                                            name: updateName.text,
                                            email: updateEmail.text,
                                            id: '${data[index]['id']}',
                                          );
                                          await sqliteDb.selectData();
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                        child: const Text('Update Data'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: const Icon(Icons.update),
                            ),
                            IconButton(
                              onPressed: () async {
                                await sqliteDb.deleteData(
                                  id: data[index]['id'],
                                );
                                await sqliteDb.selectData();
                                setState(() {});
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
