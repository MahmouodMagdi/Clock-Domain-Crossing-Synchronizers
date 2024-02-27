///////////////////////////////////////////////////////////////////
//
//          Handshake Synchronizer Mechanism Test Bench 
//
//          Author: Mahmoud Magdi 
//
///////////////////////////////////////////////////////////////////


module handshake_tb #(

    parameter DATA_WIDTH = 8

);


logic                           i_clk_a;
logic                           i_clk_b;
logic                           rstn   ;
logic   [DATA_WIDTH - 1 : 0]    i_data ;
logic                           i_valid;
logic                           o_busy ;
logic                           o_valid;
logic   [DATA_WIDTH - 1 : 0]    o_data ;

logic   [DATA_WIDTH - 1 : 0]   expected [99:0];
logic   [DATA_WIDTH - 1 : 0]   result   [99:0];
logic   [DATA_WIDTH - 1 : 0]   ref_data;

int o_count, i_count;


handshake_mechanism #(
    
    .DATA_WIDTH(DATA_WIDTH)
    
) dut (

    .i_clk_a   (i_clk_a ), 
    .i_clk_b   (i_clk_b ), 
    .i_rst_n_a (rstn    ),
    .i_rst_n_b (rstn    ),
    .i_data    (i_data  ),
    .i_valid   (i_valid ),
    .o_busy    (o_busy  ),
    .o_valid   (o_valid ),
    .o_data    (o_data  )

);

always #5 i_clk_a  = ~i_clk_a;
always #13 i_clk_b = ~i_clk_b;


task send_data();
begin
    ref_data = $random;
    @(posedge i_clk_a);
    i_valid <= 1;
    i_data  <= ref_data;
    @(posedge i_clk_a);
    i_valid <= 0;
end
endtask

initial begin

    $dumpfile("handshake.vcd");
    $dumpvars(0,handshake_tb);

    i_count = 0;
    o_count = 0;
    i_clk_a = 0;
    i_clk_b = 0;
    rstn    = 1;

    #1 rstn = 0;
    #2 rstn = 1;
    for (int i = 0; i < 500; i++) begin
        send_data();
    end
    #500 $stop;
end

always_Ff @(posedge i_clk_a) begin
    if(~o_busy & i_valid) begin
        expected[i_count] <= i_data;
        i_count = i_count + 1;
    end
end

always_ff @(posedge o_valid) begin
    #1 result[o_count]     = o_data;
    #1 if(result[o_count] != expected[o_count]) begin
        $display("expected = %d     result = %d failed at time %t",expected[o_count], result[o_count], $time);
    end 
    else begin
        $display("expected = %d     result = %d",expected[o_count], result[o_count]);
    end

    #1 o_count = o_count + 1;
end

endmodule
