import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:trendify/models/article_model.dart';
import 'package:trendify/models/show_category.dart';
import 'package:trendify/pages/article_view.dart';
import 'package:trendify/services/show_category_news.dart';

class CategoryNews extends StatefulWidget {
  String name;
  CategoryNews({required this.name});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCategoryModel> categories = [];
  bool _loading = true;
  String selectedCountry = 'us'; // Default country

  List<String> countries = ['us', 'gr', 'in', 'nl', 'za', 'au', 'hk', 'nz', 'kr', 'at', 'hu', 'ng', 'se',]; // Example list of countries

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    setState(() {
      _loading = true;
    });
    ShowCategoryNews showCategoryNews = ShowCategoryNews();
    await showCategoryNews.getCategoriesNews(selectedCountry, widget.name.toLowerCase());
    categories = showCategoryNews.categories;

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          DropdownButton<String>(
            value: selectedCountry,
            icon: Icon(Icons.arrow_downward, color: Colors.white),
            underline: Container(
              height: 2,
              color: Colors.transparent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                selectedCountry = newValue!;
                getNews();
              });
            },
            items: countries.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value.toUpperCase(), style: TextStyle(color: Colors.black)),
              );
            }).toList(),
          ),
        ],
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ShowCategory(
                  Image: categories[index].urlToImage!,
                  title: categories[index].title!,
                  desc: categories[index].description!,
                  url: categories[index].url!,
                );
              },
            ),
    );
  }
}

class ShowCategory extends StatelessWidget {
  String Image, title, desc, url;
  ShowCategory({required this.Image, required this.title, required this.desc, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleView(blogUrl: url),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: Material(
          elevation: 3.0,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: CachedNetworkImage(
                      imageUrl: Image,
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      fit: BoxFit.cover),
                ),
                SizedBox(height: 5.0),
                Text(
                  title,
                  style: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
                  maxLines: 2,
                ),
                SizedBox(height: 5.0),
                Text(
                  desc,
                  maxLines: 3,
                ),
                SizedBox(height: 30.0)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
