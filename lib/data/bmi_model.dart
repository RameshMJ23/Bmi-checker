
String tableName = "bmitable";
String field_id = "_id";
String field_age = "age";
String field_height = "height";
String field_weight = "weight";
String field_dateTime = "datetime";
String field_bmi = "bmi";

List<String> columns = [field_id, field_age, field_height, field_weight, field_dateTime, field_bmi];

class BMIModel{
  int? id;
  double age;
  double height;
  double weight;
  double bmi;
  DateTime dateTime;

  BMIModel({
    this.id,
    required this.age,
    required this.height,
    required this.weight,
    required this.dateTime,
    required this.bmi
  });

  BMIModel generate({
      int? id,
      double? age,
      double? height,
      double? weight,
      double? bmi,
      DateTime? dateTime
  }) => BMIModel(
      id: id ?? this.id,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      bmi: bmi ?? this.bmi,
      dateTime: dateTime ?? this.dateTime
  );

  Map<String, Object?> toJson() => {
    field_id: id,
    field_age: age,
    field_height: height,
    field_weight: weight,
    field_bmi: bmi,
    field_dateTime: dateTime.toIso8601String()
  };

  static BMIModel fromJson(Map<String, Object?> json) => BMIModel(
    id: json[field_id] as int,
    age: json[field_age] as double,
    height: json[field_height] as double,
    weight: json[field_weight] as double,
    bmi: json[field_bmi] as double,
    dateTime: DateTime.parse(json[field_dateTime] as String)
  );
}