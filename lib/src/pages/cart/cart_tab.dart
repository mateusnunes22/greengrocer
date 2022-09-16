import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/pages/cart/components/cart_tile.dart';
import 'package:greengrocer/src/pages/common_widgets/payment_dialog.dart';
import 'package:greengrocer/src/services/utils_services.dart';
import 'package:greengrocer/src/config/app_data.dart' as app_data;

class CartTab extends StatefulWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final UtilsServices utilsServices = UtilsServices();

  double total = 0.0;

  void updateTotalPrice(CartItemModel cartITem) {
    setState(() {
      if (cartITem.quantity < 1) {
        app_data.cartItems.remove(cartITem);
        utilsServices.showToast(
            message: '${cartITem.item.itemName} removido(a) do carrinho');
      }
      total = 0.0;
      for (var item in app_data.cartItems) {
        total += item.totalPrice();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          // Lista de itens do carrinho
          Expanded(
            child: ListView.builder(
              itemCount: app_data.cartItems.length,
              itemBuilder: (_, index) {
                return CartTile(
                  cartItem: app_data.cartItems[index],
                  remove: updateTotalPrice,
                );
              },
            ),
          ),

          // Total e botão de concluir o pedido
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 3,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total geral',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        utilsServices.priceToCurrency(total),
                        style: TextStyle(
                          fontSize: 23,
                          color: CustomColors.customSwatchColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.customSwatchColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () async {
                      bool? result = await showOrderConfirmation();

                      if (result ?? false) {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return PaymentDialog(
                              order: app_data.orders.first,
                            );
                          },
                        );
                      } else {
                        utilsServices.showToast(
                          message: 'Pedido não confirmado',
                          isError: true,
                        );
                      }
                    },
                    child: const Text(
                      'Concluir pedido',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> showOrderConfirmation() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Confirmação'),
          content: const Text('Deseja realmente concluir o pedido?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Não'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
  }
}
