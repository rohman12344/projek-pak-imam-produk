// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_application_1/modls/produk.dart';
// kODE UJI COBA
class Edit extends StatefulWidget {
  final ProdukModel sw;
  Edit({required this.sw});
  @override
  EditState createState() => EditState();
}
class EditState extends State<Edit> {
  final formkey = GlobalKey<FormState>();
  late TextEditingController kode_produkController,
      nama_produkController,
      hargaController;
      
        get http => null;
  Future editSw() async {
    var BaseUrl;
    return await http.post(
      Uri.parse(BaseUrl.edit),
      body: {
        "id": widget.sw.id.toString(),
        "kode_produk": kode_produkController.text,
        "nama_produk": nama_produkController.text,
        "harga": hargaController.text
      },
    );
  }
  

  @override
  void initState() {
    kode_produkController = TextEditingController(text: widget.sw.kode_produk);
    nama_produkController = TextEditingController(text: widget.sw.nama_produk);
     hargaController = TextEditingController(text: widget.sw.harga.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Data Produk"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          child: Text("Update"),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          onPressed: () {
            if (formkey.currentState!.validate()) {
            }
          },
        ),
      ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: AppForm(
                formkey: formkey,
                kode_produkController: kode_produkController,
                nama_produkController: nama_produkController,
                hargaController: hargaController,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

mixin ToastGravity {
  var CENTER;
}

class Toast {
  static var LENGTH_SHORT;
}

class Fluttertoast {
  static void showToast({required String msg, required toastLength, required gravity, required int timeInSecForIosWeb, required MaterialColor backgroundColor, required Color textColor, required double fontSize}) {}
}
class AppForm extends StatelessWidget {
  final GlobalKey<FormState> formkey;
  final TextEditingController kode_produkController;
  final TextEditingController nama_produkController;
  final TextEditingController hargaController;
  const AppForm({
    Key? key,
    required this.formkey,
    required this.kode_produkController,
    required this.nama_produkController,
    required this.hargaController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        children: [
          _buildTextFormField(kode_produkController, "Kode Produk", Icons.code),
          SizedBox(height: 16),
          _buildTextFormField(nama_produkController, "Nama Produk", Icons.inventory_2),
          SizedBox(height: 16),
          _buildTextFormField(
              hargaController, "Harga", Icons.payments),
          SizedBox(height: 16),
        ],
      ),
    );
  }
  Widget _buildTextFormField(
      TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Masukkan $label';
        }
        return null;
      },
    );
  }
  
}