library radio_button;

import 'package:flutter/material.dart';

const EdgeInsets kButtonPadding = EdgeInsets.symmetric(
  vertical: 4.0,
  horizontal: 8.0,
);

const EdgeInsets kButtonMargin = EdgeInsets.all(8.0);

const LinearGradient kLinearGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xffc2e9fb),
    Color(0xffa1c4fd),
  ],
);

class RadioButton extends StatelessWidget {
  final String title;
  final int id;
  final Function onTap;
  final int currentIndex;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color activeColor;
  final Gradient gradient;

  RadioButton({
    this.title,
    this.id,
    this.onTap,
    this.currentIndex,
    this.activeColor,
    this.padding = kButtonPadding,
    this.margin = kButtonMargin,
    this.gradient = kLinearGradient,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          gradient: (currentIndex == id) ? gradient : null,
          color: (currentIndex == id) ? activeColor : Color(0xffd9d9d9),
          // TODO: figure out how to dynamically pass radius value
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: (currentIndex == id) ? Color(0xff252b37) : Colors.grey,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class RadioButtonGroup extends StatefulWidget {
  final List<String> titles;
  final Function onButton;
  final int activeIndex;

  const RadioButtonGroup({
    @required this.titles,
    this.onButton,
    this.activeIndex = 0,
  });

  @override
  _RadioButtonGroupState createState() => _RadioButtonGroupState();
}

class _RadioButtonGroupState extends State<RadioButtonGroup> {
  List<String> titles;

  int currentIndex;

  List<Widget> getButtons(List<String> titles) {
    List<Widget> res = [];
    for (int index = 0; index < titles.length; index++) {
      res.add(RadioButton(
        title: titles[index],
        id: index,
        onTap: () {
          setState(() {
            currentIndex = index;
          });
          // TODO: triage this incoming function
          // TODO: find the way to limit the incoming function
          if (widget.onButton != null) {
            widget.onButton();
          }
        },
        currentIndex: currentIndex,
      ));
    }
    return res;
  }

  @override
  void initState() {
    super.initState();

    currentIndex = widget.activeIndex;

    titles = widget.titles.length == 0 ? [''] : widget.titles;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: all the value in here should be dynamic
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      alignment: WrapAlignment.start,
      children: getButtons(titles),
    );
  }
}
