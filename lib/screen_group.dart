import 'package:exercise_flutter_acs/screen_actions.dart';
import 'package:exercise_flutter_acs/screen_info_employees.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'screen_schedule_employees.dart';
import 'the_drawer.dart';
import 'screen_user.dart';
import 'screen_list_groups.dart';

class ScreenGroup extends StatefulWidget {
  final UserGroup userGroup;
  const ScreenGroup({super.key, required this.userGroup});

  @override
  State<ScreenGroup> createState() => _ScreenBlankState();
}

class _ScreenBlankState extends State<ScreenGroup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: TheDrawer(context).drawer,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          title: Text('Group ${widget.userGroup.name}'),
        ),
        body: Center(
          child: GridView.count(crossAxisCount: 2, children: [
            Card(
                child: InkWell(
                    onTap: () => Navigator.of(context)
                        .push(
                          MaterialPageRoute<void>(
                              builder: (context) =>
                                  ScreenInfoEmployees(userGroup: widget.userGroup)),
                        )
                        .then((var v) => setState(() {})),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.description,
                        ),
                        Text("Info")
                      ],
                    ))),
            Card(
                child: InkWell(
                    onTap: () => Navigator.of(context)
                        .push(
                          MaterialPageRoute<void>(
                              builder: (context) =>
                                  ScheduleEmployeesScreen(userGroup: widget.userGroup)),
                        )
                        .then((var v) => setState(() {})),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_month,
                        ),
                        Text("Schedule")
                      ],
                    ))),
            Card(
                child: InkWell(
                    onTap: () => Navigator.of(context)
                        .push(
                          MaterialPageRoute<void>(
                              builder: (context) =>
                                  ScreenActions(userGroup: widget.userGroup)),
                        )
                        .then((var v) => setState(() {})),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.door_back_door,
                        ),
                        Text("Actions")
                      ],
                    ))),
            Card(
                child: InkWell(
                    onTap: () {
                      // ...
                    },
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                        ),
                        Text("Places")
                      ],
                    ))),
            Card(
                child: InkWell(
                    onTap: () => Navigator.of(context)
                        .push(
                          MaterialPageRoute<void>(
                              builder: (context) =>
                                  UserGroupDetailsScreen(group: widget.userGroup)),
                        )
                        .then((var v) => setState(() {})),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.group,
                        ),
                        Text("Users")
                      ],
                    ))),
          ]),
        ));
  }
}

