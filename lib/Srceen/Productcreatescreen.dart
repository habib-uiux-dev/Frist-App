import 'package:flutter/material.dart';
import 'package:untitled7/Style/Style.dart';

import '../Rest Api/RestClient.dart';
// আপনার এপিআই রিকোয়েস্ট ফাইলটি এখানে ইমপোর্ট করে নেবেন (যদি আলাদা ফাইলে থাকে)
// import 'path_to_your_api_file.dart';

class ProductCreateScreen extends StatefulWidget {
  const ProductCreateScreen({super.key});

  @override
  State<ProductCreateScreen> createState() =>
      _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  String selectedQt = "";

  Map<String, String> FormValues = {
    "Img": "",
    "ProductCode": "",
    "ProductName": "",
    "Qty": "",
    "TotalPrice": "",
    "UnitPrice": ""
  };

  bool Loading=false;

  InputOnChange(key, Textvalue) {
    setState(() {
      FormValues[key] = Textvalue;
    });
  }

  FormOnSubmit() async {
    if (FormValues['ProductName']!.isEmpty) {
      ErrorToast('Product Name Required !');
    }
    else if (FormValues['ProductCode']!.isEmpty) {
      ErrorToast('Product Code Required !');
    }
    else if (FormValues['Img']!.isEmpty) {
      ErrorToast('Image Link Required !');
    }
    else if (FormValues['UnitPrice']!.isEmpty) {
      ErrorToast('Unit Price Required !');
    }
    else if (FormValues['TotalPrice']!.isEmpty) {
      ErrorToast('Total Price Required !');
    }
    else if (FormValues['Qty']!.isEmpty) {
      ErrorToast('Qty Required !');
    }
    else {
      // Opening Load
      setState(() {
        Loading = true;
      });

      // Wait for API
      await ProdductCreateRequest(FormValues);

      // Srceen of Refresh
      setState(() {
        Loading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Product'),
      ),
      body: Stack(
        children: [
          SrceenBackground(context),
          Container(
            child: Loading?(Center(child: CircularProgressIndicator(),)):
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),


              child: Column(
                children: [
                  TextFormField(
                    decoration: AppInputDecoration('Product Name'),
                    onChanged: (Textvalue) {
                      InputOnChange("ProductName", Textvalue);
                    },
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    decoration: AppInputDecoration('Product Code'),
                    onChanged: (Textvalue) {
                      InputOnChange("ProductCode", Textvalue);
                    },
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    decoration: AppInputDecoration('Product Image'),
                    onChanged: (Textvalue) {
                      InputOnChange("Img", Textvalue);
                    },
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    decoration: AppInputDecoration('Unit Price'),
                    onChanged: (Textvalue) {
                      InputOnChange("UnitPrice", Textvalue);
                    },
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    decoration: AppInputDecoration('Total Price'),
                    onChanged: (Textvalue) {
                      InputOnChange("TotalPrice", Textvalue);
                    },
                  ),
                  const SizedBox(height: 20),

                  DropdownButtonFormField<String>(
                    decoration: AppInputDecoration('Select Qt'),
                    value: selectedQt.isEmpty ? "" : selectedQt,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(
                        value: "",
                        child: Text('Select Qty'),
                      ),
                      DropdownMenuItem(value: "1 pcs", child: Text('1 pcs')),
                      DropdownMenuItem(value: "2 pcs", child: Text('2 pcs')),
                      DropdownMenuItem(value: "3 pcs", child: Text('3 pcs')),
                    ],
                    onChanged: (Textvalue) {
                      setState(() {
                        selectedQt = Textvalue!;
                      });
                      InputOnChange("Qty", Textvalue);
                    },
                    iconEnabledColor: Colors.black,
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: AppButtonStyle(),
                      onPressed: () {
                        FormOnSubmit();
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}