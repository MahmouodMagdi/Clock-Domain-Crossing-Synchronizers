# Double Flip-Flop Synchronizer

The main problem with Clock Domain Crossing (CDC) is **metastability** due to setup or hold time violations of asynchronous crossing signals when capturing by the destination clock domain, in which the metastable state can propagate throughout the design causing data loss and even chip malfunction. Metastability in CDC design is not preventable, but synchronizers can be employed to avoid the propagation of the metastable state; hence, prevent system failures.

```A synchronizer is a device that samples an asynchronous signal and outputs a version of the signal that has transitions synchronized to a local or sample clock```


 - The simplest and most common synchronizer used by digital designers is a two-flip-flop synchronizer as shown in the following figure:

![image](https://github.com/MahmouodMagdi/Clock-Domain-Crossing-Synchronizers/assets/72949261/0088bb24-f5a3-403f-935d-52762daa469a)


The first flip-flop samples the asynchronous input signal into the new clock domain and waits for a full clock cycle to permit any metastability on the stage-1 output signal to decay, then the stage-1 signal is sampled by the same clock into a second stage flip-flop, with the intended goal that the stage-2 signal is now a stable and valid signal synchronized and ready for distribution within the new clock domain.


It is theoretically possible for the stage-1 signal to still be sufficiently metastable by the time the signal is clocked into the second stage to cause the stage-2 output signal to also go metastable.
The calculation of the probability of the time between synchronization failures (MTBF) is a function of multiple variables including the clock frequencies used to generate the input signal and to clock the synchronizing flip-flops. 



