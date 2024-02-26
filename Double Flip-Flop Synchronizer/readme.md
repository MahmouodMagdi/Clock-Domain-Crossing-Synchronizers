# Double Flip-Flop Synchronizer

The main problem with Clock Domain Crossing (CDC) is **metastability** due to setup or hold time violations of asynchronous crossing signals when capturing by the destination clock domain, in which the metastable state can propagate throughout the design causing data loss and even chip malfunction. Metastability in CDC design is not preventable, but synchronizers can be employed to avoid the propagation of the metastable state; hence, prevent system failures.


![image](https://github.com/MahmouodMagdi/Clock-Domain-Crossing-Synchronizers/assets/72949261/8935a50f-3bbd-4552-b953-8bfe10fe6aa6)


### How can two-FF synchronizers prevent metastability from propagating?

