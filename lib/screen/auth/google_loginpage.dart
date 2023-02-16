import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constant/rout_page.dart';
import '../../controllar/google_provider.dart';
class GoogleLoginScreen extends StatelessWidget {
  const GoogleLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final GoogleLogin controllar = Provider.of<GoogleLogin>(context,listen: false);
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: AppBar().preferredSize,
        child:
        NewAppBar.buildAppBar(name: "Login"),
      ),
      //Ui Page Desing
      // data
      //git addgit
      body:

      Consumer<GoogleLogin>(builder: ((context, value, child) {

        return

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: InkWell(
                onTap: (){
                  value.login(context);
                },
                child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.blue)

                    ),
                    child:
                    value.loading?Center(child: CircularProgressIndicator(),):
                    value.loading
                        ? Center(
                      child: CircularProgressIndicator(),
                    )
                        :  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(image:AssetImage("image/googleimage.png",),height: 50,width: 50,),
                        Text('Login',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      ],
                    )




                ),
              ),
            ),

          ],
        );
      }))


    );
    
  }
}
