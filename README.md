# Automata and Discrete Control

This is the repository for the Final Project of "Automata and Discrete Control" ‚

*Topic:* Port crane control

*Goal:* Development and implementation of a hybrid control and protection automaton for semi-automatic operation of a  for coordinated semi-automatic operation on a port gantry dock-mounted container crane port gantry-type quay crane (Figure 1).

***Stages:***
    *A-) Design, conceptual modeling and performance analysis using Model-in-the-Loop (Stateflow - Simulink)  Model-in-the-Loop simulation (Stateflow - Simulink);
    *B-) Implementation in an industrial industrial automaton programming environment according to IEC 61131 standard (CODESYS) and Software-in-the-Loop co-simulation (CODESYS - Simulink communicated via OPC UA).  via OPC UA).

***

### Control Levels

***Level 0: Safety and protection ->***  consists of a smaller and more reliable automaton, which must take control in case of critical failure and/or safety risk. take control in case of critical failure of lower levels and/or security risk.

***Level 1: Global supervisory control ->*** Event-driven discrete-state, hierarchically structured and/or concurrency, for smooth and efficient operation with path coordination and optimization, global system operation control and diagnostics (alarms and faults). trajectories, global system operation control and diagnostics (alarms and faults).

***Level 2: Motion Controllers ->*** Discrete-time continuous state controllers are responsible for receiving individual motion commands from the supervisory control for direct control of each of the main hoisting and translation motions. of the main hoisting and translation movements.

***

### Tech Stack

*Proposition*

- CODESYS V3.5 SP17 == PLC programming for Control levels 0 and 1.
- Matlab,Simulink == Simulation of the physical model and Control Level 2.
- OPC-UA protocol == Communication between CODESYS and Matlab.

