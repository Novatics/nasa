import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var _cells = ['cell 1', 'cell 2', 'cell 3'];

class NewGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Game'),
      ),
      body: Center(
        child: AnimatedList(
          initialItemCount: _cells.length,
          itemBuilder: (context, index, animation) {
            return _buildCell(context, index);
          },
        ),
      ),
    );
  }
}

Widget _buildCell(BuildContext context, int id) {
  return (Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      Text(id.toString()),
      Text(_cells[id]),
    ],
  ));
}
