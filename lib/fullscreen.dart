import 'package:flutter/material.dart';
import 'package:tapit/wallpaper.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class FullScreen extends StatefulWidget {
  final String imageurl;

  const FullScreen({Key? key, this.imageurl = ""}) : super(key: key);

  @override
  _FullScreenState createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  bool isloading = false;
  Future<void> setwallpaper(int x) async {
    int location;
    if (x == 1)
      location = WallpaperManager.HOME_SCREEN;
    else
      location = WallpaperManager.LOCK_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imageurl);
    String result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  change() {
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tapit'),
        backgroundColor: Colors.black12,
      ),
      body: isloading
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.imageurl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setwallpaper(1);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.indigoAccent,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              height: 50.0,
                              child: Center(
                                child: Text(
                                  'Set as Homescreen',
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setwallpaper(0);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.indigoAccent,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              height: 50.0,
                              child: Center(
                                child: Text(
                                  'Set as Lockscreen',
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
              ],
            ),
    );
  }
}
