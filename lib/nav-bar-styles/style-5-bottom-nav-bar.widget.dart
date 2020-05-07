import 'dart:ui';

import 'package:flutter/material.dart';
import '../persistent-tab-view.dart';

class BottomNavStyle5 extends StatelessWidget {
  final int selectedIndex;
  final int previousIndex;
  final double iconSize;
  final Color backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<PersistentBottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;
  final double navBarHeight;
  final NavBarCurve navBarCurve;
  final double bottomPadding;
  final double horizontalPadding;
  final Function(int) popAllScreensForTheSelectedTab;

  BottomNavStyle5(
      {Key key,
      this.selectedIndex,
      this.previousIndex,
      this.showElevation = false,
      this.iconSize,
      this.backgroundColor,
      this.animationDuration = const Duration(milliseconds: 1000),
      this.navBarHeight = 0.0,
      @required this.items,
      this.onItemSelected,
      this.horizontalPadding,
      this.popAllScreensForTheSelectedTab,
      this.bottomPadding,
      this.navBarCurve});

  Widget _buildItem(
      PersistentBottomNavBarItem item, bool isSelected, double height) {
    return AnimatedContainer(
      width: 150.0,
      height: height / 1,
      duration: animationDuration,
      child: AnimatedContainer(
        duration: animationDuration,
        alignment: Alignment.center,
        height: height / 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: IconTheme(
                data: IconThemeData(
                    size: iconSize,
                    color: isSelected
                        ? (item.activeContentColor == null
                            ? item.activeColor
                            : item.activeContentColor)
                        : item.inactiveColor == null
                            ? item.activeColor
                            : item.inactiveColor),
                child: item.icon,
              ),
            ),
            Container(
              height: 5.0,
              width: 5.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  color: isSelected
                      ? (item.activeContentColor == null
                          ? item.activeColor
                          : item.activeContentColor)
                      : Colors.transparent),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: this.navBarHeight,
      padding: EdgeInsets.only(
          left: this.horizontalPadding == null
              ? MediaQuery.of(context).size.width * 0.05
              : this.horizontalPadding,
          right: this.horizontalPadding == null
              ? MediaQuery.of(context).size.width * 0.05
              : this.horizontalPadding,
          top: this.navBarHeight * 0.06,
          bottom: this.bottomPadding == null
              ? this.navBarHeight * 0.16
              : this.bottomPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: items.map((item) {
          var index = items.indexOf(item);
          return Flexible(
            child: GestureDetector(
              onTap: () {
                if (this.previousIndex == index) {
                  this.popAllScreensForTheSelectedTab(index);
                }
                this.onItemSelected(index);
              },
              child: Container(
                color: Colors.transparent,
                child:
                    _buildItem(item, selectedIndex == index, this.navBarHeight),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
