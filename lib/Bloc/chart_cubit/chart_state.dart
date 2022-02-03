import 'package:bmicalculator/model/chart_model.dart';

class ChartState{

}

class InitChart extends ChartState{

}

class ChartLoaded extends ChartState{

  List<ChartModel> list;

  ChartLoaded(this.list);

}