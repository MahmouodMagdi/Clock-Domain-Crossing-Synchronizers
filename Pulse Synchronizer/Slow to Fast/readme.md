# Slow to Fast Crossing Pulse Synchronizer


![pulse_synch](https://github.com/MahmouodMagdi/Clock-Domain-Crossing-Synchronizers/assets/72949261/6ec88005-7b55-4b9c-a145-23f0a7bc10fa)



- This circuit detects the rising edge of the input to the synchronizer and generates a clockwide, active-high pulse.
- Switching the inverter on the AND gate inputs creates a synchronizer that detects the falling edge of the input signal.
- Changing the AND gate to a NAND gate results in a circuit that generates an active-low pulse.
- The edge-detecting synchronizer works well at ***synchronizing a pulse going to a faster clock domain***.
- This circuit produces a pulse that indicates the rising or falling edge of the input signal. 

**One restriction of this synchronizer** is that the width of the input pulse must be greater than the period of the synchronizer clock plus the required hold time of the first synchronizer flip-flop. 
The safest pulse width is twice the synchronizer clock period. 

**Important Note** ```This synchronizer does not work if the input is a single clock wide pulse entering a slower clock domain.```





## Simulation Results

![pulse_synch_waiveform_0](https://github.com/MahmouodMagdi/Clock-Domain-Crossing-Synchronizers/assets/72949261/6f5d5173-1499-47b4-ac79-f986ca266923)

![pulse_synch_waiveform_1](https://github.com/MahmouodMagdi/Clock-Domain-Crossing-Synchronizers/assets/72949261/63314a9e-1e82-41c8-a84a-6e3171ca8354)

![pulse_synch_waiveform_2](https://github.com/MahmouodMagdi/Clock-Domain-Crossing-Synchronizers/assets/72949261/8dad02d3-069c-4c4d-b04a-9ed2501f583e)

![pulse_synch_waiveform_3](https://github.com/MahmouodMagdi/Clock-Domain-Crossing-Synchronizers/assets/72949261/a2f5abc8-c9fd-4c4e-8919-926007ad637a)
