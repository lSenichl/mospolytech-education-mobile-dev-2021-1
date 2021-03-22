import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class Lab01 extends StatefulWidget {
  @override
  Lab01State createState() {
    return Lab01State();
  }
}

enum SingingCharacter { radio1, radio2 }

class Lab01State extends State<Lab01> {
  //
  final _formKey = GlobalKey<FormState>();

  //
  SfRangeValues _values = SfRangeValues(40.0, 80.0);
  double _value = 40.0;

  //
  SingingCharacter _character = SingingCharacter.radio1;

  //
  bool rememberMe = false;

  void _onRememberMeChanged(bool newValue) => setState(() {
        rememberMe = newValue;
      });

  final checkedValue = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25),
      child: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text('Введите данные для регистрации:',
                    style: TextStyle(fontSize: 18)),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Введите электронную почту",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Введите электронную почту!';
                  }
                  return null;
                },
              ),
              Row(textDirection: TextDirection.ltr, children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Введите пароль",
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Введите пароль!';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Повторите пароль",
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Повторите пароль!';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ]),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: Text('Кто вы?', style: TextStyle(fontSize: 18)),
              ),
              Row(textDirection: TextDirection.ltr, children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Бакалавр'),
                    leading: Radio<SingingCharacter>(
                      activeColor: Colors.green,
                      value: SingingCharacter.radio1,
                      groupValue: _character,
                      onChanged: (SingingCharacter value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Специалист'),
                    leading: Radio<SingingCharacter>(
                      activeColor: Colors.green,
                      value: SingingCharacter.radio2,
                      groupValue: _character,
                      onChanged: (SingingCharacter value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                ),
              ]),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 10),
                child: Text('Сколько вам лет?', style: TextStyle(fontSize: 18)),
              ),
              SleekCircularSlider(
                  appearance: CircularSliderAppearance(
                    customColors: CustomSliderColors(
                        trackColor: Colors.green,
                        progressBarColor: Colors.green,
                        hideShadow: true),
                    infoProperties: InfoProperties(
                        bottomLabelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                        bottomLabelText: 'Лет',
                        mainLabelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600),
                        modifier: (double value) {
                          final temp = value.toInt();
                          return '$temp';
                        }),
                  ),
                  onChange: (double value) {
                    print(value.ceil().toInt().toString());
                  }),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text('Сколько вам лет?', style: TextStyle(fontSize: 18)),
              ),
              SfSlider(
                min: 0.0,
                max: 100.0,
                value: _value,
                stepSize: 1,
                interval: 20,
                showTicks: true,
                showLabels: true,
                enableTooltip: true,
                minorTicksPerInterval: 1,
                onChanged: (dynamic value) {
                  setState(() {
                    _value = value;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 5),
                child: Text('Сколько вам лет?', style: TextStyle(fontSize: 18)),
              ),
              SfRangeSlider(
                min: 20.0,
                max: 100.0,
                values: _values,
                stepSize: 1,
                interval: 20,
                showTicks: true,
                showLabels: true,
                enableTooltip: true,
                minorTicksPerInterval: 1,
                onChanged: (SfRangeValues values) {
                  setState(() {
                    _values = values;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 5),
                child: Center(
                  child: Row(
                    textDirection: TextDirection.ltr,
                    children: <Widget>[
                      Checkbox(
                        value: rememberMe,
                        onChanged: _onRememberMeChanged,
                      ),
                      Text('Подписаться на рассылки',
                          style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a Snackbar.
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Ваши данные успешно сохранены!')));
                    }
                  },
                  child: Text('Отправить'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
