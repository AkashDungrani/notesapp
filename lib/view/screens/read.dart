import 'package:flutter/material.dart';
import 'package:notes_app/helper/firestore_db_helper.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> updateKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String? title;
  String? description;

  final date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                setState(() {
                  titleController.clear();
                  descriptionController.clear();

                  title = null;
                  description = null;
                });
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios)),
          title: Text("Add Notes"),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();

                  Map<String, dynamic> data = {
                    "title": title,
                    "description": description,
                  };
                  Navigator.pop(context);

                  await FirestoreDBHelper.firestoreDBHelper
                      .insertNotes(data: data);

                  print("${data['title']}\n${data['description']}\n");
                }
                setState(() {
                  titleController.clear();
                  descriptionController.clear();

                  title = null;
                  description = null;
                });
              },
              child: Text(
                "Save",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: titleController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Title is empty...";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      title = val;
                    },
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Add Title",
                      hintStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    "${date.day}-${date.month}-${date.year}",
                    style: TextStyle(
                        fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Description is empty...";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      description = val;
                    },
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    maxLines: 15,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Add Description",
                      hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
