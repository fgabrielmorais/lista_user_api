import 'dart:convert';

import 'package:teste_api/data/api.dart';
import 'package:teste_api/model/listPersonModel.dart';
import 'package:teste_api/model/moneyModel.dart';


class DataController{
 final api = API();

Future<moneyModel?> getMoney () async{
  
  try {
    final response = await api.get("https://economia.awesomeapi.com.br/last/USD-BRL,EUR-BRL,BTC-BRL");
    if(response?.statusCode == 200){
      return moneyModel.fromJson(json.decode(json.encode(response?.data)));
    }
  } catch (e) {

    rethrow;
  }
}



Future<List<ListPersonModel>> getListPerson () async{
  
  try {
    final response = await api.get("https://630fa24936e6a2a04edec22f.mockapi.io/api/integridade/getList");
    if(response?.statusCode == 200){
      return (json.decode(json.encode(response?.data)) as List).map((jsonElement) => ListPersonModel.fromJson(jsonElement)).toList();
    }
    else{
      return [];
    }
  } catch (e, s) {
    print(e);
    print(s);
    throw(e);
  }
}


}

