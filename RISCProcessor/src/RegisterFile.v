//-----------------------------------------------------------------------------
//
// Title       : RegisterFile
//-----------------------------------------------------------------------------
//`timescale 1 ns / 1 ps

//{module {RegisterFile}}
module RegisterFile(
  input clk,
  input RegWR,
  input RegSrc,//RegSrc: 0 -> rt (normal flow ), 1 -> rd (in case of Store operation)
  input [4:0] Rs,
  input [4:0] Rt,
  input [4:0] Rd,
  input RegFileEnable,
  wire [31:0] BusW,
  output reg [31:0] BusA,
  output reg [31:0] BusB
);

  reg [31:0] registers [31:0];
  integer i;   
  reg counter;
  reg [31:0] BusWReg; // Local register variable for BusW

  initial begin	 
	counter =0;
    for (i = 0; i < 32; i = i + 1)
      registers[i] = i;
  end

  always @(posedge clk) begin
	  if(RegFileEnable==1'b1) begin
    BusA = registers[Rs];
    // Normal Flow
    if (RegSrc == 0 && Rt != 0) begin
      BusB = registers[Rt];
    end
    // In case of SW
    else if (RegSrc == 1 && Rd != 0) begin
      BusB = registers[Rd];
    end
	end
  end
  
  always @(negedge clk) begin
	  if(RegFileEnable==1'b1) begin
    // If there is a "write to register command," then rd is always the destination	 
		if (RegWR && Rd==Rs && counter!=2 && Rd != 0) begin
			counter = counter+1; 
		end
		
		else if(RegWR && Rd==Rs && counter==2 && Rd != 0) begin
			BusWReg = BusW; // Assign BusW to the local register variable
	     	registers[Rd] = BusWReg; 
		 	counter = 0;
	    end	
		
		else if (RegWR && Rd !=Rs && Rd != 0) begin
	      BusWReg = BusW; // Assign BusW to the local register variable
	      registers[Rd] = BusWReg;
	    end
	end
  end

endmodule