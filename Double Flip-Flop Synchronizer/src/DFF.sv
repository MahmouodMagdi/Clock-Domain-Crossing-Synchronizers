module Double_FF_Synch (

  input   logic   i_clk    ,
  input   logic   i_rst_n  ,
  input   logic   i_D      ,
  output  logic   o_q
  
);

  logic q0;

  always_ff @(posedge i_clk or negedge i_rst_n)
    begin

      if(!i_rst_n)
        begin
          
          q0  <= 'b0;
          o_q <= 'b0;
        
        end
      else
        begin
          
          q0  <= i_D;
          o_q <= q0;
        
        end
        
    end


endmodule 
