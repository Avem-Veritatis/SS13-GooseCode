#define PI						3.1415
#define SPEED_OF_LIGHT			3e8		//not exact but hey!
#define SPEED_OF_LIGHT_SQ		9e+16
#define INFINITY				1e31	//closer then enough

//atmos
#define R_IDEAL_GAS_EQUATION	8.31	//kPa*L/(K*mol)
#define ONE_ATMOSPHERE			101.325	//kPa
#define T0C						273.15	// 0degC
#define T20C					293.15	// 20degC
#define TCMB					2.7		// -270.3degC

//In order to adjust to Drake's chemistry set. We need to present some work arounds at the core function level. All of these things need to be defined in order to substitute for later code.

#define REM 0.2 // Means 'Reagent Effect Multiplier'. This is how many units of reagent are consumed per tick
#define REAGENTS_OVERDOSE 30