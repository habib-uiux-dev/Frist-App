import 'package:flutter/material.dart';
import 'package:untitled7/Style/Style.dart';
import '../Rest Api/RestClient.dart';

class ProductUpdateScreen extends StatefulWidget {
  final Map productItem;
  const ProductUpdateScreen({super.key, required this.productItem});

  @override
  State<ProductUpdateScreen> createState() => _ProductUpdateScreenState();
}

class _ProductUpdateScreenState extends State<ProductUpdateScreen> {
  late TextEditingController nameController;
  late TextEditingController codeController;
  late TextEditingController imgController;
  late TextEditingController unitPriceController;
  late TextEditingController totalPriceController;

  bool Loading = false;
  String? selectedQt;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
      text: widget.productItem['title']?.toString() ??
          widget.productItem['ProductName']?.toString() ?? "",
    );
    codeController = TextEditingController(
      text: widget.productItem['productCode']?.toString() ??
          widget.productItem['ProductCode']?.toString() ?? "P-001",
    );
    imgController = TextEditingController(
      text: widget.productItem['thumbnail']?.toString() ??
          widget.productItem['Img']?.toString() ?? "",
    );
    unitPriceController = TextEditingController(
      text: widget.productItem['price']?.toString() ??
          widget.productItem['UnitPrice']?.toString() ?? "",
    );
    totalPriceController = TextEditingController(
      text: widget.productItem['totalPrice']?.toString() ??
          widget.productItem['price']?.toString() ?? "",
    );

    selectedQt = widget.productItem['qty']?.toString() ??
        widget.productItem['Qty']?.toString();
    if (selectedQt == "" || selectedQt == null) {
      selectedQt = "1 pcs";
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    codeController.dispose();
    imgController.dispose();
    unitPriceController.dispose();
    totalPriceController.dispose();
    super.dispose();
  }

  FormOnSubmit() async {
    String productName = nameController.text.trim();
    String productCode = codeController.text.trim();
    String img = imgController.text.trim();
    String unitPrice = unitPriceController.text.trim();
    String totalPrice = totalPriceController.text.trim();
    String qty = selectedQt ?? "";

    if (productName.isEmpty) {
      ErrorToast('Product Name Required !');
    } else if (productCode.isEmpty) {
      ErrorToast('Product Code Required !');
    } else if (img.isEmpty) {
      ErrorToast('Image Link Required !');
    } else if (unitPrice.isEmpty) {
      ErrorToast('Unit Price Required !');
    } else if (totalPrice.isEmpty) {
      ErrorToast('Total Price Required !');
    } else if (qty.isEmpty) {
      ErrorToast('Qty Required !');
    } else {
      setState(() {
        Loading = true;
      });

      Map<String, String> FormValues = {
        "Img": img,
        "ProductCode": productCode,
        "ProductName": productName,
        "Qty": qty,
        "TotalPrice": totalPrice,
        "UnitPrice": unitPrice,
      };

      var id = widget.productItem['id'] ?? 1;

      // ডুপ্লিকেট রিমুভ করে সঠিক নিয়মে একবার কল করা হলো
      bool status = await ProductUpdateRequest(id, FormValues);

      setState(() {
        Loading = false;
      });

      if (status == true) {
        if (mounted) {
          Navigator.pop(context, true);
        }
      } else {
        ErrorToast('Update Failed. Try Again !');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
      ),
      body: Stack(
        children: [
          SrceenBackground(context),
          Container(
            child: Loading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: AppInputDecoration('Product Name'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: codeController,
                    decoration: AppInputDecoration('Product Code'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: imgController,
                    decoration: AppInputDecoration('Product Image'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: unitPriceController,
                    decoration: AppInputDecoration('Unit Price'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: totalPriceController,
                    decoration: AppInputDecoration('Total Price'),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: AppInputDecoration('Select Qty'),
                    value: selectedQt,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem<String>(
                          value: "1 pcs", child: Text('1 pcs')),
                      DropdownMenuItem<String>(
                          value: "2 pcs", child: Text('2 pcs')),
                      DropdownMenuItem<String>(
                          value: "3 pcs", child: Text('3 pcs')),
                    ],
                    onChanged: (Textvalue) {
                      setState(() {
                        selectedQt = Textvalue;
                      });
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
                        'Update',
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