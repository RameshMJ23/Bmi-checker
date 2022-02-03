import 'dart:developer';
import 'package:bmicalculator/Bloc/chart_cubit/chart_cubit.dart';
import 'package:bmicalculator/Bloc/database_cubit/database_state.dart';
import 'package:bmicalculator/Bloc/database_cubit/databse_cubit.dart';
import 'package:bmicalculator/screens/chart_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/calc_cubit/bmi_state.dart';
import 'package:bmicalculator/data/bmi_database.dart';
import 'package:bmicalculator/data/bmi_model.dart';
import 'package:bmicalculator/model/annotation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SavedScreen extends StatefulWidget {
  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  DateFormat dateFormat = DateFormat.yMMMMd('en_US');
  DateFormat timeFormat = DateFormat.jm();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<DatabaseCubit>(context).initialDatabase();

    return BlocBuilder<DatabaseCubit, DatabaseState>(
      builder: (context, state){
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.green,
              ),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            elevation: 0.0,
            title: Text(
              "Saved Items",
              style: TextStyle(
                  color: Colors.green
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) =>
                      BlocProvider.value(value: ChartCubit(), child: ChartScreen(),)));
                },
                icon: Icon(Icons.show_chart, color:  Colors.green,),
                tooltip: "Chart",
              )
            ],
          ),
          body: (state is InitialDatabase)
          ? buildList(state.initialList, context)
          : (state is UpdatedDatabase)
            ? buildList(state.list, context)
            : showCircularIndicator(),
        );
      },
    );
  }

  Widget showCircularIndicator(){
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  buildList(List<BMIModel> list, BuildContext mainContext){
    return ListView.separated(
      itemBuilder: (context, index){
        return (list.isEmpty || list.length == 0) ? showCircularIndicator() : buildListTile(list[index], mainContext);
      },
      itemCount: list.length,
      separatorBuilder: (context, index){
        return Divider(thickness: 1.5,);
      },
    );
  }

  buildListTile(BMIModel model, BuildContext mainContext){
    return ListTile(
      contentPadding: EdgeInsets.only(bottom: 5.0, top: 5.0, right: 10.0),
      leading: Container(
        height: double.infinity,
        width: 20.0,
        color: showBmi(model.bmi).color,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateFormat.format(model.dateTime).toString()
              ),
              Text(
                  timeFormat.format(model.dateTime).toString()
              ),
            ],
          ),
          Text(
            "Age: ${model.age.toStringAsFixed(0)}",
            style: const TextStyle(
                color: Colors.black
            ),
          ),

        ],
      ),
      subtitle: Text(
          "bmi: ${model.bmi.toStringAsFixed(1)} (${showBmi(model.bmi).bmiStatus})"
      ),
      onLongPress: (){
        showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              content: Text("Do you want to delete this record?"),
              actions: [
                TextButton(
                  onPressed: () async{
                   BlocProvider.of<DatabaseCubit>(mainContext).delete(model.id!);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "yes"
                  )
                ),
                TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel"
                    )
                )
              ],
            );
          }
        );
      },
    );
  }

  Annotation showBmi(double bmi){
    if(bmi > 0 && bmi < 16.9){
      return Annotation(
          color: Colors.blue,
          bmiStatus: "Severely underweight!"
      );

    }else if(bmi >= 17.0 && bmi <= 18.4){
      return Annotation(
          color: Colors.deepPurple,
          bmiStatus: "Underweight"
      );

    }else if(bmi > 18.5 && bmi < 25.0){
      return Annotation(
          color: Colors.green,
          bmiStatus: "Normal"
      );

    }else if(bmi >= 25.0 && bmi < 30.0){
      return Annotation(
          color: Colors.redAccent,
          bmiStatus: "Overweight"
      );
    }else if(bmi >= 30.0){
      return Annotation(
          color: Colors.red,
          bmiStatus: "Obese!"
      );
    }else{
      return Annotation(
          color: Colors.black,
          bmiStatus: ""
      );
    }
  }
}
