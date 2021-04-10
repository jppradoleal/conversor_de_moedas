import 'dart:convert';

import 'package:conversor_de_moedas/widgets/monetary_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const url = "https://api.hgbrasil.com/finance?key=04755018";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _brlController = TextEditingController();
  final TextEditingController _usdController = TextEditingController();
  final TextEditingController _eurController = TextEditingController();

  Map response = Map();

  double dolar;
  double euro;

  Future<Map> getData() async {
    return await http
        .get(Uri.parse(url))
        .then((response) => json.decode(response.body));
  }

  void _resetValues() {
    _brlController.clear();
    _usdController.clear();
    _eurController.clear();
  }

  _onBrlChanged(String text) {
    if (text.isEmpty) {
      _resetValues();
      return;
    }

    double real = double.parse(text);
    _usdController.text = (real / dolar).toStringAsFixed(2);
    _eurController.text = (real / euro).toStringAsFixed(2);
  }

  _onUsdChanged(String text) {
    if (text.isEmpty) {
      _resetValues();
      return;
    }

    double dolar = double.parse(text);
    _brlController.text = (dolar * this.dolar).toStringAsFixed(2);
    _eurController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  _onEurChanged(String text) {
    if (text.isEmpty) {
      _resetValues();
      return;
    }

    double euro = double.parse(text);
    _brlController.text = (euro * this.euro).toStringAsFixed(2);
    _eurController.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "\$ Conversor \$",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetValues,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Icon(
                  Icons.monetization_on,
                  color: Colors.amber,
                  size: 96,
                ),
              ),
              FutureBuilder<Map>(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Erro ao carregar dados"),
                      );
                    }

                    dolar =
                        snapshot.data["results"]["currencies"]["USD"]["buy"];
                    euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                    return Column(
                      children: [
                        Column(
                          children: [
                            MonetaryField(
                              hint: "Reais",
                              prefix: "R\$ ",
                              controller: _brlController,
                              onChanged: _onBrlChanged,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            MonetaryField(
                              hint: "Dolár",
                              prefix: "U\$ ",
                              controller: _usdController,
                              onChanged: _onUsdChanged,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            MonetaryField(
                              hint: "Euros",
                              prefix: "€ ",
                              controller: _eurController,
                              onChanged: _onEurChanged,
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
