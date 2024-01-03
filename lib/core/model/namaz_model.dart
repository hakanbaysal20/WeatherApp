class NamazModel{
  final saat;
  final vakit;

  NamazModel({required this.saat,required this.vakit});
  factory NamazModel.fromJson(Map<String,dynamic> json){
    return NamazModel(saat: json["saat"], vakit: json["vakit"]);
  }
}

