import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctus_mobile/configs/theme_helper.dart';
import 'package:noctus_mobile/core/enum/brasilian_state_enum.dart';
import 'package:noctus_mobile/core/enum/education_level_enum.dart';
import 'package:noctus_mobile/core/enum/ethnicity_enum.dart';
import 'package:noctus_mobile/core/enum/gender_enum.dart';
import 'package:noctus_mobile/core/widgets/app_input_form_widget.dart';
import 'package:noctus_mobile/domain/entities/register/register_entity.dart';
import 'package:noctus_mobile/domain/entities/student/student_entity.dart';
import 'package:noctus_mobile/ui/register/view_models/register_factory_viewmodel.dart';
import 'package:noctus_mobile/ui/register/view_models/register_view_model.dart';
import 'package:noctus_mobile/ui/register/widgets/register_button_widget.dart';
import 'package:noctus_mobile/ui/register/widgets/register_datepicker_widget.dart';
import 'package:noctus_mobile/ui/register/widgets/register_enum_field_widget.dart';

final class StudentRegisterPage extends StatelessWidget {
  final RegisterEntity registerEntity;

  const StudentRegisterPage({
    super.key,
    required this.registerEntity,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterViewModel>(
      create: (context) =>
          RegisterFactoryViewmodel().create(context, registerEntity: registerEntity),
      child: const _StudentRegisterPage(),
    );
  }
}

class _StudentRegisterPage extends StatefulWidget {
  const _StudentRegisterPage();

  @override
  State<_StudentRegisterPage> createState() => _StudentRegisterPageState();
}

class _StudentRegisterPageState extends State<_StudentRegisterPage> {
  final _formKey = GlobalKey<FormState>();

  DateTime? _dateBirth;
  Gender? selectedGender;
  EducationLevel? selectedEducationLevel;
  BrazilianState? selectedState;
  Ethnicity? selectedEthnicity;

  bool hasDisability = false;
  String? disabilityType;

  bool needsSupportResources = false;

  final TextEditingController disabilityController = TextEditingController();
  final TextEditingController supportResourcesController = TextEditingController();

  late RegisterViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<RegisterViewModel>();
  }

  @override
  void dispose() {
    disabilityController.dispose();
    supportResourcesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SafeArea(
            minimum: const EdgeInsets.symmetric(vertical: 16, horizontal: 26),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 40),
                    FormField<DateTime>(
                      validator: (_) => _dateBirth == null
                          ? 'Por favor, selecione sua data de nascimento.'
                          : null,
                      builder: (state) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RegisterDatePickerWidget(
                            value: _dateBirth,
                            onChanged: (value) {
                              setState(() {
                                _dateBirth = value;
                                state.didChange(value);
                              });
                            },
                          ),
                          if (state.hasError)
                            Padding(
                              padding: const EdgeInsets.only(left: 12, top: 6),
                              child: Text(
                                state.errorText!,
                                style: const TextStyle(
                                  color: ThemeHelper.kAccentGreen,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    RegisterEnumDropdownWidget<Gender>(
                      label: 'Gênero',
                      values: Gender.values,
                      selectedValue: selectedGender,
                      onChanged: (value) => setState(() => selectedGender = value),
                      validator: (value) =>
                          value == null ? 'Selecione seu gênero.' : null,
                    ),
                    const SizedBox(height: 16),
                    RegisterEnumDropdownWidget<EducationLevel>(
                      label: 'Escolaridade',
                      values: EducationLevel.values,
                      selectedValue: selectedEducationLevel,
                      onChanged: (value) =>
                          setState(() => selectedEducationLevel = value),
                      validator: (value) =>
                          value == null ? 'Selecione seu nível de escolaridade.' : null,
                    ),
                    const SizedBox(height: 16),
                    RegisterEnumDropdownWidget<BrazilianState>(
                      label: 'Estado',
                      values: BrazilianState.values,
                      selectedValue: selectedState,
                      onChanged: (value) => setState(() => selectedState = value),
                      validator: (value) =>
                          value == null ? 'Selecione o estado em que reside.' : null,
                    ),
                    const SizedBox(height: 16),
                    RegisterEnumDropdownWidget<Ethnicity>(
                      label: 'Etnia',
                      values: Ethnicity.values,
                      selectedValue: selectedEthnicity,
                      onChanged: (value) => setState(() => selectedEthnicity = value),
                      validator: (value) =>
                          value == null ? 'Selecione sua etinia.' : null,
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text('Possui deficiência?'),
                      value: hasDisability,
                      onChanged: (value) => setState(() {
                        hasDisability = value;
                        if (!value) disabilityController.clear();
                      }),
                    ),
                    if (hasDisability)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: AppInputFormFieldWidget(
                          controller: disabilityController,
                          labelText: 'Tipo de deficiência',
                          validatorMessage: 'Informe o tipo de deficiência.',
                        ),
                      ),
                    SwitchListTile(
                      title: const Text('Necessita de recursos de apoio?'),
                      value: needsSupportResources,
                      onChanged: (value) => setState(() {
                        needsSupportResources = value;
                        if (!value) {
                          supportResourcesController.clear();
                        }
                      }),
                    ),
                    if (needsSupportResources)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: AppInputFormFieldWidget(
                          controller: supportResourcesController,
                          labelText: 'Descrição dos recursos',
                          validatorMessage: 'Descreva os recursos necessários.',
                        ),
                      ),
                    const SizedBox(height: 32),
                    RegisterButtonWidget(
                      onPressed: onRegisterStudent,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onRegisterStudent() {
    if (_formKey.currentState?.validate() ?? false) {
      final student = StudentEntity(
        dateBirth: _dateBirth!,
        gender: selectedGender!,
        educationLevel: selectedEducationLevel!,
        state: selectedState!,
        ethnicity: selectedEthnicity!,
        hasDisability: hasDisability,
        disabilityType: hasDisability ? disabilityController.text : null,
        needsSupportResources: needsSupportResources,
        supportResourcesDescription:
            needsSupportResources ? supportResourcesController.text : null,
      );

      final completedRegisterEntity = RegisterEntity(
        user: _viewModel.registerEntity.user,
        imageUser: _viewModel.registerEntity.imageUser,
        student: student,
      );

      _viewModel.onRegisterStudent(completedRegisterEntity);
    }
  }
}
