import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';


abstract class ProdukDetail extends StatefulWidget {
  final String? kodeProduk;
  final String? namaProduk;
  final int? harga;
  const ProdukDetail({Key? key, this.kodeProduk, this.namaProduk, this.harga})
      : super(key: key);
      
        get sw => null;
        
          get http => null;
// ignore: non_constant_identifier_names
class Details extends StatefulWidget {
  final ProdukModel sw;
  Details({required this.sw});

  @override
  State<StatefulWidget> createState() => _ProdukDetailState();
  DetailsState createState() => DetailsState();
}

class _ProdukDetailState extends State<ProdukDetail> {
class DetailsState extends State<Details> {
  void deleteProduk(context) async {
    http.Response response = await http.post(
      Uri.parse(BaseUrl.hapus),
      body: {
        'id': widget.sw.id.toString(),
      },
    );
    final data = json.decode(response.body);
    if (data['success']) {
      pesan();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }
  pesan() {
    Fluttertoast.showToast(
        msg: "Data berhasil dihapus :v",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  void confirmDelete(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            content: Row(
              children: [
                Icon(Icons.warning, color: Colors.red, size: 40),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Yakin mau dihapus?',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            actions: [
              ElevatedButton.icon(
                icon: Icon(Icons.cancel, color: Colors.white),
                label: Text("Batal"),
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.check_circle, color: Colors.white),
                label: Text("Hapus"),
                onPressed: () => deleteProduk(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              )
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 205, 178, 253),
      appBar: AppBar(
        title: const Text('Detail Produk'),
        title: Text('Details Produk'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text("Kode Produk: " + widget.kodeProduk.toString()),
          Text("Nama Produk: ${widget.namaProduk}"),
          Text("Harga: ${widget.harga}")
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            onPressed: () => confirmDelete(context),
            icon: Icon(Icons.delete, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ID : ${widget.sw.id}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Divider(color: Colors.grey),
                      Text(
                        "KODE PRODUK : ${widget.sw.kode_produk}",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "NAMA PRODUK : ${widget.sw.nama_produk}",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "HARGA : ${widget.sw.harga}",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit, size: 28),
        backgroundColor: Colors.indigo,
        hoverColor: Colors.greenAccent,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => Edit(sw: widget.sw),
          ),
        ),
      ),
    );
  }
}

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
} 