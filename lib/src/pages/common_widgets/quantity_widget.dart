import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

class QuantityWidget extends StatelessWidget {
  final int quantity;
  final String suffixText;
  final Function(int quantity) result;
  final bool isRemoveble;

  const QuantityWidget({
    Key? key,
    required this.quantity,
    required this.suffixText,
    required this.result,
    this.isRemoveble = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool removeQuantity = !isRemoveble || quantity > 1;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Botão de remover ou deletar do carrinho
          _quantityButton(
            icon: removeQuantity ? Icons.remove : Icons.delete_forever,
            color: removeQuantity ? Colors.grey : Colors.red,
            onPressed: () {
              if (quantity == 1 && !isRemoveble) return;
              int resultCount = quantity - 1;
              result(resultCount);
            },
          ),

          // Nome e valor
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '$quantity$suffixText',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Botão de adcionar
          _quantityButton(
            icon: Icons.add,
            color: CustomColors.customSwatchColor,
            onPressed: () {
              int resultCount = quantity + 1;
              result(resultCount);
            },
          ),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class _quantityButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;

  const _quantityButton({
    Key? key,
    required this.color,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onPressed,
        child: Ink(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
    );
  }
}
