import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'main_dash_model.dart';
export 'main_dash_model.dart';

class MainDashWidget extends StatefulWidget {
  const MainDashWidget({super.key});

  static String routeName = 'MainDash';
  static String routePath = '/mainDash';

  @override
  State<MainDashWidget> createState() => _MainDashWidgetState();
}

class _MainDashWidgetState extends State<MainDashWidget> {
  late MainDashModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MainDashModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('currentUserReference: $currentUserReference');
    return StreamBuilder<PetInfoRecord>(
      stream: PetInfoRecord.getDocument(currentUserReference!),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 60.0,
                    height: 60.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        FlutterFlowTheme.of(context).primary,
                      ),
                      strokeWidth: 3.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Loading pet data...',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'custom font',
                          fontSize: 16.0,
                        ),
                  ),
                ],
              ),
            ),
          );
        }

        final mainDashPetInfoRecord = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            endDrawer: _buildDrawer(context),
            body: SafeArea(
              child: Column(
                children: [
                  // Show banner for anonymous users
                  if (FirebaseAuth.instance.currentUser?.isAnonymous ?? false) _buildAnonymousBanner(context),
                  _buildHeader(context, mainDashPetInfoRecord),
                  Expanded(
                    child:
                        _buildDashboardContent(context, mainDashPetInfoRecord),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnonymousBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primary.withOpacity(0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.person_outline,
            color: Colors.white,
            size: 20.0,
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              'Guest Mode - Create an account to save your pet\'s data',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'custom font',
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton(
            onPressed: () => context.pushNamed(SignUpWidget.routeName),
            child: Text(
              'Sign Up',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'custom font',
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      elevation: 16.0,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      child: Column(
        children: [
          // Drawer Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40.0,
                  backgroundColor: FlutterFlowTheme.of(context).primary,
                  child: Icon(
                    Icons.pets,
                    color: Colors.white,
                    size: 40.0,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Pet Dashboard',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily: 'custom font',
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  context,
                  icon: Icons.pets_sharp,
                  title: 'Change Pet Info',
                  onTap: () => context.pushNamed(PetInfoWidget.routeName),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.key,
                  title: 'Change Password',
                  onTap: () =>
                      context.pushNamed(ChangePasswordPageWidget.routeName),
                ),
                Divider(
                  thickness: 1.0,
                  color: FlutterFlowTheme.of(context)
                      .secondaryText
                      .withOpacity(0.3),
                  indent: 20.0,
                  endIndent: 20.0,
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.delete_forever,
                  title: 'Delete Account',
                  textColor: FlutterFlowTheme.of(context).error,
                  onTap: () => _showDeleteAccountDialog(context),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.logout,
                  title: 'Log Out',
                  textColor: FlutterFlowTheme.of(context).tertiary,
                  onTap: () async {
                    GoRouter.of(context).prepareAuthEvent();
                    await authManager.signOut();
                    GoRouter.of(context).clearRedirectLocation();
                    context.goNamedAuth(
                        OnBoardingWidget.routeName, context.mounted);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: textColor ?? FlutterFlowTheme.of(context).primaryText,
        size: 24.0,
      ),
      title: Text(
        title,
        style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'custom font',
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
    );
  }

  Widget _buildHeader(BuildContext context, PetInfoRecord petInfo) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Pet Avatar
          GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: FlutterFlowExpandedImageView(
                    image: Image.asset(
                      'assets/images/d3935a29-9228-4ef9-843a-9e4e92bdd139.png',
                      fit: BoxFit.contain,
                    ),
                    allowRotation: false,
                    tag: 'imageTag',
                    useHeroAnimation: true,
                  ),
                ),
              );
            },
            child: Hero(
              tag: 'imageTag',
              transitionOnUserGestures: true,
              child: Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).primary,
                    width: 3.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:
                          FlutterFlowTheme.of(context).primary.withOpacity(0.3),
                      blurRadius: 10.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: Image.asset(
                    'assets/images/d3935a29-9228-4ef9-843a-9e4e92bdd139.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 20.0),
          // Pet Info
          Expanded(
            child: GestureDetector(
              onTap: () => context.pushNamed(PetInfoWidget.routeName),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    valueOrDefault<String>(petInfo.petName, 'Nelly'),
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          fontFamily: 'custom font',
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    children: [
                      Icon(
                        Icons.pets,
                        size: 16.0,
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        '${valueOrDefault<String>(petInfo.petGender, 'Male')} • ${valueOrDefault<String>(petInfo.petAge.toString(), '3')} years',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'custom font',
                              color: FlutterFlowTheme.of(context).secondaryText,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Menu Button
          IconButton(
            onPressed: () => scaffoldKey.currentState!.openEndDrawer(),
            icon: Icon(
              Icons.menu,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 28.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardContent(BuildContext context, PetInfoRecord petInfo) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Health Status Card
          _buildHealthStatusCard(context, petInfo),
          SizedBox(height: 24.0),

          // Stats Grid
          Text(
            'Pet Statistics',
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: 'custom font',
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(height: 16.0),
          _buildStatsGrid(context, petInfo),
          SizedBox(height: 24.0),

          // Activity Image
          Text(
            'Recent Activity',
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: 'custom font',
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(height: 16.0),
          _buildActivityImage(context),
        ],
      ),
    );
  }

  Widget _buildHealthStatusCard(BuildContext context, PetInfoRecord petInfo) {
    // Define normal ranges for health metrics
    final vocLevel = petInfo.petVOCPercent;
    final heartRate = petInfo.petHeartRate;
    final speed = petInfo.petSpeed;
    
    // Check if values are in normal ranges
    final vocNormal = vocLevel >= 0 && vocLevel <= 30; // Normal VOC: 0-30%
    final heartRateNormal = heartRate >= 60 && heartRate <= 120; // Normal heart rate for pets: 60-120 BPM
    final speedNormal = speed >= 0 && speed <= 15; // Normal activity speed: 0-15 km/h
    
    final isHealthy = vocNormal && heartRateNormal && speedNormal;
    
    String statusText;
    List<String> issues = [];
    
    if (!vocNormal) issues.add('VOC levels');
    if (!heartRateNormal) issues.add('Heart rate');
    if (!speedNormal) issues.add('Activity level');
    
    if (isHealthy) {
      statusText = 'Healthy';
    } else if (issues.length == 1) {
      statusText = 'Check ${issues[0]}';
    } else {
      statusText = 'Needs Attention';
    }
    
    final statusColor =
        isHealthy ? Color(0xFF4CAF50) : FlutterFlowTheme.of(context).error;
    final statusIcon = isHealthy ? Icons.check_circle : Icons.warning;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            statusColor.withOpacity(0.1),
            statusColor.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: statusColor.withOpacity(0.3),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.1),
            blurRadius: 10.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Icon(
              statusIcon,
              color: statusColor,
              size: 32.0,
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Health Status',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'custom font',
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                ),
                SizedBox(height: 4.0),
                Text(
                  statusText,
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily: 'Toasty Milk',
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                if (!isHealthy && issues.isNotEmpty) ...[
                  SizedBox(height: 8.0),
                  Text(
                    'Issues: ${issues.join(', ')}',
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'custom font',
                          color: statusColor,
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context, PetInfoRecord petInfo) {
    return Column(
      children: [
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: 1.0,
          children: [
            _buildStatCard(
              context,
              icon: Icons.blur_on,
              value: petInfo.petVOCPercent.toString(),
              label: 'VOC',
              color: Colors.blue,
            ),
            _buildStatCard(
              context,
              icon: Icons.favorite,
              value: petInfo.petHeartRate.toString(),
              label: 'Heart Rate',
              color: Colors.red,
            ),
            _buildStatCard(
              context,
              icon: Icons.speed_outlined,
              value: petInfo.petSpeed.toString(),
              label: 'Speed',
              color: Colors.green,
            ),
          ],
        ),
        SizedBox(height: 16.0),
        // Edit Health Metrics Button
        FFButtonWidget(
          onPressed: () async {
            context.pushNamed(HealthMetricsWidget.routeName);
          },
          text: 'Update Health Metrics',
          icon: Icon(
            Icons.edit,
            size: 20.0,
          ),
          options: FFButtonOptions(
            width: double.infinity,
            height: 48.0,
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
            iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
            color: FlutterFlowTheme.of(context).primary,
            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                  fontFamily: 'custom font',
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
            elevation: 2.0,
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            value,
            style: FlutterFlowTheme.of(context).titleMedium.override(
                  fontFamily: 'custom font',
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(height: 4.0),
          Text(
            label,
            style: FlutterFlowTheme.of(context).bodySmall.override(
                  fontFamily: 'custom font',
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityImage(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Image.asset(
          'assets/images/pexels-alexandra-bilham-41703424-7329892.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    final bool isAnonymous = FirebaseAuth.instance.currentUser?.isAnonymous ?? false;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Account',
            style: FlutterFlowTheme.of(context).headlineSmall.override(
              fontFamily: 'custom font',
              fontWeight: FontWeight.w600,
              color: FlutterFlowTheme.of(context).error,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isAnonymous 
                  ? 'This will permanently delete your guest account and all pet data.'
                  : 'This will permanently delete your account and all pet data.',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'custom font',
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).error.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning,
                      color: FlutterFlowTheme.of(context).error,
                      size: 20.0,
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        'This action cannot be undone!',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'custom font',
                          color: FlutterFlowTheme.of(context).error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'custom font',
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
              ),
            ),
            FFButtonWidget(
              onPressed: () async {
                Navigator.of(context).pop(); // Close dialog
                await _deleteAccount(context);
              },
              text: 'Delete Account',
              options: FFButtonOptions(
                width: 140.0,
                height: 40.0,
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                color: FlutterFlowTheme.of(context).error,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                  fontFamily: 'custom font',
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
                elevation: 2.0,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAccount(BuildContext context) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                FlutterFlowTheme.of(context).primary,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Deleting account...',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'custom font',
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );

    try {
      // Delete the account using the auth manager
      await authManager.deleteUser(context);
      
      // Close loading dialog
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }
      
      // Navigate to onboarding screen
      context.goNamedAuth(OnBoardingWidget.routeName, context.mounted);
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Account deleted successfully'),
          backgroundColor: FlutterFlowTheme.of(context).primary,
        ),
      );
      
    } catch (e) {
      // Close loading dialog
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }
      
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete account. Please try again.'),
          backgroundColor: FlutterFlowTheme.of(context).error,
        ),
      );
    }
  }
}
