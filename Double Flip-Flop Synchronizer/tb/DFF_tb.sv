//////////////////////////////////////////////////////////////////////
//
//            Single-Bit Double Flip Flop Synchronizer Test Bench 
//
//            Author : MAHMOUD MAGDI
//
//////////////////////////////////////////////////////////////////////

module tb_double_flip_flop_synchronizer;

  // Parameters
  parameter DELAY_CYCLES = 10;                                            // Number of clock cycles to wait for stabilization
  

  // Signals
  logic i_clk_tb  ;
  logic i_rst_n_tb;
  logic i_D_tb    ;
  logic o_q_tb    ;
  

  // DUT Instantiation
  Double_FF_Synch dut (
    
        .i_clk    (i_clk_tb    ),
        .i_rst_n  (i_rst_n_tb  ),
        .i_D      (i_D_tb      ),
        .o_q      (o_q_tb      )
  );
  

  // Clock Generation
  always #(DELAY_CYCLES/2) i_clk_tb = ~i_clk_tb;                          // Generate a 50% duty cycle clock for i_clk_tb

  
  // Stimulus
  initial begin
    // Initialize signals
    i_clk_tb   = 0;
    i_rst_n_tb = 0;
    i_D_tb     = 0;
    
    // Apply input data
    #DELAY_CYCLES i_rst_n_tb = 1; 
                  i_D_tb     = 1;
    
    // Wait for stabilization
    #DELAY_CYCLES;
    
    // Check output
    if (o_q_tb !== 1'b0) begin
      $display("Test failed: Incorrect output value");
    end else begin
      $display("Test passed: Output value is synchronized correctly");
    end

    #DELAY_CYCLES;
    if (o_q_tb !== 1'b1) begin
      $display("Test failed: Incorrect output value");
    end else begin
      $display("Test passed: Output value is synchronized correctly");
    end


	for(int i = 0; i < 20; i++)
	begin

		i_D_tb = $random;
		#DELAY_CYCLES;
		
	end
    
    // Finish simulation
    #DELAY_CYCLES $finish;
  end
  
endmodule
