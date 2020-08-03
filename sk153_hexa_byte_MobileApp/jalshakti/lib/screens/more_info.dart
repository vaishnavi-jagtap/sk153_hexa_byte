import 'package:flutter/material.dart';

class MoreInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Text("About Us"),
              Divider(
                height: 20,
                endIndent: MediaQuery.of(context).size.width * 0.25,
                indent: MediaQuery.of(context).size.width * 0.25,
              ),
              Text(
                  "Central Water Commission is a premier Technical Organization of India in the field of Water Resources and is presently functioning as an attached office of the Ministry of Jal Shakti, Department of Water Resources, River Development and Ganga Rejuvenation,Government of India. The Commission is entrusted with the general responsibilities of initiating, coordinating and furthering in consultation of the State Governments concerned, schemes for control, conservation and utilization of water resources throughout the country, for purpose of Flood Control, Irrigation,Navigation,Drinking Water Supply and Water Power Development."),
              Divider(
                height: 20,
                endIndent: MediaQuery.of(context).size.width * 0.25,
                indent: MediaQuery.of(context).size.width * 0.25,
              ),
              Text(
                  "As said, Flood Control is one of the many responsibilities that the department handles. For helping Ministry with this task, the app, Jal Shakti is developed. Jal Shakti app helps ministry with keeping a watch over various embankment zones, lakes, ponds and other small water bodies of the region via crowd sourced data which is to be collected from people who belong to those regions and know their region very well. Ministry can further help regions with the collected data in more enhanced way and more quicky."),
              Divider(
                height: 20,
                endIndent: MediaQuery.of(context).size.width * 0.25,
                indent: MediaQuery.of(context).size.width * 0.25,
              ),
              Text(
                  "People belonging to the particular region have to do a very simple task to help keeping their homes and water bodies safe. They just have to fill the survey form correctly and that’s it. For this to happen, after downloading the app, click on survey section. It will ask you for the permission of your location. Don’t worry, this is to just know in which zone you are. After you grant your location permission, you will be questioned on various aspects of the embankment. After answering various questions, you’ll be asked for the image of the embankment for the proof of your survey for which you’ll have to grant the camera permission.After finishing this, submit the survey with your details and that’s it. You will be done with your part of the help. Your data goes to the local authority of your region, which goes to the ministry after his/her approval. Do survey and help us to help your home and water bodies.,"),
            ],
          ),
        ),
      ),
    );
  }
}
