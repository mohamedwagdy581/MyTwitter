import 'package:flutter/material.dart';
import 'package:twitter/components/components.dart';
import 'package:twitter/models/featchData.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FetchData _fetchData = FetchData();
  @override
  void initState() {
    _fetchData.fetchTweets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return mainBackground(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: ListView.separated(
          itemBuilder: (context, index) => buildTweetCard(),
          separatorBuilder: (context, index) => const Divider(
            height: 6.0,
            thickness: 5.0,
          ),
          itemCount: 4,
        ),
        //const CircularProgressIndicator(),
      ),
    );
  }

  Widget buildTweetCard() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          // ListTile that have an username and user image
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.network(
                'https://img.xcitefun.net/users/2015/01/382649,xcitefun-philippines-tour-2.jpg',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            title: const Text('User Name'),
            subtitle: const Text('@username'),
          ),

          // The Text of Description of Tweeter
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'This is the tweet description that you will need to write so now lets start to write your tweet!',
              style: TextStyle(
                fontSize: 16.0,
              ),
              textAlign: TextAlign.justify,
            ),
          ),

          // Image of Tweeter
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.89,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                'https://media.gettyimages.com/photos/holiday-ham-dinner-picture-id848826320?s=612x612',
                fit: BoxFit.contain,
              ),
            ),
          ),

          //
          Row(),
        ],
      ),
    );
  }
}
