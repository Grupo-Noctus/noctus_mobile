import 'dart:io';
import 'package:flutter/material.dart';
import '../controllers/register_controller.dart';
import '../models/register.dart';
import '../models/register_enuns.dart';
import '../service/auth_service.dart';
import '../utils/app_colors.dart';
import 'styles.dart';

class RegisterViewP2 extends StatefulWidget {
  final RegisterUserDto userDto;
  const RegisterViewP2({super.key, required this.userDto});
  
  @override
  State<RegisterViewP2> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterViewP2> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _supportResourcesDescriptionController = TextEditingController();

  bool? _selectedHasDisability;
  bool? _needsSupportResourcesController;

  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  DisabilityType? _selectedDisabilityType;
  EducationLevel? _selectedEducationLevel;
  BrazilianState? _selectedState;
  Ethnicity? _selectedEthnicity;
  Gender? _selectedGender;

  late RegisterController _registerController;

  @override
  void initState() {
    super.initState();
    _registerController = RegisterController(AuthService());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(42.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/M Matera.png',
                      width: 48,
                      height: 48,
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Cadastro',
                      style: textStyleRegister,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                      locale: const Locale('pt', 'BR'),
                    );

                    if (picked != null) {
                      setState(() {
                        _selectedDate = picked;
                        _dateController.text =
                            '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
                      });
                    }
                  },
                  child: IgnorePointer(
                    child: TextFormField(
                      controller: _dateController,
                      decoration: customInputDecoration('Data de nascimento'),
                      style: TextStyle(color: AppColors.white),
                      validator: (value) {
                        if (_selectedDate == null) {
                          return 'Por favor, selecione uma data';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<EducationLevel>(
                  value: _selectedEducationLevel,
                  decoration: customDropdownDecoration('Nivel de escolaridade'),
                  dropdownColor: AppColors.darkBlack,
                  icon: const Icon(Icons.arrow_drop_down, color: AppColors.accentGreen),
                  style: inputTextStyle,
                  items: EducationLevel.values.map((level) {
                    return DropdownMenuItem<EducationLevel>(
                      value: level,
                      child: Text(level.value),
                    );
                  }).toList(),
                  onChanged: (EducationLevel? newValue) {
                    setState(() {
                      _selectedEducationLevel = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor, selecione o nível de escolaridade';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<BrazilianState>(
                  value: _selectedState,
                  decoration: customDropdownDecoration('Estado'),
                  dropdownColor: AppColors.darkBlack,
                  icon: const Icon(Icons.arrow_drop_down, color: AppColors.accentGreen),
                  style: inputTextStyle,
                  items: BrazilianState.values.map((state) {
                    return DropdownMenuItem<BrazilianState>(
                      value: state,
                      child: Text(state.value),
                    );
                  }).toList(),
                  onChanged: (BrazilianState? newValue) {
                    setState(() {
                      _selectedState = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor, selecione seu Estado';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<Gender>(
                        value: _selectedGender,
                        decoration: customDropdownDecoration('Gênero'),
                        dropdownColor: AppColors.darkBlack,
                        icon: const Icon(Icons.arrow_drop_down, color: AppColors.accentGreen),
                        style: inputTextStyle,
                        items: Gender.values.map((gender) {
                          return DropdownMenuItem<Gender>(
                            value: gender,
                            child: Text(gender.value),
                          );
                        }).toList(),
                        onChanged: (Gender? newValue) {
                          setState(() {
                            _selectedGender = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Por favor, selecione seu gênero';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<Ethnicity>(
                        value: _selectedEthnicity,
                        decoration: customDropdownDecoration('Etnia'),
                        dropdownColor: AppColors.darkBlack,
                        icon: const Icon(Icons.arrow_drop_down, color: AppColors.accentGreen),
                        style: inputTextStyle,
                        items: Ethnicity.values.map((ethnicity) {
                          return DropdownMenuItem<Ethnicity>(
                            value: ethnicity,
                            child: Text(ethnicity.value),
                          );
                        }).toList(),
                        onChanged: (Ethnicity? newValue) {
                          setState(() {
                            _selectedEthnicity = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Por favor, selecione sua etnia';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<bool>(
                        value: _selectedHasDisability,
                        decoration: customDropdownDecoration('Possui deficiência?'),
                        dropdownColor: AppColors.darkBlack,
                        icon: const Icon(Icons.arrow_drop_down, color: AppColors.accentGreen),
                        style: inputTextStyle,
                        items: const [
                          DropdownMenuItem<bool>(
                            value: true,
                            child: Text('Sim'),
                          ),
                          DropdownMenuItem<bool>(
                            value: false,
                            child: Text('Não'),
                          ),
                        ],
                        onChanged: (bool? newValue) {
                          setState(() {
                            _selectedHasDisability = newValue;
                            if (newValue == false) {
                              _selectedDisabilityType = null;
                              _needsSupportResourcesController = null;
                              _supportResourcesDescriptionController.clear();
                            }
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Por favor, selecione uma opção';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: _selectedHasDisability == true,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      DropdownButtonFormField<DisabilityType>(
                        value: _selectedDisabilityType,
                        decoration: customDropdownDecoration('Tipo de deficiência'),
                        dropdownColor: AppColors.darkBlack,
                        icon: const Icon(Icons.arrow_drop_down, color: AppColors.accentGreen),
                        style: inputTextStyle,
                        items: DisabilityType.values.map((type) {
                          return DropdownMenuItem<DisabilityType>(
                            value: type,
                            child: Text(type.value),
                          );
                        }).toList(),
                        onChanged: (DisabilityType? newValue) {
                          setState(() {
                            _selectedDisabilityType = newValue;
                          });
                        },
                        validator: (value) {
                          if (_selectedHasDisability == true && value == null) {
                            return 'Por favor, selecione o tipo';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<bool>(
                        value: _needsSupportResourcesController,
                        decoration: customDropdownDecoration('Precisa de suporte?'),
                        dropdownColor: AppColors.darkBlack,
                        icon: const Icon(Icons.arrow_drop_down, color: AppColors.accentGreen),
                        style: inputTextStyle,
                        items: const [
                          DropdownMenuItem<bool>(
                            value: true,
                            child: Text('Sim'),
                          ),
                          DropdownMenuItem<bool>(
                            value: false,
                            child: Text('Não'),
                          ),
                        ],
                        onChanged: (bool? newValue) {
                          setState(() {
                            if(_needsSupportResourcesController == false){
                              _supportResourcesDescriptionController.clear();
                            }
                            _needsSupportResourcesController = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Por favor, selecione uma opção';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: _needsSupportResourcesController == true,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _supportResourcesDescriptionController,
                        style: inputTextStyle,
                        decoration: customInputDecoration('Descrição do suporte'),
                        validator: (value) {
                          if (value == null) {
                            return 'Por favor, selecione uma opção';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                       if (_formKey.currentState!.validate()) {
                        _registerController.registerContext(
                          context: context,
                          username: widget.userDto.username,
                          name: widget.userDto.name,
                          email: widget.userDto.email,
                          password: widget.userDto.password,
                          phone: widget.userDto.phoneNumber,
                          image: widget.userDto.image != null ? File(widget.userDto.image!) : null,
                          dateBirth: _selectedDate,
                          educationLevel: _selectedEducationLevel,
                          state: _selectedState,
                          ethnicity: _selectedEthnicity,
                          gender: _selectedGender,
                          hasDisability: _selectedHasDisability,
                          disabilityType: _selectedDisabilityType,
                          needsSupportResources: _needsSupportResourcesController,
                          supportResourcesDescription: _supportResourcesDescriptionController.text,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      )
                    ),
                    child: const Text('CONTINUE', style: buttonTextStyle),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
