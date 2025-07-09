import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, String>> labHistory = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab Test Application'),
        elevation: 4,
        backgroundColor: Colors.teal,
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Test"),
            Tab(text: "History"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          LabTestForm(
            onSave: (history) {
              setState(() {
                labHistory.insert(0, history);
              });
            },
          ),
          LabHistoryPage(labHistory: labHistory),
        ],
      ),
    );
  }
}
//
class LabTestForm extends StatefulWidget {
  final Function(Map<String, String>) onSave;

  const LabTestForm({super.key, required this.onSave});

  @override
  _LabTestFormState createState() => _LabTestFormState();
}

class _LabTestFormState extends State<LabTestForm> with SingleTickerProviderStateMixin {
  String? selectedTestType;
  String? selectedGender;
  List<String> testContent = [];
  List<String> _filteredTestContent = [];
  Map<String, String> testResults = {};
  Map<String, double> testResultValues = {};
  Map<String, String> selectedUnits = {};
  String diagnosis = "";
  String comment = "";
  bool _isLoading = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  Map<String, TextEditingController> _textControllers = {};
  String _searchTerm = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> testData = [
    {
      "TestType": "Blood Test",
      "Component": "Hemoglobin",
      "Unit of Measurement": "g/dL or g/L",
      "ReferenceRangeMale": "13.8-17.2 g/dL",
      "ReferenceRangeFemale": "12.1-15.1 g/dL",
      "ReferenceRangeChild": "11.0-16.0 g/dL",
      "Increased": "Polycythemia, Dehydration",
      "Decreased": "Anemia, Blood Loss",
      "SuggestionsTreatmentIncreased": "Hydration, Phlebotomy",
      "SuggestionsTreatmentDecreased": "Iron Supplements, Blood Transfusion",
      "Interpretation": "Hemoglobin is a protein in red blood cells that carries oxygen. Low levels may indicate anemia.",
    },
    {
      "TestType": "Blood Test",
      "Component": "White Blood Cell Count",
      "Unit of Measurement": "cells/mcL",
      "ReferenceRangeMale": "4500-11000 cells/mcL",
      "ReferenceRangeFemale": "4500-11000 cells/mcL",
      "ReferenceRangeChild": "5000-15000 cells/mcL",
      "Increased": "Infection, Inflammation",
      "Decreased": "Bone Marrow Deficiency, Autoimmune Disease",
      "SuggestionsTreatmentIncreased": "Antibiotics, Anti-inflammatory Drugs",
      "SuggestionsTreatmentDecreased": "Bone Marrow Stimulators, Immunosuppressants",
      "Interpretation": "White blood cells are part of the immune system. High levels can indicate an infection or inflammation.",
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadTestData();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  Future<void> _loadTestData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final String response = await rootBundle.loadString('assets/test_data.json');
      final List<dynamic> data = json.decode(response);
      setState(() {
        testData = data.cast<Map<String, dynamic>>();
      });
    } catch (e) {
      print('Error loading test data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _updateTestType(String? newType) {
    setState(() {
      if (selectedTestType != newType) {
        selectedTestType = newType;
        testContent = getTestContent(newType);
        _filterTestContent(_searchTerm);
        _resetResults();
        _animationController.forward(from: 0.0);
      }
    });
  }

  void _updateGender(String? newGender) {
    setState(() {
      if (selectedGender != newGender) {
        selectedGender = newGender;
        _filterTestContent(_searchTerm);
        _resetResults();
        _animationController.forward(from: 0.0);
      }
    });
  }

  void _resetResults() {
    testResults.clear();
    testResultValues.clear();
    diagnosis = "";
    comment = "";
    _textControllers.clear();
  }

  void _addResult(String testItem, String result) {
    setState(() {
      testResults[testItem] = result;
      testResultValues[testItem] = double.tryParse(result.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
    });
  }

  void _updateUnit(String testItem, String? unit) {
    setState(() {
      selectedUnits[testItem] = unit!;
    });
  }

  void _generateDiagnosis() {
    if (selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a gender before generating the diagnosis.')),
      );
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        diagnosis = analyzeResults(testResults);
        comment = generateComment(diagnosis);
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DiagnosisResultPage(
            diagnosis: diagnosis,
            onSave: _saveDiagnosis,
            testResults: testResults,
            testResultValues: testResultValues,
            selectedUnits: selectedUnits,
            testData: testData,
            selectedGender: selectedGender,
          ),
        ),
      );
    }
  }

  void _filterTestContent(String searchTerm) {
    setState(() {
      _searchTerm = searchTerm;
      _filteredTestContent = testContent
          .where((item) => item.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    });
  }

  void _saveDiagnosis() {
    widget.onSave({
      'diagnosis': diagnosis,
      'comment': comment,
      'testType': selectedTestType ?? '',
      'gender': selectedGender ?? '',
      'time': DateTime.now().toString(),
    });
    Navigator.pop(context);
  }

  List<String> getTestTypes() {
    return testData.map<String>((test) => test["TestType"] as String).toSet().toList();
  }

  List<String> getTestContent(String? testType) {
    return testData
        .where((test) => test["TestType"] == testType)
        .map<String>((test) => test["Component"] as String)
        .toList();
  }

  String analyzeResults(Map<String, String> results) {
    String diagnosis = "";

    results.forEach((test, value) {
      double resultValue = double.tryParse(value.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
      var testComponent = testData.firstWhere(
            (element) => element["Component"] == test,
        orElse: () => {},
      );

      if (testComponent.isNotEmpty) {
        String selectedUnit = selectedUnits[test] ?? testComponent["Unit of Measurement"].split("or").first.trim();
        double lowRange = 0.0;
        double highRange = 100.0;

        String referenceRange = selectedGender == "Female"
            ? testComponent["ReferenceRangeFemale"]
            : selectedGender == "Child"
            ? testComponent["ReferenceRangeChild"]
            : testComponent["ReferenceRangeMale"];

        var ranges = parseReferenceRange(referenceRange, selectedUnit);
        lowRange = ranges[0];
        highRange = ranges[1];

        String increasedConditions = testComponent["Increased"] ?? "";
        String decreasedConditions = testComponent["Decreased"] ?? "";

        String treatmentIncreased = testComponent["SuggestionsTreatmentIncreased"] ?? "";
        String treatmentDecreased = testComponent["SuggestionsTreatmentDecreased"] ?? "";

        if (resultValue < lowRange) {
          diagnosis += "$test: Low (${resultValue.toStringAsFixed(2)} $selectedUnit) - $decreasedConditions\nSuggested Treatment: $treatmentDecreased\n";
        } else if (resultValue >= highRange) {
          diagnosis += "$test: High (${resultValue.toStringAsFixed(2)} $selectedUnit) - $increasedConditions\nSuggested Treatment: $treatmentIncreased\n";
        } else {
          diagnosis += "$test: Normal (${resultValue.toStringAsFixed(2)} $selectedUnit)\n";
        }
      }
    });

    if (diagnosis.isEmpty) {
      diagnosis = "No abnormalities detected.";
    }

    return diagnosis;
  }

  String generateComment(String diagnosis) {
    String comment = "Comment: ";
    if (diagnosis.isEmpty) {
      comment += "No abnormalities detected.";
    } else {
      comment += "Abnormalities detected:\n$diagnosis";
    }
    return comment;
  }

  List<double> parseReferenceRange(String referenceRange, String unit) {
    double lowRange = 0.0;
    double highRange = 100.0;

    referenceRange = referenceRange.replaceAll(unit, '').trim();
    if (referenceRange.contains('<=')) {
      highRange = double.tryParse(referenceRange.split('<=')[1].trim()) ?? 100.0;
      lowRange = 0.0;
    } else if (referenceRange.contains('>=')) {
      lowRange = double.tryParse(referenceRange.split('>=')[1].trim()) ?? 0.0;
      highRange = lowRange + 100.0;
    } else if (referenceRange.contains('<')) {
      highRange = double.tryParse(referenceRange.split('<')[1].trim()) ?? 100.0;
      lowRange = 0.0;
    } else if (referenceRange.contains('>')) {
      lowRange = double.tryParse(referenceRange.split('>')[1].trim()) ?? 0.0;
      highRange = lowRange + 100.0;
    } else if (referenceRange.contains('-')) {
      List<String> rangeParts = referenceRange.split('-');
      if (rangeParts.length == 2) {
        lowRange = double.tryParse(rangeParts[0].replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
        highRange = double.tryParse(rangeParts[1].replaceAll(RegExp(r'[^0-9.]'), '')) ?? 100.0;
      }
    }

    return [lowRange, highRange];
  }

  double calculateExtendedRange(double lowRange, double highRange, String referenceRange) {
    double rangeExtension = (referenceRange.contains('<') || referenceRange.contains('>'))
        ? 0.7 * (highRange - lowRange)
        : 0.3 * (highRange - lowRange);
    double extendedMinRange = lowRange - rangeExtension;
    double extendedMaxRange = highRange + rangeExtension;

    if (extendedMinRange < 0) {
      extendedMinRange = 0;
    }

    if (referenceRange.contains('<=') && referenceRange.contains('200')) {
      extendedMaxRange = 340.0;
    }

    return extendedMaxRange;
  }

  double calculateExtendedMinRange(double lowRange, String referenceRange) {
    if (referenceRange.contains('>')) {
      return 0;
    }
    double rangeExtension = (referenceRange.contains('<') || referenceRange.contains('>'))
        ? 0.7 * lowRange
        : 0.3 * lowRange;
    return lowRange - rangeExtension;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(4.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade600),
                        ),
                        child: DropdownButton<String>(
                          value: selectedTestType,
                          hint: const Text(
                            "Select Test Type",
                            style: TextStyle(fontSize: 12, fontFamily: 'Roboto'),
                          ),
                          items: getTestTypes().map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(fontSize: 12, fontFamily: 'Roboto'),
                              ),
                            );
                          }).toList(),
                          onChanged: _updateTestType,
                          isExpanded: true,
                          underline: const SizedBox(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade600),
                        ),
                        child: DropdownButton<String>(
                          value: selectedGender,
                          hint: const Text(
                            "Select Gender",
                            style: TextStyle(fontSize: 12, fontFamily: 'Roboto'),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: "Male",
                              child: Text(
                                "Male",
                                style: TextStyle(fontSize: 12, fontFamily: 'Roboto'),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "Female",
                              child: Text(
                                "Female",
                                style: TextStyle(fontSize: 12, fontFamily: 'Roboto'),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "Child",
                              child: Text(
                                "Child",
                                style: TextStyle(fontSize: 12, fontFamily: 'Roboto'),
                              ),
                            ),
                          ],
                          onChanged: _updateGender,
                          isExpanded: true,
                          underline: const SizedBox(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                  ),
                  onChanged: _filterTestContent,
                ),
                const SizedBox(height: 8.0),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: ListView.builder(
                      itemCount: _filteredTestContent.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        String testItem = _filteredTestContent[index];
                        var testComponent = testData.firstWhere(
                              (element) => element["Component"] == testItem,
                          orElse: () => {},
                        );
                        _textControllers[testItem] ??= TextEditingController(text: testResults[testItem]);

                        List<String> units = (testComponent["Unit of Measurement"] as String)
                            .split('or')
                            .map((u) => u.trim())
                            .toList();
                        String referenceRange = selectedGender == "Female"
                            ? testComponent["ReferenceRangeFemale"]
                            : selectedGender == "Child"
                            ? testComponent["ReferenceRangeChild"]
                            : testComponent["ReferenceRangeMale"];

                        var ranges = parseReferenceRange(referenceRange, selectedUnits[testItem] ?? units.first);
                        double minRange = ranges[0];
                        double maxRange = ranges[1];
                        double extendedMinRange = calculateExtendedMinRange(minRange, referenceRange);
                        double extendedMaxRange = calculateExtendedRange(minRange, maxRange, referenceRange);

                        double sliderValue = testResultValues[testItem] ?? minRange;
                        Color sliderColor;
                        if (sliderValue < minRange) {
                          sliderColor = Colors.orange;
                        } else if (sliderValue > maxRange) {
                          sliderColor = Colors.red;
                        } else {
                          sliderColor = Colors.green;
                        }

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  testItem,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                    color: Colors.blue,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Measured in:',
                                        style: TextStyle(fontSize: 12, fontFamily: 'Roboto'),
                                      ),
                                    ),
                                    Expanded(
                                      child: units.length > 1
                                          ? DropdownButton<String>(
                                        value: selectedUnits[testItem] ?? units.first,
                                        onChanged: (String? newValue) {
                                          _updateUnit(testItem, newValue);
                                        },
                                        items: units.map<DropdownMenuItem<String>>((String unit) {
                                          return DropdownMenuItem<String>(
                                            value: unit,
                                            child: Text(
                                              unit,
                                              style: const TextStyle(fontSize: 12, fontFamily: 'Roboto'),
                                            ),
                                          );
                                        }).toList(),
                                        underline: const SizedBox(),
                                      )
                                          : Text(
                                        units.first,
                                        style: const TextStyle(fontSize: 12, fontFamily: 'Roboto'),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: sliderColor,
                                    inactiveTrackColor: sliderColor.withOpacity(0.3),
                                    trackHeight: 8.0, // Adjusted track height
                                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0), // Adjusted thumb size
                                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 24.0), // Adjusted overlay size
                                    valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                                    valueIndicatorColor: Colors.teal,
                                    valueIndicatorTextStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  child: Slider(
                                    value: sliderValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _addResult(testItem, value.toString());
                                      });
                                    },
                                    min: extendedMinRange,
                                    max: extendedMaxRange,
                                    divisions: (extendedMaxRange - extendedMinRange) <= 10
                                        ? ((extendedMaxRange - extendedMinRange) * 10).round()
                                        : (extendedMaxRange - extendedMinRange).round(),
                                    label: sliderValue.toStringAsFixed(2),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Your Level: ${sliderValue.toStringAsFixed(2)} ${selectedUnits[testItem] ?? units.first}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Roboto',
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'Normal Range: $referenceRange',
                                      style: const TextStyle(fontSize: 12, fontFamily: 'Roboto'),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Interpretation: ${testComponent["Interpretation"] ?? "No interpretation available."}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Roboto',
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: _generateDiagnosis,
                    child: const Text(
                      'Generate Diagnosis',
                      style: TextStyle(fontSize: 12, fontFamily: 'Roboto'),
                    ),
                    key: const Key('generateDiagnosisButton'),
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
//
class DiagnosisResultPage extends StatelessWidget {
  final String diagnosis;
  final VoidCallback onSave;
  final Map<String, String> testResults;
  final Map<String, double> testResultValues;
  final Map<String, String> selectedUnits;
  final List<Map<String, dynamic>> testData;
  final String? selectedGender;

  const DiagnosisResultPage({
    super.key,
    required this.diagnosis,
    required this.onSave,
    required this.testResults,
    required this.testResultValues,
    required this.selectedUnits,
    required this.testData,
    required this.selectedGender,
  });

  List<double> parseReferenceRange(String referenceRange, String unit) {
    double lowRange = 0.0;
    double highRange = 100.0;

    referenceRange = referenceRange.replaceAll(unit, '').trim();
    if (referenceRange.contains('<=')) {
      highRange = double.tryParse(referenceRange.split('<=')[1].trim()) ?? 100.0;
      lowRange = 0.0;
    } else if (referenceRange.contains('>=')) {
      lowRange = double.tryParse(referenceRange.split('>=')[1].trim()) ?? 0.0;
      highRange = lowRange + 100.0;
    } else if (referenceRange.contains('<')) {
      highRange = double.tryParse(referenceRange.split('<')[1].trim()) ?? 100.0;
      lowRange = 0.0;
    } else if (referenceRange.contains('>')) {
      lowRange = double.tryParse(referenceRange.split('>')[1].trim()) ?? 0.0;
      highRange = lowRange + 100.0;
    } else if (referenceRange.contains('-')) {
      List<String> rangeParts = referenceRange.split('-');
      if (rangeParts.length == 2) {
        lowRange = double.tryParse(rangeParts[0].replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
        highRange = double.tryParse(rangeParts[1].replaceAll(RegExp(r'[^0-9.]'), '')) ?? 100.0;
      }
    }

    return [lowRange, highRange];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Diagnosis Result',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: testResults.keys.length,
        itemBuilder: (context, index) {
          String testItem = testResults.keys.elementAt(index);
          double? level = testResultValues[testItem];
          var testComponent = testData.firstWhere(
                (element) => element["Component"] == testItem,
            orElse: () => {},
          );
          String unit = selectedUnits[testItem] ?? testComponent["Unit of Measurement"].split("or").first.trim();
          String referenceRange = selectedGender == "Female"
              ? testComponent["ReferenceRangeFemale"]
              : selectedGender == "Child"
              ? testComponent["ReferenceRangeChild"]
              : testComponent["ReferenceRangeMale"];
          var ranges = parseReferenceRange(referenceRange, unit);
          double minRange = ranges[0];
          double maxRange = ranges[1];

          String cause = "";
          String treatment = "";
          if (level! < minRange) {
            cause = testComponent["Decreased"] ?? "";
            treatment = testComponent["SuggestionsTreatmentDecreased"] ?? "";
          } else if (level > maxRange) {
            cause = testComponent["Increased"] ?? "";
            treatment = testComponent["SuggestionsTreatmentIncreased"] ?? "";
          }

          return LabTestWidget(
            title: testItem,
            unit: unit,
            value: level,
            lowerBound: minRange,
            upperBound: maxRange,
            cause: cause,
            treatment: treatment,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onSave,
        child: const Icon(Icons.save),
      ),
    );
  }
}
//
class LabTestWidget extends StatefulWidget {
  final String title;
  final String unit;
  final double value;
  final double lowerBound;
  final double upperBound;
  final String cause;
  final String treatment;

  const LabTestWidget({
    super.key,
    required this.title,
    required this.unit,
    required this.value,
    required this.lowerBound,
    required this.upperBound,
    required this.cause,
    required this.treatment,
  });

  @override
  _LabTestWidgetState createState() => _LabTestWidgetState();
}

class _LabTestWidgetState extends State<LabTestWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _heartbeatAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _heartbeatAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isAbnormal = widget.value < widget.lowerBound || widget.value > widget.upperBound;
    Color indicatorColor = isAbnormal
        ? (widget.value > widget.upperBound ? Colors.red : Colors.orange)
        : Colors.green;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  'Your Level:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(width: 8.0),
                const Spacer(),
                if (isAbnormal)
                  ScaleTransition(
                    scale: _heartbeatAnimation,
                    child: Icon(
                      widget.value > widget.upperBound ? Icons.arrow_upward : Icons.arrow_downward,
                      color: indicatorColor,
                      size: 24.0,
                    ),
                  )
                else
                  Icon(
                    Icons.check_circle,
                    color: indicatorColor,
                    size: 24.0,
                  ),
                const SizedBox(width: 8.0),
                Text(
                  '${widget.value.toStringAsFixed(2)} ${widget.unit}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Container(
                  width: double.infinity,
                  height: 10.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        indicatorColor.withOpacity(0.3),
                        indicatorColor,
                        indicatorColor.withOpacity(0.3),
                      ],
                      stops: [
                        _animationController.value - 0.5,
                        _animationController.value,
                        _animationController.value + 0.5,
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 10.0),
            Text(
              'Normal Range For You: ${widget.lowerBound} to ${widget.upperBound} ${widget.unit}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (isAbnormal) ...[
              const SizedBox(height: 10.0),
              Text(
                'Cause: ${widget.cause}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 10.0),
              Text(
                'Suggested Treatment: ${widget.treatment}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
//
class LabHistoryPage extends StatelessWidget {
  final List<Map<String, String>> labHistory;

  const LabHistoryPage({super.key, required this.labHistory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lab Test History',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListView.builder(
          itemCount: labHistory.length,
          itemBuilder: (context, index) {
            final item = labHistory[index];
            final isAbnormal = item['diagnosis']?.toLowerCase().contains('high') == true ||
                item['diagnosis']?.toLowerCase().contains('low') == true;

            return Card(
              color: isAbnormal ? Colors.red[100] : Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Test Type: ${item['testType']}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Gender: ${item['gender']}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Diagnosis:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    ..._buildDiagnosisList(item['diagnosis'] ?? ''),
                    const SizedBox(height: 8),
                    Text(
                      'Time: ${DateTime.parse(item['time'] ?? '').toLocal()}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildDiagnosisList(String diagnosis) {
    final lines = diagnosis.split('\n');
    int diagnosisCounter = 1;
    List<Widget> widgets = [];

    for (var line in lines) {
      final trimmedLine = line.trim();

      if (!trimmedLine.toLowerCase().contains('suggested treatment') && !trimmedLine.toLowerCase().contains('cause')) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              '${diagnosisCounter++}. $trimmedLine',
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        );
      }
    }

    return widgets;
  }
}
