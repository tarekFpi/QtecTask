
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qtec_task/core/features/home/model/vidoe_resonse.dart';
import 'package:qtec_task/core/network/dio_client.dart';
import 'package:qtec_task/core/utils/toast.dart';
import 'package:dio/dio.dart';

class HomeController extends GetxController with StateMixin<List<Results>>{

  final dioClient = DioClient.instance;

  final courselist = <Results>[].obs;

  final storage = GetStorage();

  final dio = Dio();

  @override
  void onInit() {

    showCourseList();
  }

  Future<void> showCourseList() async{

    try {

      change(null, status: RxStatus.loading());

     /* final res = await dioClient.get("trending-video/1",
        options: Options(headers: {"Content-Type": "application/json"},
             ),);*/

      final res = await dio.get('https://test-ximit.mahfil.net/api/trending-video/1');

      final video_response = VidoeResonse.fromJson(res.data);


        final list = video_response.results ?? [];

        if(courselist.isEmpty){

          change(null, status: RxStatus.empty());
        }

        courselist.assignAll(list);

       change(courselist, status: RxStatus.success());

    } catch(e) {

      Toast.errorToast("${e.toString()}");

      debugPrint(e.toString());

      change(null, status: RxStatus.error(e.toString()));
    }
  }


  void filterUserList(String? query) {

    if (query == null || query.isEmpty) {

      change(courselist.value, status: RxStatus.success());

    }else{

      try {

        final list = courselist.value
            .where((element) =>
            element.title!
                .toLowerCase()
                .contains(query!.toLowerCase().trim()))
            .toList();

        if (list.isEmpty) {
          change([], status: RxStatus.empty());
        } else {
          change(list, status: RxStatus.success());
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

}