
import 'namaz_model.dart';

class NamazResponse{
  List<NamazModel> result;
  bool success;

  NamazResponse({required this.result,required this.success});

  factory NamazResponse.fromJson(Map<String,dynamic> json){
    var jsonArray = json["result"] as List;
    var result = jsonArray.map((jsonArrayObject) => NamazModel.fromJson(jsonArrayObject)).toList();
    
    return NamazResponse(result: result,success: json["success"] as bool);
  }
}