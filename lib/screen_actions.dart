import 'package:exercise_flutter_acs/data.dart';
import 'package:flutter/material.dart';

class ScreenActions extends StatefulWidget {
  final UserGroup userGroup;
  const ScreenActions({super.key, required this.userGroup});

  @override
  _ScreenActionsState createState() => _ScreenActionsState();
}

class _ScreenActionsState extends State<ScreenActions> {
  late bool open;
  late bool close;
  late bool lock;
  late bool unlock;
  late bool unlock_shortly;

  void _saveForm() {
    widget.userGroup.actions.clear();
    if (open) widget.userGroup.actions.add('open');
    if (close) widget.userGroup.actions.add('close');
    if (lock) widget.userGroup.actions.add('lock');
    if (unlock) widget.userGroup.actions.add('unlock');
    if (unlock_shortly) widget.userGroup.actions.add('unlock_shortly');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Saved')),
    );
  }

  @protected
  @mustCallSuper
  void initState() {
    open = widget.userGroup.actions.contains('open');
    close = widget.userGroup.actions.contains('close');
    lock = widget.userGroup.actions.contains('lock');
    unlock = widget.userGroup.actions.contains('unlock');
    unlock_shortly = widget.userGroup.actions.contains('unlock_shortly');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Info Employees'),
        ),
        body: Column(
          children: <Widget>[
            CheckboxListTile(
                value: open,
                onChanged: (bool? value) {
                  setState(() {
                    open = !open;
                  });
                },
                title: Text("Open"),
                subtitle: Text("opens an unlocked door")),
            CheckboxListTile(
                value: close,
                onChanged: (bool? value) {
                  setState(() {
                    close = !close;
                  });
                },
                title: Text("Close"),
                subtitle: Text("closes an open door")),
            CheckboxListTile(
                value: lock,
                onChanged: (bool? value) {
                  setState(() {
                    lock = !lock;
                  });
                },
                title: Text("Lock"),
                subtitle: Text(
                    "Locks a door or all the doors in a room or group of rooms, if closed")),
            CheckboxListTile(
                value: unlock,
                onChanged: (bool? value) {
                  setState(() {
                    unlock = !unlock;
                  });
                },
                title: Text("Unlock"),
                subtitle: Text(
                    "Unlocks a locked door or all the locked doors in a room")),
            CheckboxListTile(
                value: unlock_shortly,
                onChanged: (bool? value) {
                  setState(() {
                    unlock_shortly = !unlock_shortly;
                  });
                },
                title: Text("Unlock shortly"),
                subtitle: Text(
                    "Unlocks a door during 10 seconds and the locks it if it is closed")),
           
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () => {_saveForm()},
                child: Text('Submit'),
              ),
            ),
          ],
        ));
  }
}
