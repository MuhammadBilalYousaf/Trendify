import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/show_category.dart';

class ShowCategoryNews {
  List<ShowCategoryModel> categories = [];

  Future<void> getCategoriesNews(String country, String category) async {
    String url = "https://newsapi.org/v2/top-headlines?country=$country&category=$category&apiKey=6b2a40b1672a4c478e01f6df263e455f";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          ShowCategoryModel categoryModel = ShowCategoryModel(
            title: element["title"],
            description: element["description"],
            urlToImage: element["urlToImage"],
            url: element["url"],
            content: element["content"],
            author: element["author"],
          );
          categories.add(categoryModel);
        }
      });
    }
  }
}
