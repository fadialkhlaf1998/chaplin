import 'dart:convert';

import 'package:chaplin_new_version/controler/store.dart';
import 'package:chaplin_new_version/model/story.dart';
import 'package:chaplin_new_version/model/story_image.dart';
import 'package:http/http.dart' as http;

class StoryApi {
  static String url = "https://phpstack-548447-2379311.cloudwaysapps.com/";
  // static String url="http://10.0.2.2:3000/";
  // static String media_url="http://10.0.2.2:3000/uploads/";
  static String media_url="http://phpstack-548447-2379311.cloudwaysapps.com/uploads/";
  static Future<List<Story>> get_stories(int customer_id)async{
    var headers = {
      'Content-Type': 'application/json',
    };
    print('************');
    var request = http.Request('POST', Uri.parse(url+'get_story'));
    request.body = json.encode({
      "customer_id": customer_id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      var list = jsonDecode(jsonString) as List;
      List<Story> mylist = <Story>[];
      for(int i=0;i<list.length;i++){
        mylist.add(Story.fromMap(list[i]));
      }
      return mylist;
    }
    else {
      return <Story>[];
    }

  }
  static delete_image(int id)async{
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('DELETE', Uri.parse(url+'api/image'));
    request.body = json.encode({
      "id": id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {

    }
    else {
    }

  }
  static Future<Story?> get_my_story(int customer_id)async{
    var headers = {
      'Content-Type': 'application/json',
    };

    var request = http.Request('POST', Uri.parse(url+'my_story'));
    request.body = json.encode({
      "customer_id": customer_id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      var list = jsonDecode(jsonString) as List;
      List<Story> mylist = <Story>[];
      for(int i=0;i<list.length;i++){
        mylist.add(Story.fromMap(list[i]));
      }

      return mylist.length>0?mylist.first:null;
    }
    else {
      return null;
    }

  }
  static Future<bool> add_story(int customer_id,String path)async{
    // var headers = {
    //   'Cookie': 'connect.sid=s%3Ay2YGo4NKtRIlg7flkmPtekOtieY2mKhv.r2%2FIYIR2JL%2B29iTXg%2FR3KuVt61nXtYzfn3P6QRYwSD4'
    // };
    var request = http.MultipartRequest('POST', Uri.parse(url+'upload-avatar-single'));
    request.fields.addAll({
      'customer': customer_id.toString()
    });
    request.files.add(await http.MultipartFile.fromPath('file', path));
    // request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
    return true;
    }
    else {
    print(response.reasonPhrase);
    return false;
    }

  }
  static Future<List<MyStoryImage>> get_images(int story_id)async{
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url+'get_story_image'));
    request.body = json.encode({
      "story_id": story_id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      var list = jsonDecode(jsonString) as List;
      List<MyStoryImage> mylist = <MyStoryImage>[];
      for(int i=0;i<list.length;i++){
        mylist.add(MyStoryImage.fromMap(list[i]));
      }
      return mylist;
    }
    else {
      return <MyStoryImage>[];
    }

  }
  static read_story(int story_id,int customer_id)async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'read_story'));
    request.body = json.encode({
      "story_id": story_id,
      "customer_id": customer_id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }

  }
}