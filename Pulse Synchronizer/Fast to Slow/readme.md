# Toggle Synchronizer

This technique is used when the following criteria is satisfied:
- source clock domain is faster than destination clock domain.
- Clock domain crossing (CDC)is on a single bit.
 

Toggle synchronizer is used to synchronize a pulse generated in a faster clock domain to a slower clock domain. In such scenarios a m-ff synchronizer fails as the destination ff may skip the incoming data pulse. The diagram below shows the implementation of a toggle synchronizer.

If the control signal changes too fast then the multi-flop synchronizer cannot avoid the sampling of a metastable signal at the receiving clock domain. In this case, we can use Toggle synchronizer as shown in the below diagram. The basic function of a pulse synchronizer is to take a single clock wide pulse from one clock domain and create a single clock wide pulse in the new domain.


![image](https://github.com/MahmouodMagdi/Clock-Domain-Crossing-Synchronizers/assets/72949261/36d0ccb1-b3f8-4ac1-aa0b-a194bbfc7e17)

**Protocol to be taken care of for Toggle Synchronizer**

One restriction of a pulse synchronizer is that input pulses must have a minimum spacing between pulses equal to two synchronizer clock periods. If the input pulses are closer, the output pulses in the new clock domain are adjacent to each other, resulting in an output pulse that is wider than one clock cycle.



## Simulation Result
![image](https://github.com/MahmouodMagdi/Clock-Domain-Crossing-Synchronizers/assets/72949261/90655a0f-1550-472d-98f4-6e950017db7e)

