import 'package:flutter/material.dart';

class SearchList extends SearchDelegate {
  List<dynamic> _list = [];
  SearchList(List<dynamic> list) {
    this._list = list;
  }

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
          return item.nombre.toLowerCase().contains(query.toLowerCase()) ||
              item.fechaNacimiento.toIso8601String().contains(query) ||
              item.apellido.toLowerCase().contains(query.toLowerCase());
        }))
          ListTile(
            title: Text("${item.nombre} ${item.apellido}"),
            subtitle: Text("${item.fechaNacimiento}"),
            trailing: Text(item.fotos.length.toString()),
            onTap: () {
              // Mostramos las fotos del cliente
              Navigator.pushNamed(
                context,
                "/fotos",
                arguments: item,
              );
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
          return item.nombre.toLowerCase().contains(query.toLowerCase()) ||
              item.fechaNacimiento.toIso8601String().contains(query) ||
              item.apellido.toLowerCase().contains(query.toLowerCase());
        }))
          ListTile(
            title: Text("${item.nombre} ${item.apellido}"),
            subtitle: Text("${item.fechaNacimiento}"),
            trailing: Text(item.fotos.length.toString()),
            onTap: () {
              // Mostramos las fotos del cliente
              Navigator.pushNamed(
                context,
                "/fotos",
                arguments: item,
              );
            },
          ),
      ],
    );
  }
}
