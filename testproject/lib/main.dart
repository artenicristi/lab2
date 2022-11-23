import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'BMI Calculator',
    home: FormDisplay(),
  ));
}

class FormDisplay extends StatefulWidget {
  @override
  _FormDisplay createState() => _FormDisplay();
}

class _FormDisplay extends State<FormDisplay> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController weight = TextEditingController();
  final TextEditingController height = TextEditingController();
  String _emResult = '';
  String _Messagase = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('IMC Calculator'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: weight,
                  decoration: InputDecoration(
                    labelText: 'Introduceti masa (kilograme)',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Introduceti masa';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: height,
                  decoration: InputDecoration(
                    labelText: 'Introduceti inaltimea (metri)',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Introduceti inaltimea';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: (){
                    final form = _formKey.currentState;
                    if (form!.validate()) {
                      handleCalculate();
                      form.save();
                    }
                  },
                  child: Text('Calculeaza IMC'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "IMC:" + _emResult + "\nCategoria : " + _Messagase,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handleCalculate() {
    double height1 = double.parse(height.text);
    double weight1 = double.parse(weight.text);

    double result = weight1 / (height1 * height1);
    result = double.parse(result.toStringAsFixed(2));
    _emResult = result.toString();

    if (result < 18.5) {
      _Messagase = 'Subponderat';
    } else if (result < 25) {
      _Messagase = 'Masa corporala normala';
    } else if (result < 30) {
      _Messagase = 'Supraponderat';
    } else {
      _Messagase = 'Obezitate';
    }
    setState(() {});
  }
}