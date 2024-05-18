import 'package:flutter/material.dart';
import 'package:trendify/models/article_model.dart';
import 'package:trendify/models/slider_model.dart';
import 'package:trendify/pages/article_view.dart';
import 'package:trendify/services/News.dart';
import 'package:trendify/services/slider_data.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AllNews extends StatefulWidget {
  String news;
  AllNews({required this.news});

  @override
  _AllNewsState createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<SliderModel> sliders = [];
  List<ArticleModel> articles = [];
  bool _loading = true;

  void initState() {
    getSlider();
    getNews();
    super.initState();
  }

  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;

    setState(() {
      _loading = false;
    });
  }

  getSlider() async {
    Sliders slider = Sliders();
    await slider.getSlider();
    sliders = slider.sliders;

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.news + " News",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
          child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: widget.news == "Breaking" ? sliders.length : articles.length,
        itemBuilder: (context, index) {
          return AllNewsSection(
            url: widget.news == "Breaking"
                ? sliders[index].url!
                : articles[index].url!,
            desc: widget.news == "Breaking"
                ? sliders[index].description!
                : articles[index].description!,
            Image: widget.news == "Breaking"
                ? sliders[index].urlToImage!
                : articles[index].urlToImage!,
            title: widget.news == "Breaking"
                ? sliders[index].title!
                : articles[index].title!,
          );
        },
      )),
    );
  }
}

class AllNewsSection extends StatelessWidget {
  String Image, title, desc, url;
  AllNewsSection(
      {required this.Image,
      required this.title,
      required this.desc,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleView(blogUrl: url),
            ));
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
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                  maxLines: 2,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  desc,
                  maxLines: 3,
                ),
                SizedBox(
                  height: 30.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
