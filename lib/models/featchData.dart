import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:twitter/components/constants.dart';
import 'package:twitter/main.dart';
import 'package:twitter/models/tweet_model.dart';

class FetchData {
  var header = {
    'Authorization': 'Bearer ' + preferences!.get('token').toString()
  };
  Future<List<TweetModel>?> fetchTweets() async {
    var url = Uri.parse(TWEETS_URL);
    http.Response response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      print(response.body);
      var body = jsonDecode(response.body);

      List<TweetModel> tweets = [];
      for (var tweet in body) {
        tweets.add(TweetModel.fromJson(tweet));
      }
      return tweets;
    } else {
      print(response.statusCode);
    }
    return null;
  }
}
