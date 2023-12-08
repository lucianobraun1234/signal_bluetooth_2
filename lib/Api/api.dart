
import 'package:http/http.dart';

Future enviasinal() async{

  String url = 'https://192.168.4.1/25/on';
  try {
    var response = await get(Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },


    ).timeout(Duration(milliseconds: 500),


    );
}
catch(e){
    print ("erro:$e");
    }
  }

Future enviasinaldesliga() async{

  String url = 'https://192.168.4.1/25/procurar';
  try {
    var response = await get(Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },


    ).timeout(Duration(milliseconds: 500),


    );
  }
  catch(e){
    print ("erro:$e");
  }
}