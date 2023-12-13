import 'package:dashboard/bloc/chat_bloc/chat_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharBarWidget extends StatelessWidget {
  const CharBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          return AspectRatio(
            aspectRatio: 1,
            child: BarChart(
              BarChartData(
                titlesData: const FlTitlesData(
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false))),
                barGroups: [
                  BarChartGroupData(x: 1, barRods: [
                    BarChartRodData(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4)),
                        toY: 10,
                        fromY: 0,
                        width: 15,
                        color: const Color(0xff146C94))
                  ]),
                  BarChartGroupData(x: 2, barRods: [
                    BarChartRodData(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4)),
                        toY: 1,
                        fromY: 0,
                        width: 15,
                        color: const Color(0xff146C94))
                  ]),
                  BarChartGroupData(x: 3, barRods: [
                    BarChartRodData(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4)),
                        toY: 6,
                        fromY: 0,
                        width: 15,
                        color: const Color(0xff146C94))
                  ]),
                  BarChartGroupData(x: 4, barRods: [
                    BarChartRodData(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4)),
                        toY: 10,
                        fromY: 0,
                        width: 15,
                        color: const Color(0xff146C94))
                  ]),
                  BarChartGroupData(x: 5, barRods: [
                    BarChartRodData(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4)),
                        toY: 3,
                        fromY: 0,
                        width: 15,
                        color: const Color(0xff146C94))
                  ]),
                  BarChartGroupData(x: 6, barRods: [
                    BarChartRodData(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4)),
                        toY: 7,
                        fromY: 0,
                        width: 15,
                        color: const Color(0xff146C94))
                  ]),
                  BarChartGroupData(x: 7, barRods: [
                    BarChartRodData(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4)),
                        toY: 3,
                        fromY: 0,
                        width: 15,
                        color: const Color(0xff146C94))
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
          );
        },
      ),
    );
  }
}
