import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Calculator Cicilan',
    home: SIForm(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData( //diberikan untuk memberikan tema pada aplikasi
        brightness: Brightness.dark,//warna aplikasi menjadi gelap background nya dengan mengubah brightness menjadi dark
        primaryColor: Colors.pink,//ini memberikan warna pada bagian title
        accentColor: Colors.pinkAccent), //disini memberikan warna pada bagian accent text editor saat dipilih
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formKey = GlobalKey<FormState>();
  final _minimumPadding = 5.0;
  var _currentItemSelected = '';

  //ini adalah bagian form text editing
  TextEditingController pinjamanController = TextEditingController();
  TextEditingController bungaController = TextEditingController();
  TextEditingController lamaController = TextEditingController();

  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    TextStyle textStyle = Theme.of(context).textTheme.headline6;

    return Scaffold(
//      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true, //agar tulisan title berada di tengah
        title: Text("Calculator Cicilan"),//tulisan dari title
      ),

      //berikut adalah bagian dari body
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(_minimumPadding * 2),//memberikan jarak pada bagian samping kanan kiri
          child: ListView(
            children: <Widget>[
              getImageAsset(),
              Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: TextFormField( //ini adalah bagian text form untuk memasukkan total pinjaman
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: pinjamanController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Mohon masukkan total pinjaman';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Pinjaman',
                      hintText: 'Masukkan Pinjaman',
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,//digunakan warna untuk text validation
                        fontSize: 15.0,
                      ),
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: TextFormField( // bagian dimana text form untuk memasukkan bunga
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: bungaController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Mohon masukkan persen bunga cicilan';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Bunga',
                      hintText: 'Bunga dalam bentuk persen',
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField( //bagian text formfield untuk memasukkan lama waktu
                        keyboardType: TextInputType.number,
                        style: textStyle,
                        controller: lamaController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Masukkan Lama Cicilan';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Waktu',
                            hintText: 'lama cicilan dalam tahun',
                            labelStyle: textStyle,
                            errorStyle: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 15.0,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: Row( //menggunakan row agar tombol nya berada sejajar kanan kiri
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton( // digunakan untuk tombol agar terlihat timbul
                          //color: Theme.of(context).accentColor,
                          //textColor: Theme.of(context).primaryColorDark,
                          child: Text(
                            "Hitung",
                            textScaleFactor: 1.5, //untuk ukuran font dari tulisan di tombol
                          ),
                          onPressed: () {
                            setState(() {
                              if (_formKey.currentState.validate()) {
                                this.displayResult = _calculateTotalReturns();
                              }
                            });
                          }),
                    ),
                    Expanded(
                      child: ElevatedButton(
                          //color: Theme.of(context).primaryColorDark,
                          //textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            "Ulangi",
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              _reset();
                            });
                          }),
                    ),
                  ],
                ),
              ),
              Padding( // bagian dimana ditampilkan hasil dari penghitungan bunga cicilan
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: Text(
                  this.displayResult,
                  style: textStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageAsset() { //bagian dimana dimasukkan nya gambar untuk tampilan paling atas
    AssetImage assetImage = AssetImage('images/money.png'); // letak lokasi gambar
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );

    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10),
    );
  }

  String _calculateTotalReturns() { // bagian dimana dilakukan penghitungan
    double pinjaman = double.parse(pinjamanController.text);
    double bunga = double.parse(bungaController.text);
    double lama = double.parse(lamaController.text);

    double totalpengembalianuang = pinjaman + (pinjaman * bunga * lama) / 100;

    String result =
        'Setelah $lama Tahun, Total yang anda bayarkan selama mencicil adalah Rp.$totalpengembalianuang $_currentItemSelected';

    return result;
  }

  void _reset() {
    pinjamanController.text = '';
    bungaController.text = '';
    lamaController.text = '';
    displayResult = '';

  }
}