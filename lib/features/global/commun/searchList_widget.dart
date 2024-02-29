import 'package:app_doc/features/global/commun/transversals.dart';
import 'package:app_doc/features/model/notify.dart';
import 'package:flutter/material.dart';

class SearchList extends SearchDelegate {
  List<dynamic> _list = [];
  late final EntitysModel _model;
  SearchList(this._list, this._model);

  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones de la barra de búsqueda
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Botón de retroceso de la barra de búsqueda
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Resultados de la búsqueda
    return ListView(
      children: [
        // Listamos los items que coinciden con la búsqueda
        for (final item in _list.where((item) {
          return item.userName.toLowerCase().contains(query.toLowerCase()) ||
              item.id.contains(query);
        }))
          ListTile(
            title: Text("${item.userName}"),
            subtitle: Text(formatDate(item.createDate)),
            trailing: Text(item.fotos.length.toString()),
            onTap: () {
              // Mostramos las fotos del cliente
              Navigator.pushNamed(context, "/fotos",
                  arguments: {'pacient': item, 'model': _model});
            },
          ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias de búsqueda
    return ListView(
      children: [
        // Listamos las sugerencias de búsqueda
        for (final item in _list.where((item) {
          return item.userName.toLowerCase().contains(query.toLowerCase()) ||
              item.id.contains(query);
        }))
          ListTile(
            textColor: Color.fromRGBO(165, 219, 195, 1),
            tileColor: Color.fromRGBO(167, 221, 197, 235),
            title: Text("${item.userName}"),
            subtitle: Text(formatDate(item.createDate)),
            trailing: Text(item.fotos.length.toString()),
            onTap: () {
              // Mostramos las fotos del cliente
              Navigator.pushNamed(context, "/fotos",
                  arguments: {'pacient': item, 'model': _model});
            },
          ),
      ],
    );
  }
}
