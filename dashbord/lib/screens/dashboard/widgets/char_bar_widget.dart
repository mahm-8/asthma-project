import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CharBarWidget extends StatelessWidget {
  const CharBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: AspectRatio(
        aspectRatio: 1,
        child: BarChart(
          BarChartData(
            barGroups: [
              BarChartGroupData(x: 1, barRods: [
                BarChartRodData(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4)),
                    toY: 10,
                    fromY: 0,
                    width: 15,
                    color: Colors.blueAccent[200])
              ]),
              BarChartGroupData(x: 2, barRods: [
                BarChartRodData(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4)),
                    toY: 1,
                    fromY: 0,
                    width: 15,
                    color: Colors.blueAccent[200])
              ]),
              BarChartGroupData(x: 3, barRods: [
                BarChartRodData(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4)),
                    toY: 6,
                    fromY: 0,
                    width: 15,
                    color: Colors.blueAccent[200])
              ]),
              BarChartGroupData(x: 4, barRods: [
                BarChartRodData(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4)),
                    toY: 10,
                    fromY: 0,
                    width: 15,
                    color: Colors.blueAccent[200])
              ]),
              BarChartGroupData(x: 5, barRods: [
                BarChartRodData(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4)),
                    toY: 3,
                    fromY: 0,
                    width: 15,
                    color: Colors.blueAccent[200])
              ]),
              BarChartGroupData(x: 6, barRods: [
                BarChartRodData(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4)),
                    toY: 7,
                    fromY: 0,
                    width: 15,
                    color: Colors.blueAccent[200])
              ]),
              BarChartGroupData(x: 7, barRods: [
                BarChartRodData(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4)),
                    toY: 3,
                    fromY: 0,
                    width: 15,
                    color: Colors.blueAccent[200])
              ])
            ],
            borderData: FlBorderData(
              border: const Border(
                  top: BorderSide.none,
                  right: BorderSide.none,
                  left: BorderSide(width: 1),
                  bottom: BorderSide(width: 1)),
            ),
          ),
        ),
      ),
    );
  }
}
