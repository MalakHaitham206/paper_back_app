import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;
  final List<String> iconPaths;

  // Customizable properties
  final double height;
  final double iconSize;
  final Color selectedColor;
  final Color unselectedColor;
  final Color backgroundColor;
  final double elevation;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    required this.iconPaths,
    this.height = 60.0,
    this.iconSize = 24.0,
    required this.selectedColor, // Made required to force theme usage
    required this.unselectedColor, // Made required to force theme usage
    required this.backgroundColor, // Made required to force theme usage
    this.elevation = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveHeight = height < 50 ? 50.0 : height;

    return Container(
      padding: const EdgeInsets.all(0),
      height: effectiveHeight + MediaQuery.of(context).padding.bottom,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: elevation,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white)),
        ),
        height: effectiveHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(iconPaths.length, (index) {
            final isSelected = selectedIndex == index;
            return Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onTap(index),
                  splashColor: selectedColor.withOpacity(0.2),
                  highlightColor: selectedColor.withOpacity(0.1),
                  child: SizedBox(
                    height: effectiveHeight,
                    child: Center(
                      child: SizedBox(
                        width: iconSize,
                        height: iconSize,
                        child: SvgPicture.asset(
                          iconPaths[index],
                          width: iconSize,
                          height: iconSize,
                          color: isSelected ? selectedColor : unselectedColor,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
