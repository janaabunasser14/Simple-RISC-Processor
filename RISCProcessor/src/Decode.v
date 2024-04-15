//-----------------------------------------------------------------------------
//
// Decode Stage
//
//-----------------------------------------------------------------------------
//`timescale 1 ns / 1 ps

//{module {Decode}}
module Decode ( clk ,instruction , DecodeEnable, func ,Rs ,Rt ,Rd ,op ,I_imm ,SA ,pcJ ,pcB, stop);

input clk ;
input [31:0] instruction ;
input DecodeEnable;

output reg [4:0] func ;	

output reg [4:0] Rs ;	  

output reg [4:0] Rt ;

output reg [4:0] Rd ;

output reg [1:0] op ;

output reg [13:0] I_imm ;

output reg [4:0] SA ;

output reg [31:0] pcJ ;

output reg [31:0] pcB ;

output reg stop ;
//To store the extended value of the immediate in I or J types
reg[31:0] imm32;
reg [31:0] J_imm;
reg [31:0] PCreg;
reg [31:0] decimal_to_add = 4;

always @(posedge clk) 
	begin  
		//common fields among the instructions:
		//00: R-Type, 01: J-Type, 10: I-type, 11: S-type)
		if(DecodeEnable == 1'b1) begin
			
			op <= instruction[2:1]; 
			//2. the Function filed 
			func <= instruction[31:27];	 
			// 3. the "stop" bit
			stop <= instruction[0];
			I_imm <= instruction[16:3];
			J_imm = instruction[25:3];
			pcJ = J_imm;
			pcB = I_imm;
			Rs <= instruction[26:22];
			Rt <= instruction[16:12];
			Rd <= instruction[21:17]; 	
			SA <= instruction[11:7];
		
		end
	end



endmodule
