/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _ASMATH_
#define _ASMATH_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#ifndef _IEC_CONST
#define _IEC_CONST _WEAK const
#endif

/* Constants */
#ifdef _REPLACE_CONST
 #define am2_SQRTPI 1.12838
 #define amSQRT1_2 0.707107
 #define amSQRTPI 1.77245
 #define amLOG2_E 0.693147
 #define amLOG10E 0.434294
 #define amIVLN10 0.434294
 #define amINVLN2 1.4427
 #define amTWOPI 6.28319
 #define amSQRT3 1.73205
 #define amSQRT2 1.41421
 #define amLOG2E 1.4427
 #define amLN2LO 1.90821e-010
 #define amLN2HI 0.693147
 #define am3PI_4 2.35619
 #define amPI_4 0.785398
 #define amPI_2 1.5708
 #define amLN10 2.30259
 #define am2_PI 0.63662
 #define am1_PI 0.31831
 #define amLN2 0.693147
 #define amPI 3.14159
 #define amE 2.71828
#else
 _IEC_CONST float am2_SQRTPI = 1.12838;
 _IEC_CONST float amSQRT1_2 = 0.707107;
 _IEC_CONST float amSQRTPI = 1.77245;
 _IEC_CONST float amLOG2_E = 0.693147;
 _IEC_CONST float amLOG10E = 0.434294;
 _IEC_CONST float amIVLN10 = 0.434294;
 _IEC_CONST float amINVLN2 = 1.4427;
 _IEC_CONST float amTWOPI = 6.28319;
 _IEC_CONST float amSQRT3 = 1.73205;
 _IEC_CONST float amSQRT2 = 1.41421;
 _IEC_CONST float amLOG2E = 1.4427;
 _IEC_CONST float amLN2LO = 1.90821e-010;
 _IEC_CONST float amLN2HI = 0.693147;
 _IEC_CONST float am3PI_4 = 2.35619;
 _IEC_CONST float amPI_4 = 0.785398;
 _IEC_CONST float amPI_2 = 1.5708;
 _IEC_CONST float amLN10 = 2.30259;
 _IEC_CONST float am2_PI = 0.63662;
 _IEC_CONST float am1_PI = 0.31831;
 _IEC_CONST float amLN2 = 0.693147;
 _IEC_CONST float amPI = 3.14159;
 _IEC_CONST float amE = 2.71828;
#endif







/* Prototyping of functions and function blocks */
float atan2(float y, float x);
float ceil(float x);
float cosh(float x);
float floor(float x);
float fmod(float x, float y);
float frexp(float x, unsigned long pExp);
float ldexp(float x, signed long exp_val);
float modf(float x, unsigned long plp);
float pow(float x, float y);
float sinh(float x);
float tanh(float x);


#ifdef __cplusplus
};
#endif
#endif /* _ASMATH_ */

                                                           
