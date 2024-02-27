# Handshake Synchronization Mechanism 

- The handshake protocol **converts the transmission problem of multi-bit data** into **a cross-clock domain problem of a single signal** (only the request signal **"REQ"** and the reply acknowledgement signal **"ACK"** are synchronized).

- The handshake protocol can only synchronize the request signal **"REQ"** and the response signal **"ACK"**, and the **data at the sending end remains unchanged during the validity of the request signal REQ**, so the handshake protocol can meet the **needs of parallel data transmission security**.


## How does the protocol work

  1. The sender **first drives the multi-bit data to the bus (the data is ready first)**, and then **sends the request signal "REQ"**.
  2. The request signal **"REQ"** is then **synchronized into the receiving clock domain** using **Double-Flip-Flop Synchronizer**
  3. The receiver recognizes that the **"REQ"** is valid and receives this set of data (**her only the "REQ" needs to be synchronized to the clock domain of the receiver**).
  4. After receiving, the receiving end returns a reply signal **"ACK"**.
  5. This **"ACK"** is then **synchronized back to the sending domain** using **DFF synchronizer**.
  6. If the sender recognizes that the **"ACK"** is valid, the **"REQ"** will be lowered (**here only the ACK needs to be synchronized to the sender clock domain**)


![image](https://github.com/MahmouodMagdi/Clock-Domain-Crossing-Synchronizers/assets/72949261/ee6db1d0-e637-4f9c-afc5-2b416d37be80)


## FSM
![image](https://github.com/MahmouodMagdi/Clock-Domain-Crossing-Synchronizers/assets/72949261/fc5f7c28-a973-4d73-941d-67e47856e9a8)


## Simulation Results 
### a. WaiveForm
![image](https://github.com/MahmouodMagdi/Clock-Domain-Crossing-Synchronizers/assets/72949261/606456bb-7b78-42ae-925e-9599077aa51b)

![image](https://github.com/MahmouodMagdi/Clock-Domain-Crossing-Synchronizers/assets/72949261/8deae2f1-7ff1-4714-9d1e-e67468bc2117)


### b. Terminal 

![image](https://github.com/MahmouodMagdi/Clock-Domain-Crossing-Synchronizers/assets/72949261/c99361a4-ae28-4b28-b3e5-8c7291b86302)

![image](https://github.com/MahmouodMagdi/Clock-Domain-Crossing-Synchronizers/assets/72949261/aff2d0f6-0ec5-4a76-a66e-4ca602a9c5b0)
