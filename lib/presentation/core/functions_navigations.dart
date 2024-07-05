import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

kNavigationPush(BuildContext context,Widget screen){
  Navigator.push(context, MaterialPageRoute(builder: (context) =>screen,));
}

kNavigationPushReplacement(BuildContext context,Widget screen){
 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>screen,));
}

kNavigationPushRemoveUntil(BuildContext context,Widget screen){
 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>screen,), (route) => false);
}


kSnakBar(BuildContext context,String content,Color clr){
    ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
               backgroundColor:Colors.transparent ,
              content:Container( 
                decoration:BoxDecoration( 
                  color: clr, 
                  borderRadius:BorderRadius.circular(5)  
                   ) ,
                height: 40,
                width:double.infinity ,
                child: Center(child: Text(content,style:const TextStyle(fontWeight: FontWeight.bold),)),
              )
            ),
          );
}

kPop(BuildContext context){
   Navigator.pop(context);
}

kShowDialog(
  {
  required BuildContext context,
  required String title,
  required String contentTxt,
  required String actionBtn1Txt,
  required String actionBtn2Txt,
  required void Function()? onPressed
  }
){
    showDialog(
            context: context,
             builder: (context) {
               return AlertDialog(
                 title: Text(title),
                 content: Text(contentTxt),
                 actions: [
                  TextButton(onPressed: (){
                   Navigator.pop(context);
                  },
                   child: Text(actionBtn1Txt)),
                   TextButton(
                    onPressed:onPressed,
                   child: Text(actionBtn2Txt)), 

                 ], 
               );
             }, 
             ); 
} 

 
String kFormatTimestamp(String timestamp) {
  try {
    DateTime parsedDate = DateTime.parse(timestamp).toLocal();
    
    String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);
    String formattedTime = DateFormat('hh:mm a').format(parsedDate);
    
    return 'date: $formattedDate time: $formattedTime';
  } catch (e) {
 
    return 'Invalid timestamp';
  }
}




Widget kCircleIndicator = const Center(child:CircularProgressIndicator(),);