import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Telescopes extends StatefulWidget {
  @override
  _TelescopesState createState() => _TelescopesState();
}

class _TelescopesState extends State<Telescopes> {
  List<String> _cells;
  List<String> _telescopes;

  @override
  void initState() {
    super.initState();
    setState(() {
      _cells = ['cell 1', 'cell 2', 'cell 3'];
      _telescopes = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildCell(int id, List<String> cells, List<String> telescopes) {
      return (Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            id.toString(),
          ),
          Text(cells[id]),
          GestureDetector(
              onTap: () {
                if (telescopes.contains(cells[id])) {
                  telescopes.remove(cells[id]);
                  setState(() {
                    _telescopes = telescopes;
                  });
                } else {
                  setState(() {
                    _telescopes = [..._telescopes, cells[id]];
                  });
                }
              },
              child: Text('Adicionar a lista')),
        ],
      ));
    }

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
                  return _buildCell(index, _cells, _telescopes);
                },
              ),
            ),
            Expanded(
              child: Text('Items selecionados'),
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) {
                return Text(_telescopes[index]);
              },
              itemCount: _telescopes.length,
            )),
          ],
        ),
      ),
    );
  }
}
