import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pointsf/models/product_model.dart';
import 'package:pointsf/Services/ProductService/product_service.dart';
import 'package:pointsf/widgets/export_widgets.dart';

import 'package:brasil_fields/brasil_fields.dart';

class ProductDataEditing extends StatefulWidget {
  final ProductModel model;
  const ProductDataEditing({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<ProductDataEditing> createState() => _ProductDataEditingState();
}

class _ProductDataEditingState extends State<ProductDataEditing> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ProductService productSertvice = ProductService();

  List<Map<String, dynamic>> sizes = [];

  String? dropDownCategory;
  String? dropDownStatus;
  String? dropDownType;

  String productName = '';
  String productPrice = '';

  final TextEditingController _controllerProductName = TextEditingController();
  final TextEditingController _controllerProductSize = TextEditingController();
  final TextEditingController _controllerProductPrice = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      dropDownCategory = widget.model.categoria!;
      _controllerProductName.text = widget.model.nome!;
      dropDownStatus = widget.model.status!;
      dropDownType = widget.model.tipo!;
    });
    setItens();
  }

  setItens() async {
    await productSertvice.getSizeProduct(widget.model.uid);
    setState(() {
      var x = productSertvice.sizes;
      for (var i = 0; i < x.length; i++) {
        sizes.add(x[i]!);
      }
    });
  }

  void save(BuildContext context) {
    if (sizes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("É preciso adicionar um tamanho")),
      );
    } else if (formKey.currentState!.validate()) {
      ProductModel model = ProductModel(
        categoria: dropDownCategory,
        nome: _controllerProductName.text,
        status: dropDownStatus,
        tipo: dropDownType,
        uid: widget.model.uid,
        sizes: sizes,
      );

      ProductService().update(model, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: const CustomAppBar(
        title: "Editar Produto",
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  onSaved: (value) => productName = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Campo nome é obrigatorio!";
                    }
                    return null;
                  },
                  controller: _controllerProductName,
                  labelText: "Nome do Produto",
                  placeholder: "Creme de avelã",
                ),
                CustomDropdownButton(
                  labelText: "Selecione o Tipo do Produto",
                  hintText: "Selecione o Tipo do produto",
                  value: dropDownType,
                  onChanged: (Object? typeProduct) {
                    setState(() {
                      dropDownType = typeProduct!.toString();
                    });
                    throw "";
                  },
                  items: typeProduct.map((String categories) {
                    return DropdownMenuItem(
                      value: categories,
                      child: Text(
                        categories,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }).toList(),
                ),
                CustomDropdownButton(
                  labelText: "Selecione o Status do Produto",
                  hintText: "Selecione o Status do Produto",
                  value: dropDownStatus,
                  onChanged: (Object? status) {
                    setState(() {
                      dropDownStatus = status!.toString();
                    });
                    throw "";
                  },
                  items: status.map((String status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                ),
                CustomDropdownButton(
                  labelText: "Selecione a categoria do produto",
                  hintText: "Selecione a categoria do produto",
                  value: dropDownCategory,
                  onChanged: (Object? categories) {
                    setState(() {
                      dropDownCategory = categories!.toString();
                    });
                    throw "";
                  },
                  items: categories.map((String categories) {
                    return DropdownMenuItem(
                      value: categories,
                      child: Text(
                        categories,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }).toList(),
                ),
                if (sizes.isNotEmpty)
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 180,
                    margin: const EdgeInsets.fromLTRB(15, 0, 15, 12),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: "Tamanhos",
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 74, 44, 82),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 74, 44, 82),
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: sizes.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    "tamanho: ${sizes[index]['tamanho']}, Preço: ${sizes[index]['preco']}",
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.remove_circle_outline,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        sizes.removeAt(index);
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextField(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        width: MediaQuery.of(context).size.width / 2 - 30,
                        controller: _controllerProductSize,
                        labelText: "Tamanho",
                        placeholder: "500ml",
                      ),
                      // const SizedBox(width: 20),
                      CustomTextField(
                        prefix: const Text(
                          "R\$ ",
                          style: TextStyle(
                            color: Color.fromARGB(200, 0, 0, 0),
                          ),
                        ),
                        inputType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CentavosInputFormatter(),
                        ],
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        width: MediaQuery.of(context).size.width / 2 - 30,
                        controller: _controllerProductPrice,
                        labelText: "Preço",
                        placeholder: "15,00",
                      ),
                    ],
                  ),
                ),
                CustomTextButton(
                  buttonText: "Adicionar tamanho",
                  width: 280,
                  onPressed: () {
                    Map<String, dynamic> newSize = {
                      "tamanho": _controllerProductSize.text,
                      "preco": _controllerProductPrice.text,
                    };
                    setState(() {
                      sizes.add(newSize);
                    });
                    _controllerProductSize.clear();
                    _controllerProductPrice.clear();
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextButton(
                  buttonText: "Cadastrar",
                  onPressed: () => save(context),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final categorySelected = TextEditingController();

  List<String> categories = [
    "Açai",
    "Salgado",
    "Bebida",
  ];

  final statusSelected = TextEditingController();

  List<String> status = [
    "Ativo",
    "Inativo",
  ];

// dropDawnTipo
  final typeSelected = TextEditingController();

  List<String> typeProduct = [
    "Primario",
    "Adicional",
  ];
}
