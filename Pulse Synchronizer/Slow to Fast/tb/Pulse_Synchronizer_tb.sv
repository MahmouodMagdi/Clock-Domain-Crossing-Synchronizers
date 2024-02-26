//////////////////////////////////////////////////////////////////////
//
//            Slow to Fast Pulse Synchronizer Test Bench 
//
//            Author : MAHMOUD MAGDI
//
//////////////////////////////////////////////////////////////////////

module tb_pulse_synchronizer;

  // Parameters
  parameter SLOW_CLK_PER = 100,                                            // Slow Clock Period 
            FAST_CLK_PER = 30 ;                                            // Fast Clock Period                          

  // Signals
  logic i_slow_clk_tb   ;
  logic i_fast_clk_tb   ;
  logic i_rst_n_tb      ;
  logic i_pulse_tb      ;
  logic o_synch_pulse_tb;


  // DUT Instantiation
  pulse_synch dut (
    
        .i_slow_clk    (i_slow_clk_tb   ),
        .i_fast_clk    (i_fast_clk_tb   ),
        .i_rst_n       (i_rst_n_tb      ),
        .i_pulse       (i_pulse_tb      ),
        .o_synch_pulse (o_synch_pulse_tb)

  );
  

  // Clock Generation
  always #(SLOW_CLK_PER/2) i_slow_clk_tb = ~i_slow_clk_tb;                          // Generate a 50% duty cycle clock for i_slow_clk_tb
  always #(FAST_CLK_PER/2) i_fast_clk_tb = ~i_fast_clk_tb;                          // Generate a 50% duty cycle clock for i_fast_clk_tb

  
  // Stimulus
  initial begin

    // Initialize signals
    i_slow_clk_tb = 'b0;
    i_fast_clk_tb = 'b0;
    i_rst_n_tb    = 'b0;     
    i_pulse_tb    = 'b0;
    
    // Reset De-assertion 
    #(SLOW_CLK_PER*3) i_rst_n_tb = 1'b1; 

    // Slow-Domain pulse generation 
    #(SLOW_CLK_PER*4)
    for (int i = 0; i < 10 ; i++ ) begin
        i_pulse_tb = 1'b1;
        #SLOW_CLK_PER;
        i_pulse_tb = 1'b0;

        #(SLOW_CLK_PER*4);
    end
    
    // Reset the System 
    #(SLOW_CLK_PER/2) i_rst_n_tb    = 'b0;

    for (int i = 0; i < 4 ; i++ ) begin
        i_pulse_tb = 1'b1;
        #SLOW_CLK_PER;
        i_pulse_tb = 1'b0;

        #(SLOW_CLK_PER*6);
    end


    // De-assert the reset signal 
    #(SLOW_CLK_PER/2) i_rst_n_tb = 'b1;

    // Applying new pulses
    for (int i = 0; i < 4 ; i++ ) begin
        i_pulse_tb = 1'b1;
        #SLOW_CLK_PER;
        i_pulse_tb = 1'b0;

        #(SLOW_CLK_PER*3);
    end

    // Finish simulation
    #100 $finish;
  end
  
endmodule