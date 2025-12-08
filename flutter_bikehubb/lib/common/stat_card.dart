import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {

  final IconData icon;
  final String value;
  final String label;

  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableHeight = constraints.maxHeight;
        final iconSize = availableHeight * 0.35;
        final fontSize = availableHeight * 0.12;
        
        return Container(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: iconSize.clamp(40.0, 80.0),
              ),
              SizedBox(height: availableHeight * 0.04),
              Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Segoe UI, Roboto',
                  color: Colors.white,
                  fontSize: fontSize.clamp(18.0, 22.0),
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: availableHeight * 0.02),
              Flexible(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Segoe UI, Roboto',
                    color: Colors.white,
                    fontSize: (fontSize * 0.65).clamp(11.0, 14.0),
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}