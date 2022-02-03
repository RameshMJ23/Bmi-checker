import 'package:bmicalculator/Bloc/chart_cubit/chart_cubit.dart';
import 'package:bmicalculator/Bloc/chart_cubit/chart_state.dart';
import 'package:bmicalculator/Bloc/database_cubit/database_state.dart';
import 'package:bmicalculator/Bloc/database_cubit/databse_cubit.dart';
import 'package:bmicalculator/data/bmi_model.dart';
import 'package:bmicalculator/model/chart_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartScreen extends StatefulWidget {
  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<ChartCubit>(context).getValue();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chart",
          style: TextStyle(
            color: Colors.green
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          tooltip: "Chart",
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<ChartCubit, ChartState>(
        builder: (context, state){
          if(state is InitChart){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(state is ChartLoaded){
            return chartWidget(state.list);
          }
          else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget chartWidget(List<ChartModel> list){

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: PieChart(
                PieChartData(
                  sections: getSections(list),
                  centerSpaceRadius: 70.0,
                )
            ),
          ),
        ),
        valueWidget(Colors.blue, "Severely underweight ", list[0].percentage.toStringAsFixed(0).toString()),
        valueWidget(Colors.deepPurple, "Underweight", list[1].percentage.toStringAsFixed(0).toString()),

        valueWidget(Colors.green, "Normal", list[2].percentage.toStringAsFixed(0).toString()),

        valueWidget(Colors.redAccent, "Overweight", list[3].percentage.toStringAsFixed(0).toString()),

        valueWidget(Colors.red, "Severely underweight", list[4].percentage.toStringAsFixed(0).toString()),
      ],
    );
  }


  Widget valueWidget(
      Color color,
      String name,
      String percentage){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
      child: Row(
        children: [
          Container(
            height: 10.0,
            width: 35.0,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10.0)
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Text(
            "$name :",
            style: TextStyle(
                fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Text(
            "$percentage %",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> getSections(List<ChartModel> list){
    return list.asMap().map<int, PieChartSectionData>((key, model) {

      final value = PieChartSectionData(
        color: model.color,
        title: "${model.percentage.toStringAsFixed(0).toString()} %",
        value: model.percentage,
        radius: 90.0,
        titleStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500
        )
      );
      return MapEntry(key, value);
    }).values.toList();
  }

}
