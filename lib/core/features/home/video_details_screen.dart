
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qtec_task/core/features/home/model/vidoe_resonse.dart';
import 'package:qtec_task/core/theme/color_scheme.dart';
import 'package:qtec_task/core/utils/hexcolor.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoDetailsScreen extends StatefulWidget {
  final Results results;

  const VideoDetailsScreen({super.key, required this.results});

  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {


  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network("${widget.results.manifest}",
        videoPlayerOptions:VideoPlayerOptions(mixWithOthers: true),);

     _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize();
    _controller.play();
    _controller.pause();
  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _controller.dispose();
    _controller.pause();
  }

  String query = "";
  final queryEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        //backgroundColor:colorScheme.surface,
        elevation: 2,
        centerTitle: true,
        title: Text(
          "Video Details",
          style: textTheme.titleMedium?.copyWith(
              color: HexColor('#855EA9'),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 200,
                child: VideoPlayer(
                _controller,
                ),
              ),
              VideoProgressIndicator(_controller, allowScrubbing: true),

              SizedBox(
                height: 24,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          "${widget.results.title}",
                          style: textTheme.bodySmall?.copyWith(
                              color: lightColorScheme.onTertiaryContainer,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Text(
                              "${widget.results.viewers} views .",
                              style: textTheme.bodySmall?.copyWith(
                                  color: Colors.black38,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),

                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "3 days ago",
                              style: textTheme.bodySmall?.copyWith(
                                  color: Colors.black38,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 8,
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Card(
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    Image.asset("assets/images/love.png",width: 24,height: 24,color: Colors.black38,),

                                    Text(
                                      "MASH ALLAH (12k)",
                                      style: textTheme.bodySmall?.copyWith(
                                          color: Colors.black38,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Card(
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    Image.asset("assets/images/love.png",width: 24,height: 24,color: Colors.black38,),

                                    Text(
                                      "LIKE (12)",
                                      style: textTheme.bodySmall?.copyWith(
                                          color: Colors.black38,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Card(
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    Image.asset("assets/images/love.png",width: 24,height: 24,color: Colors.black38,),

                                    Text(
                                      "SHARE",
                                      style: textTheme.bodySmall?.copyWith(
                                          color: Colors.black38,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Expanded(
                              child: Card(
                               elevation: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [

                                      Image.asset("assets/images/love.png",width: 24,height: 24,color: Colors.black38,),

                                      Text(
                                        "REPORT",
                                        style: textTheme.bodySmall?.copyWith(
                                            color: Colors.black38,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        SizedBox(
                          height: 8,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("assets/images/log2.png",width: 110),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("assets/images/log1.png",width: 110),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 8,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Comments 7.5K",
                                style: textTheme.bodySmall?.copyWith(
                                    color: HexColor("#718096"),
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("assets/images/log3.png",width: 32,height: 32,),
                            ),
                          ],
                        ),

                        Card(
                          child: TextFormField(
                            controller: queryEditingController,
                            decoration: InputDecoration(
                                fillColor: Colors.white38,
                                filled: true,
                                contentPadding: EdgeInsets.all(16),
                                hintText: "Add Comment",
                                hintStyle: textTheme.bodyMedium
                                    ?.copyWith(color: HexColor("#BCC2EB")),
                                suffixIcon: query.isBlank == true || query.isEmpty
                                    ? Icon(
                                  FluentIcons.play_12_filled,
                                  color: HexColor("#BCC2EB"),
                                )
                                    : IconButton(
                                    icon: Icon(Icons.close, color: HexColor("#BCC2EB")),
                                    onPressed: () {
                                      //clear query
                                      setState(() {
                                        query = "";
                                      });
                                      queryEditingController.clear();
                                      FocusScope.of(context).unfocus();
                                    })

                            ),
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              setState(() {
                                query = value;
                              });

                            },
                          ),
                        ),

                        SizedBox(
                          height: 8,
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset("assets/images/user_im.png",width: 32,height: 32,),
                                ),

                                Column(
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        "Fahmida khanom",
                                        style: textTheme.bodySmall?.copyWith(
                                            color: HexColor("#718096"),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ],
                                ),


                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    "2 days ago",
                                    style: textTheme.bodySmall?.copyWith(
                                        color: HexColor("#718096"),
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),

                              ],
                            ),

                            Center(
                              child: Text(
                                "হুজুরের বক্তব্য গুলো ইংরেজি তে অনুবাদ করে সারা পৃথিবীর মানুষদের কে শুনিয়ে দিতে হবে। কথা গুলো খুব দামি",
                                style: textTheme.bodySmall?.copyWith(
                                    color: HexColor("#4A5568"),
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
