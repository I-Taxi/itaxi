import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:itaxi/model/post.dart';

class PostsController extends GetxController {
  // Posts 데이터 가져오기
  List<Post> PostfromJson(json) {
    List<Post> result = [];
    json.forEach((item) {
      result.add(Post.fromDocs(item));
    });

    return result;
  }

  Future<List<Post>> fetchPost(
      {required String dep, required String dst, required String time}) async {
    //?dep=${dep}&dst=${dst}&time=${time}
    var postUrl = "https://";
    postUrl = postUrl + '?dep=${dep}&dst=&{dst}&time=${time}';

    var response = await http.get(Uri.parse(postUrl));

    if (response.statusCode == 200) {
      return PostfromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load posts');
    }
  }
}