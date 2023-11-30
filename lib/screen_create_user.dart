import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'data.dart'; // Asegúrate de tener esta clase definida en tu proyecto

class CreateUserScreen extends StatefulWidget {
  final User? userToEdit; // Añade un usuario opcional para la edición

  CreateUserScreen({Key? key, this.userToEdit}) : super(key: key);

  @override
  _CreateUserScreenState createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _credentialController;

  @override
  void initState() {
    super.initState();
    // Inicializa los controladores con los datos del usuario a editar o en blanco para un nuevo usuario
    _nameController = TextEditingController(text: widget.userToEdit?.name ?? '');
    _credentialController = TextEditingController(text: widget.userToEdit?.credential ?? '');
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      User user = widget.userToEdit ?? User(_nameController.text, _credentialController.text); // Si se está editando, usa el usuario existente; si no, crea uno nuevo 
      Navigator.pop(context, user); // Devuelve el usuario nuevo o editado
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userToEdit == null ? 'Create User' : 'Edit User'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _credentialController,
                decoration: InputDecoration(
                  labelText: 'Credential',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(5),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a credential';
                  } else if (value.length != 5) {
                    return 'The credential must be exactly 5 digits long';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.userToEdit == null ? 'Create' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
