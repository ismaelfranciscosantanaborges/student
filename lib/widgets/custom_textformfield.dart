import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CTextFormField extends StatelessWidget {
  const CTextFormField({
    Key key,
    @required this.title,
    @required TextEditingController controller,
    this.textInputType = TextInputType.name,
  })  : _firtsNameController = controller,
        super(key: key);

  final TextEditingController _firtsNameController;
  final String title;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 79,
      alignment: Alignment.topCenter,
      child: TextFormField(
        keyboardType: textInputType ?? TextInputType.name,
        controller: _firtsNameController,
        inputFormatters: [FilteringTextInputFormatter.deny(RegExp('[0-9]'))],
        maxLength: 25,
        decoration: InputDecoration(
          labelText: title ?? '',
        ),
        validator: (value) =>
            value.length < 2 ? 'Este campo tiene que pasar de 2 carac.' : null,
      ),
    );
  }
}
