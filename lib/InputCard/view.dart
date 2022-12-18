import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_practice/Home/dasboard.dart';
import './controller.dart';

class InputCardView extends StatefulWidget {
  static const routeName = '/tambah';
  const InputCardView({Key? key}) : super(key: key);

  @override
  State<InputCardView> createState() => _InputCardViewState();
}

class _InputCardViewState extends InputCardController {
  final CollectionReference _catatan =
      FirebaseFirestore.instance.collection('catatan');

  TextEditingController JudulController = TextEditingController();
  TextEditingController CatatanController = TextEditingController();
void dispose() {
    JudulController.dispose();
    CatatanController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Catatan')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Judul'),
            TextField(
              controller: JudulController,
            ),
            SizedBox(
              height: 15,
            ),
            Text('Catatan'),
            TextField(
              controller: CatatanController,
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () async {
                  final String judul = JudulController.text;
                  final String catatan = CatatanController.text;
                  if (judul != null) {
                    await _catatan.add({
                      "judul": judul,
                      "catatan": catatan,
                    });
                    JudulController.text = '';
                    CatatanController.text = '';
                  }
                  Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomeView()),
              );

                },
                child: const Text('Save'),
              ),

          ],
        ),
      ),
    );
  }

  
}
