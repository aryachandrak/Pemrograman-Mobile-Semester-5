import 'package:flutter/material.dart';
import 'pizza.dart';
import 'httphelper.dart';

class PizzaDetailScreen extends StatefulWidget {
  final Pizza pizza;
  final bool isNew;
  const PizzaDetailScreen(
      {super.key, required this.pizza, required this.isNew});
  @override
  State<PizzaDetailScreen> createState() => _PizzaDetailScreenState();
}

class _PizzaDetailScreenState extends State<PizzaDetailScreen> {
  final TextEditingController txtId = TextEditingController();
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtPrice = TextEditingController();
  final TextEditingController txtImageurl = TextEditingController();
  String operationResult = '';

  Future postPizza() async {
    HttpHelper helper = HttpHelper();
    Pizza pizza = Pizza();
    pizza.id = int.tryParse(txtId.text);
    pizza.pizzaName = txtName.text;
    pizza.description = txtDescription.text;
    pizza.price = double.tryParse(txtPrice.text);
    pizza.imageUrl = txtImageurl.text;
    String result = await helper.postPizza(pizza);
    setState(() {
      operationResult = result;
    });
  }

  Future putPizza() async {
    HttpHelper helper = HttpHelper();
    Pizza pizza = Pizza();
    String result = await helper.putPizza(pizza);
    setState(() {
      operationResult = result;
    });
  }

  Future savePizza() async {
    HttpHelper helper = HttpHelper();
    Pizza pizza = Pizza();
    final result =
        await (widget.isNew ? helper.postPizza(pizza) : helper.putPizza(pizza));
    setState(() {
      operationResult = result;
    });
  }

  @override
  void initState() {
    if (!widget.isNew) {
      txtId.text = widget.pizza.id.toString();
      txtName.text = widget.pizza.pizzaName.toString();
      txtDescription.text = widget.pizza.description.toString();
      txtPrice.text = widget.pizza.price.toString();
      txtImageurl.text = widget.pizza.imageUrl.toString();
    }
    super.initState();
  }

  @override
  void dispose() {
    txtId.dispose();
    txtName.dispose();
    txtDescription.dispose();
    txtPrice.dispose();
    txtImageurl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pizza Detail Arya'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                operationResult,
                style: TextStyle(
                    backgroundColor: Colors.green[200], color: Colors.black),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: txtName,
                decoration: const InputDecoration(hintText: 'Insert Name'),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: txtDescription,
                decoration:
                    const InputDecoration(hintText: 'Insert Description'),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: txtPrice,
                decoration: const InputDecoration(hintText: 'Insert Price'),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: txtImageurl,
                decoration: const InputDecoration(hintText: 'Insert Image Url'),
              ),
              const SizedBox(
                height: 48,
              ),
              ElevatedButton(
                  onPressed: () {
                    savePizza();
                  },
                  child: const Text('Send Post'))
            ],
          ),
        ),
      ),
    );
  }
}
