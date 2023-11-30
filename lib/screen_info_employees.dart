import 'package:exercise_flutter_acs/data.dart';
import 'package:flutter/material.dart';

class ScreenInfoEmployees extends StatefulWidget {
  final UserGroup userGroup;
  const ScreenInfoEmployees({super.key, required this.userGroup});

  @override
  _ScreenInfoEmployeesState createState() => _ScreenInfoEmployeesState();
}

class _ScreenInfoEmployeesState extends State<ScreenInfoEmployees> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController descriptionController;

  @protected
  @mustCallSuper
  void initState() {
    nameController = TextEditingController(text: widget.userGroup.name);
    descriptionController = TextEditingController(text: widget.userGroup.description);
  }

  void _saveForm() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.userGroup.name = nameController.value.text;
      widget.userGroup.description = descriptionController.value.text;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info Employees'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: nameController,
              //controller: _employeeController
              decoration: InputDecoration(
                  labelText: 'Name Group', hintText: 'Enter the group name'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter the group name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: descriptionController,
              //controller: _decriptionController
              decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter a description for the group'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter a decription';
                }
                return null;
              },
            ),
            // Añade más TextFormFields según sea necesario
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: _saveForm,
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
