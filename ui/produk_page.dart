import 'dart:convert'; // Untuk decode JSON
import 'package:http/http.dart' as http; // Untuk HTTP request
import 'package:produk/models/api.dart'; // Pastikan ini diimpor untuk URL API
import 'package:produk/models/mproduk.dart';

class ProdukPage extends StatefulWidget {
class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ProdukPageState();
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class _ProdukPageState extends State<ProdukPage> {
  List produkList = []; // List untuk menyimpan produk yang diterima
  // Fungsi untuk mengambil data produk dari API
  Future<List> fetchProduk() async {
    final response = await http.get(Uri.parse(BaseUrl.data)); // URL API
    if (response.statusCode == 200) {
      // Jika server merespons dengan status 200 (OK), ambil data produk
      return json.decode(response.body); // Decode JSON menjadi List
    } else {
      throw Exception('Failed to load data');
    }
  }
class HomeState extends State<Home> {
  late Future<List<ProdukModel>> produkList;

  @override
  void initState() {
    super.initState();
    // Ambil data produk saat pertama kali halaman dimuat
    fetchProduk().then((data) {
      setState(() {
        produkList = data; // Menyimpan produk yang diterima
      });
    });
    produkList = getProdukList();
  }

  // Fungsi untuk menambah produk baru
  void addProduk(Map newProduk) {
    setState(() {
      produkList.add(newProduk); // Menambahkan produk baru ke dalam list
    });
  Future<List<ProdukModel>> getProdukList() async {
    final response = await http.get(Uri.parse(BaseUrl.data));
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<ProdukModel> produkList = items.map<ProdukModel>((json) {
      return ProdukModel.fromJson(json);
    }).toList();
    return produkList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Data Produk'),
        title: Text("List Produk"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          GestureDetector(
            child: const Icon(Icons.add),
            onTap: () async {
              // Navigasi ke halaman form dan tunggu data yang kembali
              var result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProdukForm()),
              );
              if (result != null) {
                // Jika data diterima, tambahkan ke list produk
                addProduk(result);
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: produkList.length,
        itemBuilder: (context, index) {
          var produk = produkList[index];
          return ItemProduk(
            kodeProduk: produk['kode_produk'],
            namaProduk: produk['nama_produk'],
            harga: produk['harga'],
          );
        },
        backgroundColor: Colors.indigo, // Warna yang lebih segar
      ),
    );
  }
}
class ItemProduk extends StatelessWidget {
  final String? kodeProduk;
  final String? namaProduk;
  final int? harga;
  const ItemProduk({Key? key, this.kodeProduk, this.namaProduk, this.harga})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[50]!, Colors.blue[100]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Kode Produk dan Nama Produk
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kode: ${kodeProduk ?? 'N/A'}',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
        child: FutureBuilder<List<ProdukModel>>(
          future: produkList,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.indigo,
                ),
              );
            }
            if (snapshot.data.isEmpty) {
              return Center(
                child: Text(
                  "Tidak ada data produk.",
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                return Card(
                  elevation: 6, // Penambahan bayangan
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  Text(
                    namaProduk ?? 'Nama Produk',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo,
                      child: Icon(Icons.shopping_cart, color: Colors.white),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    title: Text(
                      "${data.kode_produk} - ${data.nama_produk}",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Harga: Rp ${data.harga}",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(sw: data),
                        ),
                      );
                    },
                  ),
                ],
              ),
              // Harga Produk
              Text(
                'Rp ${harga?.toString() ?? '0'}',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.green,
                ),
              ),
            ],
          ),
                );
              },
            );
          },
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProdukDetail(
              kodeProduk: kodeProduk,
              namaProduk: namaProduk,
              harga: harga,
            ),
          ),
        );
      },
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 28),
        backgroundColor: Colors.indigo,
        hoverColor: Colors.greenAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) {
              return ProdukForm();
            }),
          );
        },
      ),
    );
  }
}
}