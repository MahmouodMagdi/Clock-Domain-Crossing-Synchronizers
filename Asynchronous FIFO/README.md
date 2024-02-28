# Asynchronous-FIFO
A verilog implementation of an aynchronous FIFO (First In First Out) including Synthesis, DFT, Scan Insertion and Formal Verification using TCL scripts.

# INTRODUCTION
An Asynchronous FIFO Design refers to a FIFO Design where in the data values are written to the FIFO memory from one clock domain 
and the data values are read from a different clock domain, where in the two clock domains are Asynchronous to each other.
FIFO’s are widely used to safely pass the data from one clock domain to another clock domain


![image](https://user-images.githubusercontent.com/72949261/213868606-11b3938e-f526-491e-90dc-d7e63132037b.png)


# DESCRIPTION OF FIFO DESIGNED
The above figure’s refers of an Asynchronous FIFO, it will be better if each block is explained

**1. FIFO MEMROY**: 
    This is the heart of the FIFO, the depth of memory is 16 bits and width is 8 bits,
    It has an the following inputs
    Write Data (8 bit), Write Enable, Read Enable, Write Clock, Write address (4 bit), 
    Read Address (4 bit) And an output i.e. Read Data (8 bit)
    Data which is to be written and the address where it has to be written is supplied at the input port write data and write address. At the positive edge of the         clock when Write enable is enabled so now the data is been written into the FIFO memory, now it has to be Read out, for that to happen Read enable should be           Enabled and the address from which the data has to be read should be specified at the input port Read address. This is the Memory operation in brief .now we have       to control the memory in such a way that it meets the requirements of the FIFO.

**2. BINARY & GRAY COUNTE**: 
    We need to design a counter which can give Binary and Gray output’s, the need for Binary counter is to address the FIFO MEMORY i.e. Write and Read address. And the     need of Gray counter is for addressing Read and Write pointers. Once the counter with binary and Gray code output is designed it is then Port mapped with Memory’s     Read address, write address, Read pointer, Write Pointer.
    
* The Use Full and Empty logic for addressing the memory:

| Signal |                                    Describtion                                   | 
|--------|----------------------------------------------------------------------------------| 
|  Full  | When ever the Full signal is high the counter should not increment write address |
|  Empty | The counter takes Empty signal and increments the Read address depending on this |
    
|       If (~EMPTY)             |         If (~FULL)            |                  
|-------------------------------|-------------------------------|
|Increment Read Address         |    Increment Write Address    |                
|Else                           |           Else                |                 
|No Increment                   |         No increment          |                 
    

# SYNCHRONIZERS
Synchronizers are very simple in operation; they are made of 2 D Flip Flop’s.
As the FIFO is operating at 2 different clock domains so there is a need to synchronize the Write and Read pointers for generating empty and full logic which in turn is used for addressing the FIFO memory.
The Figure below shows how synchronization takes place; the logic behind this is very simple.
![image](https://user-images.githubusercontent.com/72949261/213869582-55d66493-3b3f-4f8d-9165-23faa9b93e87.png)

What we are trying to do over here is , passing the Write Pointer to a D Flip Flop which is driven by the Read clock and in the same manner the Read pointer is fed to a D Flip Flop which is driven by Write Clock, so as a result of this we get Read Pointer (which is operating under Read clock) and Synchronized Write Pointer which is also operating under Read clock, and the same with Write pointer and Synchronized Read Pointer, so now we can compare them and derive a logic for Generating Empty and Full conditions, which is the most important design part of this FIFO.


# EMPTY AND FULL LOGIC BLOCK
In the above section we discussed mainly on the synchronizing part, I think the figures below are self explanatory:
![image](https://user-images.githubusercontent.com/72949261/213869673-bf4f22cd-3294-483f-b802-937c1255ca94.png)


 ```  
  If (  (synchronized Write pointer      == Read pointer) && 
        (Synchronized Write pointer [3:0] == Read pointer [3:0]) then
                Empty=1; 
  
  If (Write pointer == {~ synchronized Read pointer [4:3], synchronized Read pointer [2:0]) then 
                Full=1;
```


