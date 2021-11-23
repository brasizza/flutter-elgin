import 'dart:convert';

import 'package:elgin/elgin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SatPage extends StatefulWidget {
  const SatPage({Key? key}) : super(key: key);

  @override
  _SatPageState createState() => _SatPageState();
}

class _SatPageState extends State<SatPage> {
  String _model = '0 Sat detected';

  String codAtivacao = 'bema1234';
  String cnpjContribuinte = '27101611000182';
  int uf = 15;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Modelo'),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                _model,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      const Divider(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
              onPressed: () async {
                try {
                  String deviceInfo = await Elgin.sat.deviceInfo();
                  Map<String, dynamic> _sat = jsonDecode(deviceInfo);
                  setState(() {
                    _model = _sat['model'];
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(deviceInfo)));
                } on ElginException catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.error.message)));
                }
              },
              child: const Text('Detectar SAT!')),
          ElevatedButton(
              onPressed: () async {
                try {
                  String _resultado = await Elgin.sat.ativarSat(codAtivacao, cnpjContribuinte, uf);

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_resultado)));
                } on ElginException catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.error.message)));
                }
              },
              child: const Text('Ativar SAT')),
          ElevatedButton(
              onPressed: () async {
                try {
                  String _resultado = await Elgin.sat.consultarSat();

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_resultado)));
                } on ElginException catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.error.message)));
                }
              },
              child: const Text('Consultar SAT')),
          ElevatedButton(
              onPressed: () async {
                try {
                  String _resultado = await Elgin.sat.consultarStatus(codAtivacao);

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_resultado)));
                } on ElginException catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.error.message)));
                }
              },
              child: const Text('Status operacional'))
        ],
      )
    ]);
  }
}
