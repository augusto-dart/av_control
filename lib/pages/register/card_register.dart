import 'package:av_control/Components/buttons/primary_button.dart';
import 'package:av_control/Components/buttons/remove_button.dart';
import 'package:av_control/Utils/util.dart';
import 'package:av_control/models/bloc/cards/cards_bloc.dart';
import 'package:av_control/models/cards.dart';
import 'package:av_control/services/cards_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CardRegister extends StatefulWidget {
  const CardRegister({
    super.key,
    this.cartao,
  });

  final Cards? cartao;

  @override
  State<CardRegister> createState() => _CardRegisterState();
}

class _CardRegisterState extends State<CardRegister> {
  // final form = FormGroup({
  //   'description': FormControl<String>(
  //     validators: [
  //       Validators.required,
  //     ],
  //   ),
  //   'color': FormControl<int>(
  //     validators: [
  //       Validators.required,
  //     ],
  //   ),
  // });
  final CardsService service = CardsService();

  late Cards newCard;
  late Color _pickedColor;
  late bool editing;

  @override
  void initState() {
    super.initState();
    if (widget.cartao != null) {
      editing = true;
      Cards card = widget.cartao!.copy();
      // form.control('description').value = card.descricao;
      // form.control('color').value = card.cor;
      _pickedColor = Color(card.cor);
    } else {
      editing = false;
      _pickedColor = Colors.white;
    }
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController descricaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width - 50;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  MdiIcons.arrowLeft,
                  color: Colors.grey,
                ),
              ),
            ),
            Form(
              key: _formKey,
              // formGroup: form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Novo Cartão",
                    style: GoogleFonts.lato(),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Descrição',
                    ),
                    controller: descricaoController,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Cor do cartão:"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HueRingPicker(
                      pickerColor: _pickedColor,
                      onColorChanged: changeColor,
                    ),
                  ),
                  PrimaryButton(
                    texto: 'Salvar',
                    icone: Icons.done,
                    parentWidth: width,
                    onPress: () => {
                      newCard = Cards(
                        descricao: descricaoController.text,
                        valor: 0.0,
                        cor: _pickedColor.value,
                        userId: FirebaseAuth.instance.currentUser!.uid,
                      ),
                      if (!editing)
                        {
                          service.addCard(newCard).then(
                                (value) => {
                                  newCard.id = value,
                                  Utils.showSucessMessage(
                                    context,
                                    'Cartão salvo com sucesso!',
                                  ),
                                  context.read<CardsBloc>().add(
                                        AddCard(
                                          card: newCard,
                                        ),
                                      ),
                                  Navigator.of(context).pop(),
                                },
                              ),
                        }
                      else
                        {
                          newCard.id = widget.cartao!.id,
                          newCard.setValor(widget.cartao!.valor),
                          service.updateCard(newCard).then(
                                (value) => {
                                  Utils.showSucessMessage(
                                    context,
                                    'Cartão salvo com sucesso!',
                                  ),
                                  context.read<CardsBloc>().add(
                                        UpdateCard(
                                          card: newCard,
                                        ),
                                      ),
                                  Navigator.of(context).pop(),
                                },
                              ),
                        }
                    },
                  ),
                  Visibility(
                    visible: editing,
                    maintainSize: false,
                    maintainState: false,
                    child: RemoveButton(
                      texto: 'Excluir',
                      icone: MdiIcons.trashCan,
                      parentWidth: width,
                      onPress: () => {
                        Utils.showConfirmMessage(
                          context,
                          'Confirma Exclusão do cartão?',
                          () => {
                            service.deleteCard(widget.cartao!).then(
                                  (value) => {
                                    Utils.showSucessMessage(
                                      context,
                                      'Cartão removido com sucesso!',
                                    ),
                                    context.read<CardsBloc>().add(
                                          RemoveCard(
                                            card: widget.cartao!,
                                          ),
                                        ),
                                    Navigator.of(context).pop(),
                                  },
                                ),
                          },
                        ),
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changeColor(Color value) {
    setState(() {
      _pickedColor = value;
    });
  }
}
