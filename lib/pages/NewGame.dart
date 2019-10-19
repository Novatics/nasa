import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var _cells = ['cell 1', 'cell 2', 'cell 3'];

List<String> _selects = [];

class NewGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Game',
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: AnimatedList(
                initialItemCount: _cells.length,
                itemBuilder: (context, index, animation) {
                  return _buildCell(context, index);
                },
              ),
            ),
            Expanded(
              child: Text('Items selecionados'),
            ),
            Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _selects.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        child: Center(child: Text('Item ${_selects[index]}')),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}

Widget _buildCell(BuildContext context, int id) {
  return (Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      Text(
        id.toString(),
      ),
      Text(_cells[id]),
      GestureDetector(
          onTap: () {
            if (_selects.contains(_cells[id])) {
              _selects.remove(_cells[id]);
            } else {
              _selects.add(_cells[id]);
            }
          },
          child: Text('Adicionar a lista'))
    ],
  ));
}
