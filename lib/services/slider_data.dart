import 'dart:convert';

import '../models/slider_model.dart';
import 'package:http/http.dart' as http;

class Sliders{
  List<SliderModel> sliders = [];


Future <void> getSlider() async {
  // String url = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=6b2a40b1672a4c478e01f6df263e455f";
  String url = "https://newsdata.io/api/1/news?apikey=pub_44332f3616e7f0cee969d7a5517d91c8d5e33&q=trending";
  var responce = await http.get(Uri.parse(url));

  var jsonData = jsonDecode(responce.body);

  if(jsonData['status']=='ok')
  {
    jsonData["articles"].forEach((element){
      if(element["urlToImage"]!=null && element['description']!=null)
      {
        SliderModel slidermodel = SliderModel(
          title: element["title"],
          description: element["description"],
          urlToImage: element["urlToImage"],
          url: element["url"],
          content: element["content"],
          author: element["author"],
        );
        sliders.add(slidermodel);
      }
    });
  }
}

}