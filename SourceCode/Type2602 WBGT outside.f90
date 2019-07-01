      Subroutine Type2602

! Object: WBGT calculation for outside
! Simulation Studio Model: Type2602 WBGT outside
! 

! Author: Yuichi Yasuda
! Editor: 
! Date:	 June 24, 2019
! last modified: June 24, 2019
! 
! 
! *** 
! *** Model Parameters 
! *** 

! *** 
! *** Model Inputs 
! *** 
!			Ambient temperature	C [-Inf;.0]
!			Relative humidity	- [0.0;100.0]
!			Wind speed	m/s [0;+Inf]
!			Total radiation on horizontal	kJ/hr.m^2 [-Inf;+Inf]

! *** 
! *** Model Outputs 
! *** 
!			WBGT	C [-Inf;+Inf]

! *** 
! *** Model Derivatives 
! *** 

! (Comments and routine interface generated by TRNSYS Simulation Studio)
!************************************************************************

!-----------------------------------------------------------------------------------------------------------------------
! This TRNSYS component skeleton was generated from the TRNSYS studio based on the user-supplied parameters, inputs, 
! outputs, and derivatives.  The user should check the component formulation carefully and add the content to transform
! the parameters, inputs and derivatives into outputs.  Remember, outputs should be the average value over the timestep
! and not the value at the end of the timestep; although in many models these are exactly the same values.  Refer to 
! existing types for examples of using advanced features inside the model (Formats, Labels etc.)
!-----------------------------------------------------------------------------------------------------------------------


      Use TrnsysConstants
      Use TrnsysFunctions

!-----------------------------------------------------------------------------------------------------------------------

!DEC$Attributes DLLexport :: Type2602

!-----------------------------------------------------------------------------------------------------------------------
!Trnsys Declarations
      Implicit None

      Double Precision Timestep,Time
      Integer CurrentUnit,CurrentType
      DOUBLE PRECISION wbgt ! WBGT
      DOUBLE PRECISION SR_kW !全天日射量[kW/m2]


!    PARAMETERS

!    INPUTS
      DOUBLE PRECISION Ta !乾球温度[C]
      DOUBLE PRECISION RH !相対湿度[%]
      DOUBLE PRECISION WS !風速[m/s]
      DOUBLE PRECISION SR !全天日射量[kJ/hm2]

!-----------------------------------------------------------------------------------------------------------------------

!-----------------------------------------------------------------------------------------------------------------------
!Get the Global Trnsys Simulation Variables
      Time=getSimulationTime()
      Timestep=getSimulationTimeStep()
      CurrentUnit = getCurrentUnit()
      CurrentType = getCurrentType()
!-----------------------------------------------------------------------------------------------------------------------

!-----------------------------------------------------------------------------------------------------------------------
!Set the Version Number for This Type
      If(getIsVersionSigningTime()) Then
		Call SetTypeVersion(17)
		Return
      EndIf
!-----------------------------------------------------------------------------------------------------------------------

!-----------------------------------------------------------------------------------------------------------------------
!Do Any Last Call Manipulations Here
      If(getIsLastCallofSimulation()) Then
		Return
      EndIf
!-----------------------------------------------------------------------------------------------------------------------

!-----------------------------------------------------------------------------------------------------------------------
!Perform Any "After Convergence" Manipulations That May Be Required at the End of Each Timestep
      If(getIsEndOfTimestep()) Then
		Return
      EndIf
!-----------------------------------------------------------------------------------------------------------------------

!-----------------------------------------------------------------------------------------------------------------------
!Do All of the "Very First Call of the Simulation Manipulations" Here
      If(getIsFirstCallofSimulation()) Then

		!Tell the TRNSYS Engine How This Type Works
		Call SetNumberofParameters(0)       !The number of parameters that the the model wants
		Call SetNumberofInputs(4)           !The number of inputs that the the model wants
		Call SetNumberofDerivatives(0)      !The number of derivatives that the the model wants
		Call SetNumberofOutputs(1)          !The number of outputs that the the model produces
		Call SetIterationMode(1)            !An indicator for the iteration mode (default=1).  Refer to section 8.4.3.5 of the documentation for more details.
		Call SetNumberStoredVariables(0,0)  !The number of static variables that the model wants stored in the global storage array and the number of dynamic variables that the model wants stored in the global storage array
		Call SetNumberofDiscreteControls(0) !The number of discrete control functions set by this model (a value greater than zero requires the user to use Solver 1: Powell's method)

        Call SetInputUnits(1,'TE1') !乾球温度(外気温）[C]
        Call SetInputUnits(2,'PC1') !相対湿度[%]
        Call SetInputUnits(3,'VE1') !風速[m/s]
        Call SetInputUnits(4,'IR1') !全天日射量[kJ/hm2]
        
        Call SetOutputUnits(1,'TE1') !WBGT[C]


		Return

      EndIf
!-----------------------------------------------------------------------------------------------------------------------

!-----------------------------------------------------------------------------------------------------------------------
!Do All of the First Timestep Manipulations Here - There Are No Iterations at the Intial Time
      If (getIsStartTime()) Then

      Ta = GetInputValue(1)!乾球温度[C]
      RH = GetInputValue(2)!相対湿度[%]
      WS = GetInputValue(3)!風速[m/s]
      SR = GetInputValue(4)!全天日射量[kJ/hm2]
      SR_kW = SR/3600.0    ! kJ/hm2 to W/m2

	
   !Check the Parameters for Problems (#,ErrorType,Text)
   !Sample Code: If( PAR1 <= 0.) Call FoundBadParameter(1,'Fatal','The first parameter provided to this model is not acceptable.')

   !Set the Initial Values of the Outputs (#,Value)
		!Call SetOutputValue(1, 0.0) ! WBGT
        !WBGT = 0.735*Tamb + 0.0374 * RH+  0.00292*Tamb*  RH  +7.619* SR_kW-4.557*  SR_kW*SR_kW-0.0572*WS-4.064
        wbgt = 0.735 * Ta + 0.0374 * RH + 0.00292 * Ta * RH + 7.619 * SR_kW - 4.577 * SR_kW**2 - 0.0572 * WS - 4.064
		Call SetOutputValue(1, wbgt) ! WBGT

   !If Needed, Set the Initial Values of the Static Storage Variables (#,Value)
   !Sample Code: SetStaticArrayValue(1,0.d0)

   !If Needed, Set the Initial Values of the Dynamic Storage Variables (#,Value)
   !Sample Code: Call SetDynamicArrayValueThisIteration(1,20.d0)

   !If Needed, Set the Initial Values of the Discrete Controllers (#,Value)
   !Sample Code for Controller 1 Set to Off: Call SetDesiredDiscreteControlState(1,0) 

		Return

      EndIf
!-----------------------------------------------------------------------------------------------------------------------

!-----------------------------------------------------------------------------------------------------------------------
!ReRead the Parameters if Another Unit of This Type Has Been Called Last
      If(getIsReReadParameters()) Then
		!Read in the Values of the Parameters from the Input File

		
      EndIf
!-----------------------------------------------------------------------------------------------------------------------

!Read the Inputs
      Ta = GetInputValue(1)!乾球温度[C]
      RH = GetInputValue(2)!相対湿度[%]
      WS = GetInputValue(3)!風速[m/s]
      SR = GetInputValue(4)!全天日射量[kJ/hm2]
      SR_kW = SR/3600.0    ! kJ/hm2 to W/m2

	!Check the Inputs for Problems (#,ErrorType,Text)
	!Sample Code: If( IN1 <= 0.) Call FoundBadInput(1,'Fatal','The first input provided to this model is not acceptable.')
 
      If(ErrorFound()) Return
!-----------------------------------------------------------------------------------------------------------------------

!-----------------------------------------------------------------------------------------------------------------------
!    *** PERFORM ALL THE CALCULATION HERE FOR THIS MODEL. ***
!-----------------------------------------------------------------------------------------------------------------------

	!-----------------------------------------------------------------------------------------------------------------------
	!If Needed, Get the Previous Control States if Discrete Controllers are Being Used (#)
	!Sample Code: CONTROL_LAST=getPreviousControlState(1)
	!-----------------------------------------------------------------------------------------------------------------------

	!-----------------------------------------------------------------------------------------------------------------------
	!If Needed, Get the Values from the Global Storage Array for the Static Variables (#)
	!Sample Code: STATIC1=getStaticArrayValue(1)
	!-----------------------------------------------------------------------------------------------------------------------

	!-----------------------------------------------------------------------------------------------------------------------
	!If Needed, Get the Initial Values of the Dynamic Variables from the Global Storage Array (#)
	!Sample Code: T_INITIAL_1=getDynamicArrayValueLastTimestep(1)
	!-----------------------------------------------------------------------------------------------------------------------

	!-----------------------------------------------------------------------------------------------------------------------
	!Perform All of the Calculations Here to Set the Outputs from the Model Based on the Inputs

	!Sample Code: OUT1=IN1+PAR1

	!If the model requires the solution of numerical derivatives, set these derivatives and get the current solution
	!Sample Code: T1=getNumericalSolution(1)
	!Sample Code: T2=getNumericalSolution(2)
	!Sample Code: DTDT1=3.*T2+7.*T1-15.
	!Sample Code: DTDT2=-2.*T1+11.*T2+21.
	!Sample Code: Call SetNumericalDerivative(1,DTDT1)
	!Sample Code: Call SetNumericalDerivative(2,DTDT2)

!-----------------------------------------------------------------------------------------------------------------------

!-----------------------------------------------------------------------------------------------------------------------
!Set the Outputs from this Model (#,Value)
        wbgt = 0.735 * Ta + 0.0374 * RH + 0.00292 * Ta * RH + 7.619 * SR_kW - 4.577 * SR_kW**2 - 0.0572 * WS - 4.064
		Call SetOutputValue(1, wbgt) ! WBGT

!-----------------------------------------------------------------------------------------------------------------------

!-----------------------------------------------------------------------------------------------------------------------
!If Needed, Store the Desired Disceret Control Signal Values for this Iteration (#,State)
!Sample Code:  Call SetDesiredDiscreteControlState(1,1)
!-----------------------------------------------------------------------------------------------------------------------

!-----------------------------------------------------------------------------------------------------------------------
!If Needed, Store the Final value of the Dynamic Variables in the Global Storage Array (#,Value)
!Sample Code:  Call SetDynamicArrayValueThisIteration(1,T_FINAL_1)
!-----------------------------------------------------------------------------------------------------------------------
 
      Return
      End
!-----------------------------------------------------------------------------------------------------------------------

