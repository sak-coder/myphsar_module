//
// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';
//
//
// class QRCodeGenerator extends StatelessWidget {
//   const QRCodeGenerator({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
// 	    body: Container(
// 		    width: MediaQuery.of(context).size.width,
// 				height: MediaQuery.of(context).size.height,
// 	      child: Column(
// 	        children: [
// 	          const Text("data"),
// 	      Center(
// 	      		    child: Padding(
// 	      		      padding: const EdgeInsets.only(top: 100),
// 	      		      child: QrImageView(
// 				           backgroundColor: Colors.white,
// 	      		      	      			    data: "https://www.google.com/maps?q=11.516077084087765,104.85513352458534",
// 	      		      	      			    size: 400,
// 	      		      	      			    // You can include embeddedImageStyle Property if you
// 	      		      	      			    //wanna embed an image from your Asset folder
// 	      		      	      			    embeddedImageStyle: const QrEmbeddedImageStyle(
//
// 	      		      	      				    size: Size(
// 	      		      	      					    100,
// 	      		      	      					    100,
// 	      		      	      				    ),
// 	      		      	      			    ),
// 	      		      ),
// 	      		    ),
// 	      ) ],
// 	      ),
// 	    ),
//     );
//   }
// }