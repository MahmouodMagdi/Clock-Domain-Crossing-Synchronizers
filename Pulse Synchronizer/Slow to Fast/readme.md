# Slow to Fast Crossing Pulse Synchronizer


![image](https://github.com/MahmouodMagdi/Clock-Domain-Crossing-Synchronizers/assets/72949261/63474fdf-df03-4f36-8dc9-66f90e14bd63)


- This circuit detects the rising edge of the input to the synchronizer and generates a clockwide, active-high pulse.
- Switching the inverter on the AND gate inputs creates a synchronizer that detects the falling edge of the input signal.
- Changing the AND gate to a NAND gate results in a circuit that generates an active-low pulse.
- The edge-detecting synchronizer works well at ***synchronizing a pulse going to a faster clock domain***.
- This circuit produces a pulse that indicates the rising or falling edge of the input signal. 

**One restriction of this synchronizer** is that the width of the input pulse must be greater than the period of the synchronizer clock plus the required hold time of the first synchronizer flip-flop. 
The safest pulse width is twice the synchronizer clock period. 

**Important Note** ```This synchronizer does not work if the input is a single clock wide pulse entering a slower clock domain.```
