# Handshake Synchronization Mechanism 

- The handshake protocol **converts the transmission problem of multi-bit data** into **a cross-clock domain problem of a single signal** (only the request signal **"REQ"** and the reply acknowledgement signal **"ACK"** are synchronized).

- The handshake protocol can only synchronize the request signal **"REQ"** and the response signal **"ACK"**, and the **data at the sending end remains unchanged during the validity of the request signal REQ**, so the handshake prototcol can meet the **needs of parallel data transmission security**.


## How does the protocol work

  1. The sender **first drives the multi-bit data to the bus (the data is ready first)**, and then **sends the request signal "REQ"**.
  2. The request signal **"REQ"** is then **synchronized into the receiving clock domain** using **Double-Flip-Flop Synchronizer**
  3. The receiver recognizes that the **"REQ"** is valid and receives this set of data (**her only the "REQ" needs to be synchronized to the clock domain of the receiver**).
  4. After receiving, the receiving end returns a reply signal **"ACK"**.
  5. This **"ACK"** is then **synchronized back to the sending domain** using **DFF synchronizer**.
  6. If the sender recognizes that the **"ACK"** is valid, the **"REQ"** will be lowered (**here only the ACK needs to be synchronized to the sender clock domain**)


![image](https://github.com/MahmouodMagdi/Clock-Domain-Crossing-Synchronizers/assets/72949261/ee6db1d0-e637-4f9c-afc5-2b416d37be80)


