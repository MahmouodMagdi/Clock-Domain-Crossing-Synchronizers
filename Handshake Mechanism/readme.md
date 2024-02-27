# Handshake Synchronization Mechanism 

- The handshake protocol **converts the transmission problem of multi-bit data** into **a cross-clock domain problem of a single signal** (only the request signal **"REQ"** and the reply acknowledgement signal **"ACK"** are synchronized).

- The handshake protocol can only synchronize the request signal **"REQ"** and the response signal **"ACK"**, and the **data at the sending end remains unchanged during the validity of the request signal REQ**, so the handshake prototcol can meet the **needs of parallel data transmission security**.
  
