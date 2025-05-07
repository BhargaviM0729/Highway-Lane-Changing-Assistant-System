/*
 * File: Adaptive_Cruise_Control.c
 *
 * Code generated for Simulink model 'Adaptive_Cruise_Control'.
 *
 * Model version                  : 1.24
 * Simulink Coder version         : 9.1 (R2019a) 23-Nov-2018
 * C/C++ source code generated on : Wed Apr  9 23:08:00 2025
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "Adaptive_Cruise_Control.h"
#include "Adaptive_Cruise_Control_private.h"
#include "rt_roundd.h"

/* Named constants for Chart: '<S1>/Chart' */
#define Ada_IN_LeadVehicle_Not_Detected ((uint8_T)3U)
#define Adaptive_Cr_IN_ACC_STANDBY_MODE ((uint8_T)3U)
#define Adaptive_Cru_IN_NO_ACTIVE_CHILD ((uint8_T)0U)
#define Adaptive_Cruise_IN_ACC_OFF_MODE ((uint8_T)1U)
#define Adaptive_Cruise__IN_ACC_ON_MODE ((uint8_T)2U)
#define IN_LeadVehicle_Detected_Follow ((uint8_T)1U)
#define IN_LeadVehicle_Detected_Resume ((uint8_T)2U)
#define IN_LeadVehicle_Not_Detected_Res ((uint8_T)4U)
#define IN_LeadVehicle_Speed_equal_Set_ ((uint8_T)5U)
#define IN_LeadVehicle_Speed_lessthan_s ((uint8_T)6U)

/* user code (top of source file) */

  /* Exported data definition */
  /* Definition for custom storage class: ExportToFile */
  uint8_T Acceleration_Mode;
uint8_T DriveVehicle_Speed;
uint8_T LeadVehicle_Detected;
uint8_T LeadVehicle_Speed;

/* Block states (default storage) */
DW_Adaptive_Cruise_Control_T Adaptive_Cruise_Control_DW;

/* External outputs (root outports fed by signals with default storage) */
ExtY_Adaptive_Cruise_Control_T Adaptive_Cruise_Control_Y;

/* Forward declaration for local functions */
static void Adaptive_Cruise_Con_ACC_ON_MODE(void);

/* Function for Chart: '<S1>/Chart' */
static void Adaptive_Cruise_Con_ACC_ON_MODE(void)
{
  int32_T tmp;
  int32_T tmp_0;
  uint8_T tmp_1;
  uint8_T tmp_2;

  /* Inport: '<Root>/SetSwitch' incorporates:
   *  Inport: '<Root>/CruiseSwitch'
   *  Inport: '<Root>/Set_Gap'
   *  Inport: '<Root>/Set_Speed'
   *  Inport: '<Root>/Time_Gap'
   */
  /* During 'ACC_ON_MODE': '<S2>:81' */
  if (!SetSwitch) {
    /* Transition: '<S2>:45' */
    /* Exit Internal 'ACC_ON_MODE': '<S2>:81' */
    Adaptive_Cruise_Control_DW.is_ACC_ON_MODE = Adaptive_Cru_IN_NO_ACTIVE_CHILD;
    Adaptive_Cruise_Control_DW.is_c3_Adaptive_Cruise_Control =
      Adaptive_Cr_IN_ACC_STANDBY_MODE;

    /* Outport: '<Root>/Acceleration_Mode' */
    /* Entry 'ACC_STANDBY_MODE': '<S2>:12' */
    Adaptive_Cruise_Control_Y.Acceleration_Mode_c = 1U;
  } else if (!CruiseSwitch) {
    /* Transition: '<S2>:84' */
    /* Exit Internal 'ACC_ON_MODE': '<S2>:81' */
    Adaptive_Cruise_Control_DW.is_ACC_ON_MODE = Adaptive_Cru_IN_NO_ACTIVE_CHILD;
    Adaptive_Cruise_Control_DW.is_c3_Adaptive_Cruise_Control =
      Adaptive_Cruise_IN_ACC_OFF_MODE;

    /* Outport: '<Root>/Acceleration_Mode' */
    /* Entry 'ACC_OFF_MODE': '<S2>:10' */
    Adaptive_Cruise_Control_Y.Acceleration_Mode_c = 0U;
  } else {
    switch (Adaptive_Cruise_Control_DW.is_ACC_ON_MODE) {
     case IN_LeadVehicle_Detected_Follow:
      /* During 'LeadVehicle_Detected_Follow': '<S2>:47' */
      if (LeadVehicle_Detected == 0) {
        /* Transition: '<S2>:52' */
        Adaptive_Cruise_Control_DW.is_ACC_ON_MODE =
          Ada_IN_LeadVehicle_Not_Detected;

        /* Outport: '<Root>/Acceleration_Mode' */
        /* Entry 'LeadVehicle_Not_Detected': '<S2>:49' */
        Adaptive_Cruise_Control_Y.Acceleration_Mode_c = 1U;
      } else {
        if (((LeadVehicle_Detected == 1) && (LeadVehicle_Speed < Set_Speed)) ||
            (Time_Gap < Set_Gap)) {
          /* Transition: '<S2>:56' */
          Adaptive_Cruise_Control_DW.is_ACC_ON_MODE =
            IN_LeadVehicle_Speed_lessthan_s;

          /* Outport: '<Root>/Acceleration_Mode' */
          /* Entry 'LeadVehicle_Speed_lessthan_set_Speed': '<S2>:53' */
          Adaptive_Cruise_Control_Y.Acceleration_Mode_c = 4U;
        }
      }
      break;

     case IN_LeadVehicle_Detected_Resume:
      /* Inport: '<Root>/Set_Speed' incorporates:
       *  Inport: '<Root>/Set_Gap'
       *  Inport: '<Root>/Time_Gap'
       */
      /* During 'LeadVehicle_Detected_Resume': '<S2>:60' */
      if ((DriveVehicle_Speed == Set_Speed) && (LeadVehicle_Speed >= Set_Speed) &&
          (Time_Gap >= Set_Gap)) {
        /* Transition: '<S2>:61' */
        Adaptive_Cruise_Control_DW.is_ACC_ON_MODE =
          IN_LeadVehicle_Detected_Follow;

        /* Outport: '<Root>/Acceleration_Mode' */
        /* Entry 'LeadVehicle_Detected_Follow': '<S2>:47' */
        Adaptive_Cruise_Control_Y.Acceleration_Mode_c = 2U;
      } else if ((DriveVehicle_Speed < Set_Speed) && (LeadVehicle_Speed >
                  DriveVehicle_Speed) && (Time_Gap >= Set_Gap)) {
        /* Transition: '<S2>:63' */
        Adaptive_Cruise_Control_DW.is_ACC_ON_MODE =
          IN_LeadVehicle_Speed_equal_Set_;

        /* Outport: '<Root>/Acceleration_Mode' */
        /* Entry 'LeadVehicle_Speed_equal_Set_Speed': '<S2>:62' */
        Adaptive_Cruise_Control_Y.Acceleration_Mode_c = 5U;
      } else {
        if (LeadVehicle_Detected == 0) {
          /* Transition: '<S2>:88' */
          Adaptive_Cruise_Control_DW.is_ACC_ON_MODE =
            IN_LeadVehicle_Not_Detected_Res;

          /* Outport: '<Root>/Acceleration_Mode' */
          /* Entry 'LeadVehicle_Not_Detected_Resume': '<S2>:68' */
          Adaptive_Cruise_Control_Y.Acceleration_Mode_c = 1U;
        }
      }
      break;

     case Ada_IN_LeadVehicle_Not_Detected:
      /* Inport: '<Root>/Set_Speed' incorporates:
       *  Inport: '<Root>/Set_Gap'
       *  Inport: '<Root>/Time_Gap'
       */
      /* During 'LeadVehicle_Not_Detected': '<S2>:49' */
      if ((LeadVehicle_Detected == 1) && (DriveVehicle_Speed == Set_Speed) &&
          (LeadVehicle_Speed >= Set_Speed) && (Time_Gap >= Set_Gap)) {
        /* Transition: '<S2>:58' */
        Adaptive_Cruise_Control_DW.is_ACC_ON_MODE =
          IN_LeadVehicle_Detected_Follow;

        /* Outport: '<Root>/Acceleration_Mode' */
        /* Entry 'LeadVehicle_Detected_Follow': '<S2>:47' */
        Adaptive_Cruise_Control_Y.Acceleration_Mode_c = 2U;
      } else {
        if (((LeadVehicle_Detected == 1) && (LeadVehicle_Speed < Set_Speed)) ||
            (Time_Gap < Set_Gap)) {
          /* Transition: '<S2>:59' */
          Adaptive_Cruise_Control_DW.is_ACC_ON_MODE =
            IN_LeadVehicle_Speed_lessthan_s;

          /* Outport: '<Root>/Acceleration_Mode' */
          /* Entry 'LeadVehicle_Speed_lessthan_set_Speed': '<S2>:53' */
          Adaptive_Cruise_Control_Y.Acceleration_Mode_c = 4U;
        }
      }
      break;

     case IN_LeadVehicle_Not_Detected_Res:
      /* During 'LeadVehicle_Not_Detected_Resume': '<S2>:68' */
      break;

     case IN_LeadVehicle_Speed_equal_Set_:
      /* Inport: '<Root>/Set_Speed' incorporates:
       *  Inport: '<Root>/Set_Gap'
       *  Inport: '<Root>/Time_Gap'
       */
      /* During 'LeadVehicle_Speed_equal_Set_Speed': '<S2>:62' */
      if ((LeadVehicle_Detected == 0) || (DriveVehicle_Speed <= Set_Speed)) {
        /* Transition: '<S2>:71' */
        Adaptive_Cruise_Control_DW.is_ACC_ON_MODE =
          IN_LeadVehicle_Not_Detected_Res;

        /* Outport: '<Root>/Acceleration_Mode' */
        /* Entry 'LeadVehicle_Not_Detected_Resume': '<S2>:68' */
        Adaptive_Cruise_Control_Y.Acceleration_Mode_c = 1U;
      } else if (((DriveVehicle_Speed < Set_Speed) && (LeadVehicle_Speed >
                   DriveVehicle_Speed)) || (Time_Gap >= Set_Gap)) {
        /* Transition: '<S2>:72' */
        Adaptive_Cruise_Control_DW.is_ACC_ON_MODE =
          IN_LeadVehicle_Detected_Resume;

        /* Outport: '<Root>/Acceleration_Mode' */
        /* Entry 'LeadVehicle_Detected_Resume': '<S2>:60' */
        Adaptive_Cruise_Control_Y.Acceleration_Mode_c = 3U;
      } else {
        if (((LeadVehicle_Speed < Set_Speed) && (LeadVehicle_Speed <
              DriveVehicle_Speed)) || (Time_Gap == (int32_T)rt_roundd(0.75 *
              (real_T)Set_Gap))) {
          /* Transition: '<S2>:73' */
          Adaptive_Cruise_Control_DW.is_ACC_ON_MODE =
            IN_LeadVehicle_Speed_lessthan_s;

          /* Outport: '<Root>/Acceleration_Mode' */
          /* Entry 'LeadVehicle_Speed_lessthan_set_Speed': '<S2>:53' */
          Adaptive_Cruise_Control_Y.Acceleration_Mode_c = 4U;
        }
      }
      break;

     default:
      /* Inport: '<Root>/Set_Speed' */
      /* During 'LeadVehicle_Speed_lessthan_set_Speed': '<S2>:53' */
      if ((LeadVehicle_Detected == 0) && (DriveVehicle_Speed == Set_Speed)) {
        /* Transition: '<S2>:69' */
        Adaptive_Cruise_Control_DW.is_ACC_ON_MODE =
          Ada_IN_LeadVehicle_Not_Detected;

        /* Outport: '<Root>/Acceleration_Mode' */
        /* Entry 'LeadVehicle_Not_Detected': '<S2>:49' */
        Adaptive_Cruise_Control_Y.Acceleration_Mode_c = 1U;
      } else {
        tmp = (int32_T)rt_roundd((real_T)LeadVehicle_Speed * 1.25);

        /* Inport: '<Root>/Set_Gap' */
        tmp_0 = (int32_T)rt_roundd(1.25 * (real_T)Set_Gap);
        if (tmp < 256) {
          tmp_1 = (uint8_T)tmp;
        } else {
          tmp_1 = MAX_uint8_T;
        }

        if (tmp_0 < 256) {
          tmp_2 = (uint8_T)tmp_0;
        } else {
          tmp_2 = MAX_uint8_T;
        }

        /* Inport: '<Root>/Time_Gap' incorporates:
         *  Inport: '<Root>/Set_Gap'
         */
        if ((tmp_1 >= DriveVehicle_Speed) && ((int32_T)rt_roundd((real_T)
              LeadVehicle_Speed * 0.75) <= DriveVehicle_Speed) &&
            (DriveVehicle_Speed < Set_Speed) && (Time_Gap <= tmp_2) && (Time_Gap
             >= (int32_T)rt_roundd(0.75 * (real_T)Set_Gap))) {
          /* Transition: '<S2>:70' */
          Adaptive_Cruise_Control_DW.is_ACC_ON_MODE =
            IN_LeadVehicle_Speed_equal_Set_;

          /* Outport: '<Root>/Acceleration_Mode' */
          /* Entry 'LeadVehicle_Speed_equal_Set_Speed': '<S2>:62' */
          Adaptive_Cruise_Control_Y.Acceleration_Mode_c = 5U;
        }
      }
      break;
    }
  }

  /* End of Inport: '<Root>/SetSwitch' */
}

/* Model step function */
void Adaptive_Cruise_Control_step(void)
{
  /* Sum: '<S4>/Add' incorporates:
   *  Inport: '<Root>/CameraInput_LeadVehicle'
   *  Inport: '<Root>/RadarInput_LeadVehicle'
   */
  LeadVehicle_Speed = (uint8_T)((uint32_T)CameraInput_LeadVehicle +
    RadarInput_LeadVehicle);

  /* UnitDelay: '<S1>/Unit Delay' */
  Acceleration_Mode = Adaptive_Cruise_Control_DW.UnitDelay_DSTATE;

  /* Sum: '<S3>/Add' incorporates:
   *  Inport: '<Root>/CameraInput_DriveVehicle'
   *  Inport: '<Root>/RadarInput_DriveVehicle'
   */
  DriveVehicle_Speed = (uint8_T)((uint32_T)(uint8_T)((uint32_T)
    CameraInput_DriveVehicle + RadarInput_DriveVehicle) + Acceleration_Mode);

  /* SignalConversion: '<S3>/Signal Conversion' incorporates:
   *  Inport: '<Root>/RadarInput_DriveVehicle'
   */
  LeadVehicle_Detected = RadarInput_DriveVehicle;

  /* Chart: '<S1>/Chart' incorporates:
   *  Inport: '<Root>/CruiseSwitch'
   *  Inport: '<Root>/SetSwitch'
   */
  /* Gateway: Adaptive_Cruise_Control_System/Chart */
  /* During: Adaptive_Cruise_Control_System/Chart */
  if (Adaptive_Cruise_Control_DW.is_active_c3_Adaptive_Cruise_Co == 0U) {
    /* Entry: Adaptive_Cruise_Control_System/Chart */
    Adaptive_Cruise_Control_DW.is_active_c3_Adaptive_Cruise_Co = 1U;

    /* Entry Internal: Adaptive_Cruise_Control_System/Chart */
    /* Transition: '<S2>:11' */
    Adaptive_Cruise_Control_DW.is_c3_Adaptive_Cruise_Control =
      Adaptive_Cruise_IN_ACC_OFF_MODE;

    /* Outport: '<Root>/Acceleration_Mode' */
    /* Entry 'ACC_OFF_MODE': '<S2>:10' */
    Adaptive_Cruise_Control_Y.Acceleration_Mode_c = 0U;
  } else {
    switch (Adaptive_Cruise_Control_DW.is_c3_Adaptive_Cruise_Control) {
     case Adaptive_Cruise_IN_ACC_OFF_MODE:
      /* During 'ACC_OFF_MODE': '<S2>:10' */
      if (CruiseSwitch) {
        /* Transition: '<S2>:42' */
        Adaptive_Cruise_Control_DW.is_c3_Adaptive_Cruise_Control =
          Adaptive_Cr_IN_ACC_STANDBY_MODE;

        /* Outport: '<Root>/Acceleration_Mode' */
        /* Entry 'ACC_STANDBY_MODE': '<S2>:12' */
        Adaptive_Cruise_Control_Y.Acceleration_Mode_c = 1U;
      }
      break;

     case Adaptive_Cruise__IN_ACC_ON_MODE:
      Adaptive_Cruise_Con_ACC_ON_MODE();
      break;

     default:
      /* During 'ACC_STANDBY_MODE': '<S2>:12' */
      if (SetSwitch) {
        /* Transition: '<S2>:44' */
        Adaptive_Cruise_Control_DW.is_c3_Adaptive_Cruise_Control =
          Adaptive_Cruise__IN_ACC_ON_MODE;

        /* Entry 'ACC_ON_MODE': '<S2>:81' */
        /* Entry Internal 'ACC_ON_MODE': '<S2>:81' */
        /* Transition: '<S2>:48' */
        Adaptive_Cruise_Control_DW.is_ACC_ON_MODE =
          IN_LeadVehicle_Detected_Follow;

        /* Outport: '<Root>/Acceleration_Mode' */
        /* Entry 'LeadVehicle_Detected_Follow': '<S2>:47' */
        Adaptive_Cruise_Control_Y.Acceleration_Mode_c = 2U;
      } else {
        if (!CruiseSwitch) {
          /* Transition: '<S2>:43' */
          Adaptive_Cruise_Control_DW.is_c3_Adaptive_Cruise_Control =
            Adaptive_Cruise_IN_ACC_OFF_MODE;

          /* Outport: '<Root>/Acceleration_Mode' */
          /* Entry 'ACC_OFF_MODE': '<S2>:10' */
          Adaptive_Cruise_Control_Y.Acceleration_Mode_c = 0U;
        }
      }
      break;
    }
  }

  /* End of Chart: '<S1>/Chart' */

  /* Update for UnitDelay: '<S1>/Unit Delay' incorporates:
   *  Outport: '<Root>/Acceleration_Mode'
   */
  Adaptive_Cruise_Control_DW.UnitDelay_DSTATE =
    Adaptive_Cruise_Control_Y.Acceleration_Mode_c;
}

/* Model initialize function */
void Adaptive_Cruise_Control_initialize(void)
{
  /* Registration code */

  /* block I/O */

  /* custom signals */
  LeadVehicle_Speed = 0U;
  Acceleration_Mode = 0U;
  DriveVehicle_Speed = 0U;
  LeadVehicle_Detected = 0U;

  /* states (dwork) */
  (void) memset((void *)&Adaptive_Cruise_Control_DW, 0,
                sizeof(DW_Adaptive_Cruise_Control_T));

  /* external outputs */
  Adaptive_Cruise_Control_Y.Acceleration_Mode_c = 0U;

  /* SystemInitialize for Chart: '<S1>/Chart' */
  Adaptive_Cruise_Control_DW.is_ACC_ON_MODE = Adaptive_Cru_IN_NO_ACTIVE_CHILD;
  Adaptive_Cruise_Control_DW.is_active_c3_Adaptive_Cruise_Co = 0U;
  Adaptive_Cruise_Control_DW.is_c3_Adaptive_Cruise_Control =
    Adaptive_Cru_IN_NO_ACTIVE_CHILD;
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
