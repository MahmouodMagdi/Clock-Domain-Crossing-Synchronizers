///////////////////////////////////////////////////////////
//
//          Fast to Slow Pulse Toggle Synchronizer 
//
//          Author: Mahmoud Magdi 
//
///////////////////////////////////////////////////////////



module Pulse_Toggle_Synchronizer (
    
    input   logic i_pulse,
    input   logic i_clk_1,
    input   logic i_rst_n,
    input   logic i_clk_2,
    output  logic o_pulse
);
    
    logic q0, q1,q2,q3;
    
    always_ff @( posedge i_clk_1 or negedge i_rst_n ) begin
    
        if(!i_rst_n)
        begin
            q0 <= 1'b0;
        end
        else if (i_pulse)
        begin
            q0 <= ~q0; 
        end    
        else begin
            q0 <= q0;
        end
    
    end

    always_ff @( posedge i_clk_2 or negedge i_rst_n) begin

        if(!i_rst_n) begin

            q1 <= 'b0;   
            q2 <= 'b0;   
            q3 <= 'b0;       

        end

        else begin
            q1 <= q0;
            q2 <= q1;
            q3 <= q2;            
        end

    end

    assign o_pulse = q2 ^ q3;

endmodule