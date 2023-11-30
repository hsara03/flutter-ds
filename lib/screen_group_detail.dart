import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'data.dart'; // Asegúrate de que esta clase esté definida en tu proyecto

class CreateUserScreen extends StatefulWidget {
  final User? userToEdit; // Usuario opcional para la edición

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
    // Si se está editando un usuario, se usan sus datos para inicializar los controladores
    _nameController = TextEditingController(text: widget.userToEdit?.name ?? '');
    _credentialController = TextEditingController(text: widget.userToEdit?.credential ?? '');
  }

  void _submitForm() {
  if (_formKey.currentState!.validate()) {
    if (widget.userToEdit == null) {
      // Creando un nuevo usuario
      User newUser = User(
        _nameController.text,
        _credentialController.text,
      );
      Navigator.pop(context, newUser); 
    } else {
      // Actualizando un usuario existente
      setState(() {
        widget.userToEdit!.name = _nameController.text;
        widget.userToEdit!.credential = _credentialController.text;
       
      });
      Navigator.pop(context); 
    }
  }
}


  @override
  void dispose() {
    _nameController.dispose();
    _credentialController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.userToEdit != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit User' : 'Create New User'),
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
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(5),
                ],
                decoration: InputDecoration(
                  labelText: 'Credential',
                  border: OutlineInputBorder(),
                ),
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
                child: Text(isEditing ? 'Save Changes' : 'Create User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
