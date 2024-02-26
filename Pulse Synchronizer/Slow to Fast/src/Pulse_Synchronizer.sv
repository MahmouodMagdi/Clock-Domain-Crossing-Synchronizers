///////////////////////////////////////////////////////////
//
//          Slow to Fast Pulse Synchronizer 
//
//          Author: Mahmoud Magdi 
//
///////////////////////////////////////////////////////////


module pulse_synch (

       input    logic   i_slow_clk   ,                     // Slower Domain Clock                                                  
       input    logic   i_fast_clk   ,                     // Faster Domain Clock 
       input    logic   i_rst_n      ,                     // Active-Low Asynchronous Reset                      
       input    logic   i_pulse      ,                     // Input Pulse to be synchronized                      
       output   logic   o_synch_pulse                      // Output synchronized Pulse                      

);
    
    logic q, q0, q1, q2;

    always_ff @( posedge i_slow_clk or negedge i_rst_n ) begin : blockName
        
        if (!i_rst_n) begin
            q <= 'b0; 
        end else begin
            q <= i_pulse;
        end

    end



    always_ff @( posedge i_fast_clk or negedge i_rst_n ) begin 

        if (!i_rst_n) begin

            q0 <= 'b0;
            q1 <= 'b0;
            q2 <= 'b0;

        end else begin

            q0 <= q;
            q1 <= q0;
            q2 <= q1;

        end
        
    end

    assign o_synch_pulse = ~q2 & q1;

endmodule
