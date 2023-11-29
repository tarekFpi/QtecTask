
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qtec_task/core/features/home/model/vidoe_resonse.dart';
import 'package:qtec_task/core/features/home/video_details_screen.dart';
import 'package:qtec_task/core/features/home/vidoe_controller.dart';
import 'package:qtec_task/core/theme/color_scheme.dart';
import 'package:qtec_task/core/utils/hexcolor.dart';
import 'package:qtec_task/core/widgets/custom_error_widget.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  final homeController = Get.put(HomeController());

  final queryEditingController = TextEditingController();

  String query = "";

  void goToDetails(Results resultResponse){

    FocusScope.of(context).unfocus();

     Get.to(() => VideoDetailsScreen(
      results: resultResponse,
    ));

  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(child: Scaffold(
      appBar:AppBar(
        backgroundColor:colorScheme.surfaceVariant,
        elevation: 2,
        centerTitle: true,
        title: Text("Trending Video ",
          style: textTheme.titleMedium?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),),

      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [

            Card(
              child: TextFormField(
                controller: queryEditingController,
                decoration: InputDecoration(
                    fillColor: Colors.white38,
                    filled: true,
                    contentPadding: EdgeInsets.all(16),
                    hintText: "Search...For..title",
                    prefixIcon: Icon(
                      Icons.search,
                      color: HexColor('#855EA9'),
                    ),

                    hintStyle: textTheme.bodyMedium
                        ?.copyWith(color: HexColor("#BCC2EB")),
                    suffixIcon: query.isBlank == true || query.isEmpty
                        ? Icon(
                      FluentIcons.search_24_regular,
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
                          homeController.filterUserList(null);
                        })

                ),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                 homeController.filterUserList(value);
                },
              ),
            ),

            Expanded(
              child: homeController.obx((state) =>
                  RefreshIndicator(onRefresh: homeController.showCourseList, child: ListView.builder(
                      itemCount: state!.length,
                      itemBuilder: (BuildContext context,index){

                        final item = state[index];


                        return InkWell(
                          splashColor: Colors.transparent,
                          onTap: (){
                            goToDetails(item);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [


                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                     /* SizedBox(
                                          height: 200,
                                          child: Image.network("${item.thumbnail}")),
                                      */

                                       VideoItem(manifest: '${item.manifest}',),

                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset("assets/images/ellipse.png",width: 32,height: 32,),
                                          ),

                                          Expanded(
                                            child: Text(
                                              "${item.title}",
                                              style: textTheme.bodySmall?.copyWith(
                                                  color: lightColorScheme.onTertiaryContainer,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                                 textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),

                                          Image.asset("assets/images/more1.png",width: 24,height: 24,color: Colors.black38,)
                                        ],
                                      ),

                                      SizedBox(
                                        height: 8,
                                      ),


                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          Text(
                                            "${item.viewers} views .",
                                            style: textTheme.bodySmall?.copyWith(
                                                color: Colors.black38,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),

                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            "${DateFormat("EEE MMM,d,yyyy H:mm:ss").format(
                                              DateTime.parse("${item.dateAndTime}"),
                                            )}",
                                            style: textTheme.bodySmall?.copyWith(
                                                color: Colors.black38,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      })),onError: (msg) {
                return CustomErrorWidget(
                    icon: Icon(
                      msg == "No Internet." ? FluentIcons.wifi_off_24_regular : FluentIcons.error_circle_24_filled,
                      color: Colors.red,
                      size: 40,
                    ),
                    btnLevel: "Retry",
                    message: msg.toString(),
                    onClick: () {
                      homeController.showCourseList();
                    });
              }),
            ),
          ],
        ),
      ),
    ));
  }


}



class VideoItem extends StatefulWidget {

  final String manifest;
  const VideoItem({super.key, required this.manifest});

  @override
  State<VideoItem> createState() => _VideoItem1State();
}

class _VideoItem1State extends State<VideoItem> {

  late VideoPlayerController _controller;


 @override
  void initState() {

    super.initState();

    videoPlayer();
  }

  void videoPlayer() async{

    _controller = VideoPlayerController.network("${widget.manifest}");

    _controller.addListener(() {

      setState(() {});

     // Text("${_controller.value.duration}",style: TextStyle(color: Colors.red),);
    });


    _controller.setLooping(true);
    _controller.initialize();
    _controller.play();
    _controller.setVolume(0);
  }

  @override
  Widget build(BuildContext context) {
       return SizedBox(
        height: 200,
        child:Stack(
          children: [
            VideoPlayer(_controller),

            Positioned(child: Align(
              alignment: Alignment.bottomRight,
                child: Text(_controller.value.duration.toString(),style:
                 TextStyle(fontSize: 14,color: Colors.white,
                    fontWeight: FontWeight.w400),)))
          ],
        ));
  }
}






