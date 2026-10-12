import 'package:flutter/material.dart';
import 'package:untitled7/Style/Style.dart';
import '../Rest Api/RestClient.dart';

class ProductGridViewScreen extends StatefulWidget {
  const ProductGridViewScreen({super.key});

  @override
  State<ProductGridViewScreen> createState() => _ProductGridViewScreenState();
}

class _ProductGridViewScreenState extends State<ProductGridViewScreen> {

  List ProductList = [];
  bool Loading = true;

  @override
  void initState() {
    super.initState();
    CallData();
  }

  CallData() async {
    setState(() {
      Loading = true;
    });

    var data = await ProductGridViewListRequest();

    setState(() {
      ProductList = data;
      Loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Product'),
      ),
      body: Stack(
        children: [
          SrceenBackground(context),
          Container(
            child: Loading
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
              itemCount: ProductList.length,
              gridDelegate: ProductGridGridViewStyle(),
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Image.network(
                          ProductList[index]['thumbnail']?.toString() ??
                              'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.image, size: 50, color: Colors.grey);
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(5,5,5,8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // এখানে 'ProductName'-এর বদলে 'title' দিতে হবে
                              ProductList[index]['title']?.toString() ?? 'title',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 7),
                            Text(
                              // এখানে 'UnitPrice'-এর বদলে 'price' দিতে হবে
                              "Price: \$${ProductList[index]['price']?.toString() ?? '0'}",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}