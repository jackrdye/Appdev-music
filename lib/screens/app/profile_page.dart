import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_app/models.dart';

class ProfilePage extends StatefulWidget {
  Profile profile;
  ProfilePage({super.key, required this.profile});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    super.initState();

    

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width, 
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            decoration: BoxDecoration(
              color: Colors.grey[300]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Profile", style: TextStyle(fontSize: 24),),
                InkWell(
                  onTap: () {
                    // openTextField(context);
                    
                  },
                  child: Icon(Icons.add)
                )
              ],
            ),
          ),
          // Expanded(
            // child: PlaylistList(playlistsInfo: playlistsInfo)
          // ),
        ],
      ),
    );
  }
}