/////////////////////////////////////////////////////////////
//
//          Enable-Based DATA BUS Synchronizer Test Bench
//
//          Author: Mahmoud Magdi 
//
/////////////////////////////////////////////////////////////

module enable_based_sync_tb #(

    parameter DATA_WIDTH   = 32,
              SRC_CLK_PER  = 10,
              DEST_CLK_PER = 30

) (
    


);

logic                        i_src_clk        ;
logic                        i_dest_clk       ;
logic                        i_rst_n          ;
logic                        i_next_data_pulse;
logic   [DATA_WIDTH - 1 : 0] i_src_data       ;
logic   [DATA_WIDTH - 1 : 0] o_dest_data      ;      

enable_based_sync #(

    .DATA_WIDTH(DATA_WIDTH)

) DUT (
    
    .i_src_clk        (i_src_clk        ),
    .i_dest_clk       (i_dest_clk       ),
    .i_src_rst_n      (i_rst_n          ),
    .i_dest_rst_n     (i_rst_n          ),
    .i_next_data_pulse(i_next_data_pulse),
    .i_src_data       (i_src_data       ),
    .o_dest_data      (o_dest_data      )

);

always #(SRC_CLK_PER/2)  i_src_clk  = ~i_src_clk;
always #(DEST_CLK_PER/2) i_dest_clk = ~i_dest_clk;


task send_data();
begin
        #SRC_CLK_PER i_src_data  = $random;
                     i_next_data_pulse = 'b1;

        #(SRC_CLK_PER)  i_next_data_pulse = 'b0;

        #(DEST_CLK_PER*3);
end
endtask

initial begin

    $dumpfile("enable_based_sync_tb.vcd");
    $dumpvars(1,enable_based_sync_tb);

    i_src_clk         = 'b0;
    i_dest_clk        = 'b0;
    i_rst_n           = 'b0;
    i_next_data_pulse = 'b0;
    i_src_data        = 'b0;

    #50 i_rst_n = 1;

    send_data ();

    for (int i = 0; i < 10 ; i++ ) begin

        send_data();
    end

    #DEST_CLK_PER    i_rst_n           = 'b0;
    #500             i_rst_n           = 'b1;

    for (int i = 0; i < 10 ; i++ ) begin
        send_data();
    end

    #500 $stop;

end

endmodule