import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'health_metrics_model.dart';
export 'health_metrics_model.dart';

class HealthMetricsWidget extends StatefulWidget {
  const HealthMetricsWidget({super.key});

  static String routeName = 'HealthMetrics';
  static String routePath = '/healthMetrics';

  @override
  State<HealthMetricsWidget> createState() => _HealthMetricsWidgetState();
}

class _HealthMetricsWidgetState extends State<HealthMetricsWidget> {
  late HealthMetricsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HealthMetricsModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PetInfoRecord>(
      stream: PetInfoRecord.getDocument(currentUserReference!),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }

        final healthMetricsPetInfoRecord = snapshot.data!;

        // Initialize text controllers with current values
        if (_model.vocTextController == null) {
          _model.vocTextController = TextEditingController(
            text: healthMetricsPetInfoRecord.petVOCPercent.toString(),
          );
          _model.vocFocusNode = FocusNode();
        }

        if (_model.heartRateTextController == null) {
          _model.heartRateTextController = TextEditingController(
            text: healthMetricsPetInfoRecord.petHeartRate.toString(),
          );
          _model.heartRateFocusNode = FocusNode();
        }

        if (_model.speedTextController == null) {
          _model.speedTextController = TextEditingController(
            text: healthMetricsPetInfoRecord.petSpeed.toString(),
          );
          _model.speedFocusNode = FocusNode();
        }

        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).primary,
              automaticallyImplyLeading: false,
              leading: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  context.pop();
                },
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
              title: Text(
                'Health Metrics',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'custom font',
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              actions: [],
              centerTitle: false,
              elevation: 2.0,
            ),
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10.0,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.health_and_safety,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 48.0,
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              'Update ${healthMetricsPetInfoRecord.petName}\'s Health Metrics',
                              style: FlutterFlowTheme.of(context).headlineSmall.override(
                                    fontFamily: 'custom font',
                                    fontWeight: FontWeight.w600,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Keep track of your pet\'s vital health indicators',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'custom font',
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: 24.0),
                      
                      // VOC Metric
                      _buildMetricCard(
                        context,
                        title: 'VOC Level',
                        subtitle: 'Volatile Organic Compounds (%)',
                        icon: Icons.blur_on,
                        color: Colors.blue,
                        controller: _model.vocTextController!,
                        focusNode: _model.vocFocusNode!,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter VOC level';
                          }
                          final doubleValue = double.tryParse(value);
                          if (doubleValue == null) {
                            return 'Please enter a valid number';
                          }
                          if (doubleValue < 0 || doubleValue > 100) {
                            return 'VOC level must be between 0 and 100';
                          }
                          if (doubleValue > 30) {
                            return 'Warning: VOC > 30% may indicate poor air quality';
                          }
                          return null;
                        },
                      ),
                      
                      SizedBox(height: 20.0),
                      
                      // Heart Rate Metric
                      _buildMetricCard(
                        context,
                        title: 'Heart Rate',
                        subtitle: 'Beats per minute (BPM)',
                        icon: Icons.favorite,
                        color: Colors.red,
                        controller: _model.heartRateTextController!,
                        focusNode: _model.heartRateFocusNode!,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter heart rate';
                          }
                          final intValue = int.tryParse(value);
                          if (intValue == null) {
                            return 'Please enter a valid number';
                          }
                          if (intValue < 30 || intValue > 300) {
                            return 'Heart rate must be between 30 and 300 BPM';
                          }
                          if (intValue < 60 || intValue > 120) {
                            return 'Warning: Normal range is 60-120 BPM for pets';
                          }
                          return null;
                        },
                      ),
                      
                      SizedBox(height: 20.0),
                      
                      // Speed Metric
                      _buildMetricCard(
                        context,
                        title: 'Speed',
                        subtitle: 'Movement speed (km/h)',
                        icon: Icons.speed_outlined,
                        color: Colors.green,
                        controller: _model.speedTextController!,
                        focusNode: _model.speedFocusNode!,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter speed';
                          }
                          final doubleValue = double.tryParse(value);
                          if (doubleValue == null) {
                            return 'Please enter a valid number';
                          }
                          if (doubleValue < 0 || doubleValue > 100) {
                            return 'Speed must be between 0 and 100 km/h';
                          }
                          if (doubleValue > 15) {
                            return 'Warning: Normal activity speed is 0-15 km/h';
                          }
                          return null;
                        },
                      ),
                      
                      SizedBox(height: 32.0),
                      
                      // Save Button
                      FFButtonWidget(
                        onPressed: () async {
                          // Validate all fields
                          final vocValue = double.tryParse(_model.vocTextController!.text);
                          final heartRateValue = int.tryParse(_model.heartRateTextController!.text);
                          final speedValue = double.tryParse(_model.speedTextController!.text);
                          
                          if (vocValue == null || heartRateValue == null || speedValue == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please fill in all fields with valid numbers'),
                                backgroundColor: FlutterFlowTheme.of(context).error,
                              ),
                            );
                            return;
                          }
                          
                          // Validate ranges
                          if (vocValue < 0 || vocValue > 100) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('VOC level must be between 0 and 100'),
                                backgroundColor: FlutterFlowTheme.of(context).error,
                              ),
                            );
                            return;
                          }
                          
                          if (heartRateValue < 30 || heartRateValue > 300) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Heart rate must be between 30 and 300 BPM'),
                                backgroundColor: FlutterFlowTheme.of(context).error,
                              ),
                            );
                            return;
                          }
                          
                          if (speedValue < 0 || speedValue > 100) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Speed must be between 0 and 100 km/h'),
                                backgroundColor: FlutterFlowTheme.of(context).error,
                              ),
                            );
                            return;
                          }
                          
                          // Show warnings for values outside normal ranges
                          List<String> warnings = [];
                          if (vocValue > 30) warnings.add('VOC level is above normal range (0-30%)');
                          if (heartRateValue < 60 || heartRateValue > 120) warnings.add('Heart rate is outside normal range (60-120 BPM)');
                          if (speedValue > 15) warnings.add('Activity speed is above normal range (0-15 km/h)');
                          
                          if (warnings.isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Note: ${warnings.join(', ')}'),
                                backgroundColor: Colors.orange,
                                duration: Duration(seconds: 4),
                              ),
                            );
                          }
                          
                          try {
                            // Update the document
                            await healthMetricsPetInfoRecord.reference.update(
                              createPetInfoRecordData(
                                petVOCPercent: vocValue,
                                petHeartRate: heartRateValue,
                                petSpeed: speedValue,
                              ),
                            );
                            
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Health metrics updated successfully!'),
                                backgroundColor: Color(0xFF4CAF50),
                              ),
                            );
                            
                            // Navigate back to main dashboard
                            context.pop();
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Failed to update health metrics: $e'),
                                backgroundColor: FlutterFlowTheme.of(context).error,
                              ),
                            );
                          }
                        },
                        text: 'Save Health Metrics',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 56.0,
                          padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'custom font',
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                          elevation: 3.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMetricCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required TextEditingController controller,
    required FocusNode focusNode,
    required TextInputType keyboardType,
    String? Function(String?)? validator,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24.0,
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            fontFamily: 'custom font',
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      subtitle,
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            fontFamily: 'custom font',
                            color: FlutterFlowTheme.of(context).secondaryText,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: controller,
            focusNode: focusNode,
            autofocus: false,
            obscureText: false,
            decoration: InputDecoration(
              labelText: 'Enter $title',
              labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                    fontFamily: 'custom font',
                    color: FlutterFlowTheme.of(context).secondaryText,
                  ),
              hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                    fontFamily: 'custom font',
                    color: FlutterFlowTheme.of(context).secondaryText,
                  ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: color.withOpacity(0.3),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: color,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).error,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).error,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              filled: true,
              fillColor: FlutterFlowTheme.of(context).primaryBackground,
              contentPadding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
            ),
            style: FlutterFlowTheme.of(context).bodyLarge.override(
                  fontFamily: 'custom font',
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
            keyboardType: keyboardType,
            validator: validator,
          ),
        ],
      ),
    );
  }
}
