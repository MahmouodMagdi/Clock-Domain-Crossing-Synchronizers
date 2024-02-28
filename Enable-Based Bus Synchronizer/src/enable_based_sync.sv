/////////////////////////////////////////////////////////////
//
//          Enable-Based DATA BUS Synchronizer RTL Design 
//
//          Author: Mahmoud Magdi 
//
/////////////////////////////////////////////////////////////


module enable_based_sync #(

    parameter DATA_WIDTH = 32

) (
    
    input   logic                        i_src_clk        ,
    input   logic                        i_dest_clk       ,
    input   logic                        i_src_rst_n      ,
    input   logic                        i_dest_rst_n     ,
    input   logic                        i_next_data_pulse,
    input   logic   [DATA_WIDTH - 1 : 0] i_src_data       ,

    output  logic   [DATA_WIDTH - 1 : 0] o_dest_data

);


logic                      src_to_dest_en;                     // Generated enable "Level" signal that will be sent to the destinantion domain     
logic                      ff_q0         ;                     // Output of stage-1 of the DFF synchronizer
logic                      sync_en       ;                     // Synchronized enable "Level" signal
logic                      ff_q3         ;                     // Output of the destination toggle flop 
logic                      en            ;                     // Valid Synchronized enable pulse 
logic [DATA_WIDTH - 1 : 0] data_sync     ;                     // Data to be sent from src to dest





///////////////////////////////////////////////
// ---------- Input Data Sampling ---------- //
///////////////////////////////////////////////
always_ff @( posedge i_src_clk or negedge i_src_rst_n ) begin : in_data_reg
    
    if (!i_src_rst_n) begin

        data_sync <= 'b0;

    end else begin

        if (i_next_data_pulse) begin

            data_sync <= i_src_data;
        
        end else begin
        
            data_sync <= data_sync;
        
        end
    end

end





/////////////////////////////////////////////////
// ---------- Source Toggle Circuit ---------- //
/////////////////////////////////////////////////
/*
    Converting the pulse Enable Sigal into a level signal 
*/

assign o_xor = i_next_data_pulse ^ src_to_dest_en;

always_ff @( posedge i_src_clk or negedge i_src_rst_n ) begin : src_toggle_circuit

    if (!i_src_rst_n) begin

        src_to_dest_en <= 'b0;

    end else begin

        src_to_dest_en <= o_xor;

    end
end





/////////////////////////////////////////////////
// ------------ DFF  Synchronizer ------------ //
/////////////////////////////////////////////////
always_ff @( posedge i_dest_clk or negedge i_dest_rst_n ) begin : dff_synchronizer
    
    if (!i_dest_rst_n) begin

        ff_q0   <= 'b0;
        sync_en <= 'b0;

    end else begin

        ff_q0   <= src_to_dest_en;
        sync_en <= ff_q0;
        
    end
end





//////////////////////////////////////////////////////
// ---------- Destination Toggle Circuit ---------- //
//////////////////////////////////////////////////////

/*
    Converting the level Enable Sigal back into a pulse signal 
*/

always_ff @( posedge i_dest_clk or negedge i_dest_rst_n ) begin : dest_toggle_circuit

    if (!i_dest_rst_n) begin

        ff_q3 <= 'b0;

    end else begin

        ff_q3 <= sync_en;

    end
end

assign en = ff_q3 ^ sync_en;



////////////////////////////////////////////////////////////
// ---------- Sampling Data into Dest. Domain  ---------- //
////////////////////////////////////////////////////////////
always_ff @( posedge i_dest_clk or negedge i_dest_rst_n ) begin : Dest_Data_Sampling
    if (!i_dest_rst_n) begin

        o_dest_data <= 'b0;

    end else begin

        if (en) begin

            o_dest_data <= data_sync;

        end else begin

            o_dest_data <= o_dest_data;
            
        end
    end
end


endmodule