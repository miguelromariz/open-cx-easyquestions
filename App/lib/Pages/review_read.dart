import 'package:app/API/db_review.dart';
import 'package:app/API/db_talk.dart';
import 'package:app/Components/error.dart';
import 'package:app/Components/loggedin_topbar.dart';
import 'package:app/Model/review.dart';
import 'package:app/Notifiers/notifier_auth.dart';
import 'package:app/Notifiers/notifier_review.dart';
import 'package:app/Notifiers/notifier_talk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReadReview extends StatefulWidget{
  @override
  _ReadReviewState createState() => _ReadReviewState();
}

class _ReadReviewState extends State<ReadReview>{
  initState(){
    TalkNotifier talkNotifier = Provider.of<TalkNotifier>(context, listen: false);
    ReviewNotifier reviewNotifier = Provider.of<ReviewNotifier>(context, listen: false);

    loadReviews(reviewNotifier);
    getTalkRelatedReviews(talkNotifier, reviewNotifier);
  }

  createAlertDialog(BuildContext context){
    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("Only admins can do that!"),
      );
    });
  }

  createAlertDialog2(BuildContext context,List<Review> reviewsToDisplay,int index){
    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("Press button to confirm!"),
        content: RaisedButton.icon(onPressed: () async {
          await Firestore.instance.collection('Reviews').document(reviewsToDisplay[index].idDoc).delete();
          Navigator.of(context).pop();
        },
            icon: Icon(Icons.check), label: Text('Confirm')),
      );
    });
  }

  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    TalkNotifier talkNotifier = Provider.of<TalkNotifier>(context, listen: false);

    List<Review> reviewsToDisplay = talkNotifier.currentTalk.reviews;
    talkNotifier.currentTalk.reviews=[];

    return Scaffold(
      appBar: loggedin_topBar(authNotifier, context),
      body: reviewsToDisplay.isEmpty ? noDataToShow() : displayReviews(reviewsToDisplay,authNotifier),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          displayReviews(reviewsToDisplay, authNotifier);
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget displayReviews(List<Review> reviewsToDisplay,AuthNotifier authNotifier){
    return ListView.separated(

      itemCount: reviewsToDisplay.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (BuildContext context, int index)
      {
        var _onPressed;
        if( authNotifier.user.permission == 2){
          _onPressed = ()  {
            createAlertDialog2(context, reviewsToDisplay, index);
          };
        }
        if(authNotifier.user.permission == 0 || authNotifier.user.permission == 1 ){
          _onPressed = () {
            createAlertDialog(context);
          };
        }
        return ListTile(
          leading: CircleAvatar(
            child: Text("$index"),
          ), //maybe use profile's image instead of index
          isThreeLine: true,
          title: Text(reviewsToDisplay[index].authorUsername + " says...",
          style: TextStyle(

          ),),
          subtitle: Text(reviewsToDisplay[index].body),
          //add data
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: _onPressed,
          )
        );
      },


    );
  }

}

