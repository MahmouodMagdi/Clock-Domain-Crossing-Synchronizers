///////////////////////////////////////////////////////////////////
//
//          Fast to Slow Pulse Toggle Synchronizer Test Bench 
//
//          Author: Mahmoud Magdi 
//
///////////////////////////////////////////////////////////////////


module tb_Pulse_Toggle_Synchronizer;

  // Parameters
  parameter DELAY_CYCLES = 10;  // Number of clock cycles to wait for stabilization
  

  // Signals
  logic  i_pulse;
  logic  i_clk_1;
  logic  i_rst_n;
  logic  i_clk_2;
  logic  o_pulse;

  // DUT Instantiation
  Pulse_Toggle_Synchronizer dut (

        .i_pulse (i_pulse),
        .i_clk_1 (i_clk_1),
        .i_rst_n (i_rst_n),
        .i_clk_2 (i_clk_2),
        .o_pulse (o_pulse)
        
  );
  

  
  // Clock Generation
  always #5 i_clk_1  = ~i_clk_1;                 // Generate a 50% duty cycle clock for i_clk_1
  always #10 i_clk_2 = ~i_clk_2;                // Generate a 50% duty cycle clock for i_clk_2
  
  // Stimulus
  initial begin
    
    // Initialize signals
    i_pulse = 'b0;
    i_clk_1 = 'b0;
    i_rst_n = 'b0;
    i_clk_2 = 'b0;


    // Reset De-assertion 
    #DELAY_CYCLES i_rst_n = 'b1;  


    // Apply input pulse
    #DELAY_CYCLES i_pulse = 'b1;
    
    // Wait for stabilization
    #DELAY_CYCLES i_pulse = 'b0;

    #(DELAY_CYCLES*3);

    // Apply input pulse
    #DELAY_CYCLES i_pulse = 'b1;
    
    // Wait for stabilization
    #DELAY_CYCLES i_pulse = 'b0;


    // Assertions
    assert(o_pulse === 1'b0) $display("Test passed: Output pulse is synchronized correctly");
      else $error("Test failed: Incorrect output pulse");
    
    #(DELAY_CYCLES*6);
    i_rst_n = 'b0;

    #(DELAY_CYCLES*10);
    i_rst_n = 'b1;

    #(DELAY_CYCLES*4);
    for (int i = 0; i < 15 ; i++ ) begin
        i_pulse = 'b1;
        #DELAY_CYCLES i_pulse = 'b0;
        #(DELAY_CYCLES*3);
    end

    // Finish simulation
    #(DELAY_CYCLES*10) $finish;
  end
  
endmodule
