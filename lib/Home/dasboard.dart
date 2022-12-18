import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_practice/InputCard/view.dart';
import './Controller.dart';

class HomeView extends StatefulWidget {
  static const routeName = '/dasboard';
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends HomeController {
  final CollectionReference _catatan =
      FirebaseFirestore.instance.collection('catatan');
  Future _refresh() async {
    setState(() {});
  }

  final TextEditingController JudulController = TextEditingController();
  final TextEditingController CatatanController = TextEditingController();



  // ! Edit Kategori !
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      JudulController.text = documentSnapshot['judul'];
      CatatanController.text = documentSnapshot['catatan'].toString();
    }

    String? size;
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: JudulController,
                decoration: const InputDecoration(labelText: 'Judul'),
              ),
              TextField(
                controller: CatatanController,
                decoration: const InputDecoration(labelText: 'Catatan'),
              ),
              
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    final String judul = JudulController.text;
                    final String catatan = CatatanController.text;
                    if (catatan != null) {
                      await _catatan.doc(documentSnapshot!.id).update({
                        "judul": judul,
                        "catatan": catatan,
                      });
                      JudulController.text = '';
                      CatatanController.text = '';
                    }
                  },
                  child: const Text('Update'))
            ],
          ),
        );
      },
    );
  }

Future<void> _delete(String catatanId) async {
    await _catatan.doc(catatanId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have been succesfully deleted a product')));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bukuku'),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.lightBlue,
      ),

      drawer: Drawer(
          child: ListView(children: <Widget>[
            ListTile(
                title: Text('arsip'),
                leading: CircleAvatar(
                  child: Icon(Icons.archive_outlined),
                ))
          ]),
        ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.of(context).push(
            MaterialPageRoute(
            builder: (context) => InputCardView()),
            );
          },
        child: const Icon(Icons.add),
      ),

      body: StreamBuilder(
        stream: _catatan.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['judul']),
                    subtitle: Text(
                      documentSnapshot['catatan']
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => _update(documentSnapshot),
                            icon: const Icon(
                              Icons.edit,
                            ),
                          ),
                          IconButton(
                            onPressed: () => _delete(documentSnapshot.id),
                            icon: const Icon(
                              Icons.delete,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
