`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////////
//                                                                                  //
//                                   Ring FIFO                                      //
//                                                                                  //
//              Can write when VALID is high, cannot when warning code 11.          //
//                                                                                  //
//              Can read when READY is high, cannot when warning code 10.           //
//                                                                                  //
//   Henry E Pritchard   /////////////////////////////////   Certain Synthesizers   //

module ring_fifo (
        input logic axis_aclk,
        input logic axis_aresetn,
        input logic [15:0] write_val,
        output reg [15:0]  read_val,
        input valid,
        input logic ready,
        output reg [1:0] warning);        
        
parameter depth =10;
parameter width =16;
parameter almost= 8;
reg [depth-1:0] top_pointer;
reg [depth-1:0] bottom_pointer;
reg [depth:0] capacity;
reg [width-1:0] fifo [2**depth-1:0];

assign warning = {top_pointer == bottom_pointer, capacity == 2**depth};

always @(posedge axis_aclk) begin
    if(axis_aresetn) begin
        top_pointer <= 0;
        bottom_pointer <= 0;
        read_val <= 0;
        capacity <= 0;
        for (int i=0; i<2**depth; i=i+1) fifo[i] <= 16'h0000;
    end else begin  
        if(valid) begin
            if(warning != 2'b11)begin
                fifo[top_pointer] = write_val; 
                top_pointer = top_pointer + 1; 
                capacity = capacity + 1; 
            end
        end 
        if (ready) begin
            if(warning != 2'b10)begin
                read_val = fifo[bottom_pointer];
                bottom_pointer = bottom_pointer + 1;
                capacity = capacity - 1; 
            end    
        end
    end
end

endmodule

