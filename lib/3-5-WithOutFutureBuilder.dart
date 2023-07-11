import 'package:api/Api/Api-Routeds/Dart_file.dart';
import 'package:api/Model/Response/Product_response_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WithOutFutureBuilder extends StatefulWidget {
  const WithOutFutureBuilder({Key? key}) : super(key: key);

  @override
  State<WithOutFutureBuilder> createState() => _WithOutFutureBuilderState();
}

class _WithOutFutureBuilderState extends State<WithOutFutureBuilder> {
  var data;
  ProductResponseModel? productResponseModel;
  bool loading = false;
  Future<ProductResponseModel> getdata() async {
    setState(() {
      loading = true;
    });
    http.Response response = await http.get(
      Uri.parse(
        (ApiRoutes.products),
      ),
    );
    if (response.statusCode == 200) {
      productResponseModel = productResponseModelFromJson(response.body);
    } else {
      print(response.statusCode);
    }
    setState(() {
      loading = false;
    });
    return productResponseModel!;
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: loading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: 30,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 2 / 2.4),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      height: 150,
                      width: 200,
                      margin: const EdgeInsets.symmetric(horizontal: 11),
                      child: Image.network(
                        productResponseModel!.products[index].thumbnail,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      productResponseModel!.products[index].title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "Price : \$${productResponseModel!.products[index].price}",
                    ),
                  ],
                );
              },
            ),
    ));
  }
}
