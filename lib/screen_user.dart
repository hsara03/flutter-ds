import 'package:flutter/material.dart';
import 'data.dart';
import 'screen_create_user.dart'; // Asegúrate de que este archivo esté configurado para manejar la edición.

class UserGroupDetailsScreen extends StatefulWidget {
  final UserGroup group;

  UserGroupDetailsScreen({Key? key, required this.group}) : super(key: key);

  @override
  _UserGroupDetailsScreenState createState() => _UserGroupDetailsScreenState();
}

class _UserGroupDetailsScreenState extends State<UserGroupDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.group.name),
      ),
      body: Column(
        children: [
          Text('Group Description: ${widget.group.description}'),
          Expanded(
            child: ListView.builder(
              itemCount: widget.group.users.length,
              itemBuilder: (context, index) {
                User user = widget.group.users[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(Data.images[user.name.toLowerCase()] ?? ''),
                  ),
                  title: Text(user.name),
                  subtitle: Text(user.credential),
                  onTap: () async {
                    // Navegar a CreateUserScreen para editar el usuario existente
                    final User? editedUser = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateUserScreen(userToEdit: user)),
                    );
                    // Si se devuelve un usuario editado, actualiza la lista y el estado
                    if (editedUser != null) {
                      setState(() {
                        widget.group.users[index] = editedUser;
                        // Aquí también podrías añadir la lógica para guardar los cambios de manera persistente
                      });
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Aquí asumimos que CreateUserScreen puede manejar la creación de nuevos usuarios también
          final User? newUser = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateUserScreen()),
          );
          if (newUser != null) {
            setState(() {
              widget.group.users.add(newUser);
              // Aquí también podrías añadir la lógica para guardar los cambios de manera persistente
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
