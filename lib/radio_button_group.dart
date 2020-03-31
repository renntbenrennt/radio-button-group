library radio_button;

import 'package:flutter/material.dart';

const EdgeInsets kButtonPadding = EdgeInsets.symmetric(
  vertical: 4.0,
  horizontal: 8.0,
);

const EdgeInsets kButtonMargin = EdgeInsets.all(0.0);

const LinearGradient kLinearGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xffc2e9fb),
    Color(0xffa1c4fd),
  ],
);

const Color kInactiveBtnColor = Color(0xffd9d9d9);

class RadioButton extends StatelessWidget {
  final String title;
  final int id;
  final Function onTap;
  final int currentIndex;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color activeColor;
  final Color inactiveColor;
  final Gradient activeGradient;
  final Gradient inactiveGradient;

  RadioButton({
    @required this.title,
    this.id,
    this.onTap,
    this.currentIndex,
    this.activeColor,
    this.inactiveGradient,
    this.padding = kButtonPadding,
    this.margin = kButtonMargin,
    this.activeGradient,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          gradient: (currentIndex == id) ? activeGradient : inactiveGradient,
          color: (currentIndex == id) ? activeColor : inactiveColor,
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
  final double spacing;
  final double runSpacing;
  final WrapAlignment alignment;
  final Color activeColor;
  final Color inactiveColor;
  final Gradient activeGradient;
  final Gradient inactiveGradient;

  const RadioButtonGroup({
    @required this.titles,
    this.onButton,
    this.activeColor,
    this.inactiveGradient,
    this.inactiveColor = kInactiveBtnColor,
    this.activeGradient = kLinearGradient,
    this.activeIndex = 0,
    this.spacing = 8.0,
    this.runSpacing = 8.0,
    this.alignment = WrapAlignment.start,
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
        activeColor: widget.activeColor,
        inactiveColor: widget.inactiveColor,
        activeGradient: widget.activeGradient,
        inactiveGradient: widget.inactiveGradient,
        title: titles[index],
        id: index,
        onTap: () {
          setState(() {
            currentIndex = index;
          });
          // TODO: triage this incoming function
          // TODO: find the way to make the function generic
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
    return Wrap(
      spacing: widget.spacing,
      runSpacing: widget.runSpacing,
      alignment: widget.alignment,
      children: getButtons(titles),
    );
  }
}
