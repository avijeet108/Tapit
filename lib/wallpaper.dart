import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tapit/fullscreen.dart';

class Wallpaper extends StatefulWidget {
  final String? cat;

  Wallpaper({this.cat});

  @override
  _WallpaperState createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  bool isloading = true;
  List images = [];
  int page = 1;

  @override
  void initState() {
    super.initState();
    fetchapi();
  }

  fetchapi() async {
    final String? x = widget.cat;

    await http.get(
        Uri.parse('https://api.pexels.com/v1/search?query=$x&per_page=80'),
        headers: {
          'Authorization':
              '563492ad6f91700001000001a27a89b5c4cb42d19e80132cc0c44362'
        }).then((value) {
      Map res = jsonDecode(value.body);
      setState(() {
        images = res['photos'];
        isloading = false;
      });
    });
  }

  loadmore() async {
    final String? x = widget.cat;
    setState(() {
      page = page + 1;
    });

    String url = 'https://api.pexels.com/v1/search?query=$x&per_page=80&page=' +
        page.toString();

    await http.get(Uri.parse(url), headers: {
      'Authorization':
          '563492ad6f91700001000001a27a89b5c4cb42d19e80132cc0c44362'
    }).then((value) {
      Map res = jsonDecode(value.body);
      setState(() {
        images.addAll(res['photos']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text('Tapit'),
      ),
      body: Stack(
        children: [
          isloading
              ? Center(child: CircularProgressIndicator())
              : GridView.builder(
                  itemCount: images.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2 / 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FullScreen(
                                    imageurl: images[index]['src']['large2x'],
                                  )));
                    },
                    child: Container(
                      child: Image.network(
                        images[index]['src']['medium'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100.0,
              child: TextButton(
                onPressed: loadmore,
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    height: 60.0,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Tapit to load more',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
