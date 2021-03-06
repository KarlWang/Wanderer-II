#ifndef Common_H
#define Common_H

#define VEHICLE_FORWARD 		201
#define VEHICLE_BACKWARD 		211
#define VEHICLE_FORWARD_TURN_LEFT 	221
#define VEHICLE_FORWARD_TURN_RIGHT	231
#define VEHICLE_BACKWARD_TURN_LEFT 	241
#define VEHICLE_BACKWARD_TURN_RIGHT	251
#define VEHICLE_SPIN_CLOCKWISE		261
#define VEHICLE_SPIN_COUNTERCLOCKWISE	271
#define VEHICLE_STOP			281

#define SERVO_CLOCKWISE  188
#define SERVO_COUNTERCLOCKWISE  199

#define VEHICLE_COM_MOVE	666
#define VEHICLE_COM_SERVO	777
#define VEHICLE_COM_AUTO	888
#define VEHICLE_COM_STANDBY	999

#define SYSTEM_MODE_MENU	0
#define SYSTEM_MODE_MOVE	1
#define SYSTEM_MODE_SERVO	2
#define SYSTEM_MODE_AUTO	3
#define SYSTEM_MODE_STANDBY	4

#define SYSTEM_CON_LEFT_JOYSTICK_V  A4
#define SYSTEM_CON_LEFT_JOYSTICK_H  A5
#define SYSTEM_CON_RIGHT_JOYSTICK_V  A2
#define SYSTEM_CON_RIGHT_JOYSTICK_H  A3
#define SYSTEM_CON_XBEE_RX  7
#define SYSTEM_CON_XBEE_TX  8

#define BUTTON_1_PIN	2
#define BUTTON_2_PIN	5
#define BUTTON_3_PIN	4
#define BUTTON_4_PIN	6

class CSettings
{
public:
  static int SystemModeCode;	
  static int SystemModeCode_Current;
  static int SystemModeCode_Old;
  static int ServoPos_Current;
  static int LastMillis;
};

#endif




