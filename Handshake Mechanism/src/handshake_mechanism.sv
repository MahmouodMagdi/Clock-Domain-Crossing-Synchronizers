module handshake_mechanism #(

    parameter DATA_WIDTH = 8

) (
    
    input   logic                        i_clk_a    ,                             // Source      Domain Clock 
    input   logic                        i_clk_b    ,                             // Destination Domain Clock 
    input   logic                        i_rst_n_a  ,                             // Active-Low asynchronous source      reset
    input   logic                        i_rst_n_b  ,                             // Active-Low asynchronous destination reset
    input   logic                        i_valid    ,                             // Input valid Signal indicating a valid data to be sent from d1 to d2
    input   logic   [DATA_WIDTH - 1 : 0] i_data     ,                             // Data that cosses from Domain 1 to Domain 2
    output  logic                        o_busy     ,
    output  logic                        o_valid    ,
    output  logic   [DATA_WIDTH - 1 : 0] o_data                                   // Synchronized output Data 

);


logic                      REQ, ACK, Sync_REQ, Sync_ACK, req_sync_0, ack_sync_0;
logic [DATA_WIDTH - 1 : 0] data_sync;


typedef enum logic { IDLE, WAIT } state;

state current_state, next_state;

assign o_busy = current_state;


//////////////////////////////////////////////////////
/// ---------------   Sender FSM   --------------- ///
//////////////////////////////////////////////////////

always_ff @( posedge i_clk_a or negedge i_rst_n_a ) begin : current_state_logic 
    
    if (!i_rst_n_a) begin

        current_state <= IDLE;

    end else begin

        current_state <= next_state;

    end

end


always_comb begin : next_state_logic
    
    case (current_state)

        IDLE: begin

            if (i_valid == 1'b1) begin

                next_state = WAIT;

            end else begin

                next_state = IDLE;

            end

        end
    
        WAIT: begin
            
            if (!(REQ ^ Sync_ACK)) begin

                next_state = IDLE;

            end else begin

                next_state = WAIT;
                
            end

        end 
    
        default: next_state = IDLE;
    
    endcase

end


////////////////////////////////////////////////////////////////////////
/// -------------   REQ Generation and Data Sampling   ------------- ///
////////////////////////////////////////////////////////////////////////

always_ff @( posedge i_clk_a or negedge i_rst_n_a ) begin : REQ_GENERATOR
    
    if (!i_rst_n_a) begin

        REQ       <= 'b0;
        data_sync <= 'b0;

    end else if( (!o_busy) && i_valid ) begin

        REQ       <= ~REQ;
        data_sync <= i_data;

    end

end



//////////////////////////////////////////////////////
/// ------------ REQ Synchronization ------------- ///
//////////////////////////////////////////////////////

always_ff @( posedge i_clk_b or negedge i_rst_n_b ) begin : REQ_Synchronizer 

   if (!i_rst_n_b) begin

        req_sync_0  <= 1'b0;
        Sync_REQ    <= 1'b0;

   end else begin

        req_sync_0  <= REQ;
        Sync_REQ    <= req_sync_0;

   end

end



//////////////////////////////////////////////////////
/// ------------ ACK Synchronization ------------- ///
//////////////////////////////////////////////////////

always_ff @( posedge i_clk_a or negedge i_rst_n_a ) begin : ACK_Synchronizer 

   if (!i_rst_n_a) begin

        ack_sync_0  <= 1'b0;
        Sync_ACK    <= 1'b0;

   end else begin

        ack_sync_0  <= ACK;
        Sync_ACK    <= ack_sync_0;

   end

end



////////////////////////////////////////////////////////////////////////
/// -------------   ACK Generation and Data Fetching   ------------- ///
////////////////////////////////////////////////////////////////////////

always_ff @( posedge i_clk_b or negedge i_rst_n_b ) begin : ACK_AND_OUTPUT
    
    if (!i_rst_n_b) begin
        
        ACK     <= 'b0;
        o_valid <= 'b0;
        o_data  <= 'b0;

    end else if(Sync_REQ ^ ACK) begin
        
        ACK     <= ~ACK;
        o_valid <= 1'b1;
        o_data  <= data_sync;

    end else begin
        
        o_valid <= 'b0;

    end

end
endmodule