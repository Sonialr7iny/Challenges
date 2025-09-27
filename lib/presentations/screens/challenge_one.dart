import 'package:challenges/presentations/screens/challenge_two.dart';
import 'package:flutter/material.dart';

class ChallengeOne extends StatefulWidget {
  const ChallengeOne({super.key});

  @override
  State<ChallengeOne> createState() => _ChallengeOneState();
}

class _ChallengeOneState extends State<ChallengeOne> {
  List<dynamic> tasks = [
    'Review Clean Architecture',
    'Complete Flutter assignment',
    'Practice widgets catalog',
  ];
  List<bool> checked = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios_sharp),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChallengeTwo()),
              );
            },
            icon: Icon(Icons.navigate_next_rounded, size: 40),
          ),
        ],
        title: Text('Task Manager', textAlign: TextAlign.center),
      ),
      body: ReorderableListView(
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex-=1;
            }
            final task = tasks.removeAt(oldIndex);
            final check = checked.removeAt(oldIndex);
            tasks.insert( newIndex, task);
            checked.insert(newIndex, check);
          });
        },
        children: List.generate(tasks.length, (index) {
          return Dismissible(
            key: Key('$index'),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            confirmDismiss: (direction) async {
              return await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Confirm Delete'),
                  content: Text('Delete ${tasks[index]}'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('Delete'),
                    ),
                  ],
                ),
              );
            },
            onDismissed: (direction) async {
              final removedTask = tasks[index];
              final wasChecked = checked[index];
              setState(() {
                tasks.removeAt(index);
                checked.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Deleted "$removedTask"'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      setState(() {
                        tasks.insert(index, removedTask);
                        checked.insert(index, wasChecked);
                      });
                    },
                  ),
                ),
              );
            },
            // for (int index = 0; index < tasks.length; index++)
            child: Card(
              key: Key('$index'),
              child: ListTile(
                key: Key('$index'),
                title: Text(
                  '${tasks[index]}',
                  style: TextStyle(
                    decoration: checked[index]
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                leading: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: ReorderableDragStartListener(
                    index: index,
                    child: Icon(Icons.menu),
                  ),
                ),
                trailing: Checkbox(
                  value: checked[index],
                  onChanged: (value) {
                    setState(() {
                      checked[index] = value!;
                    });
                  },
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
