//-----------------------------------------------------------------------------
//
// Title       : Fetch
// Design      : RISCProcessor
// Author      : Sewe
// Company     : BZU
//
//-----------------------------------------------------------------------------
//
// File        : C:\Users\Administrator\Desktop\Year 4 Sem2\Arch\Proj2\MulticycleRISC\MulticycleProcessor\RISCProcessor\src\Fetch.v
// Generated   : Thu Jun 29 18:28:15 2023
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps

//{{ Section below this comment is automatically maintained
//   and may be overwritten
//{module {Fetch}}
module Fetch (
	input clk,
	input reset,
	input [1:0] PCsrc,//0:PC+4 1:PCbranch 2:PCj 3:PCstack
	input [31:0] PCnormal,
	input [31:0] PCj,
	input [31:0] PCbranch,
	input [31:0] PCstack,
	input FetchEnable,
	output reg [31:0] nextPC,
	output reg [31:0] instruction,
	output reg valid,
	output reg FetchDone
);

reg [31:0] IM [4:0];//instruction memory
reg counter = 1'b0;

initial begin
	//Jump and link + Stop bit (stack pop) test:
	IM[0]=32'b00001000010000100000000001000100;//ADDI Rs=00001, Rd=00010, IMM=8
	IM[1]=32'b00001000010001000000000100000100;//ADDI Rs=00001, Rd=00010, IMM=32
	IM[2]=32'b00001000000000000000000000100010;//Jal go to instruction [4], push PC=2+1 to stack
	IM[3]=32'b00001000010001000000000100011100;//ADDI Rs=00001, Rd=00010, IMM=35
	IM[4]=32'b00001000010001000000011100000101;//ADDI Rs=00001, Rd=00010, IMM=224, stop bit is 1, go back to 3
	
	//R type test: 
	//IM[0]=32'b00001000010001000000000001000100;//ADDI Rs=00001, Rd=00010, IMM=8
	//IM[1]=32'b00001000010001100000000100000100;//ADDI Rs=00001, Rd=00011, IMM=32
	//IM[2]=32'b00001000100011100011000000000000;//ADD Rs1=00010, Rd=00111, Rs2=00011 (Adding the above two results)
	
	//Load test:
	//IM[0]=32'b00010000010001100000000000000100;//Load from the address stored in Rs1=00001, store it in Rd=00011
	
	//SLL and SLLV test:
	//IM[0]=32'b00000000010001100100000100000110;//SLL Rs1=00001, Rd=00011, Rs2=00100, SA=00010
	//IM[1]=32'b00010000010001100100000100000110;//SLLV Rs1=00001, Rd=00011, Rs2=00100, SA=00010
	
	FetchDone <= 1'b0;
	instruction = 32'd0;
	PCreg = 32'd0;
	//nextPC = PCreg + 1'b1;
end

reg fetchValidReg;
reg done;
reg [31:0] PCreg;
reg [31:0] mem_address;

always @(posedge clk) begin
		
	if(FetchEnable == 1'b0)
		begin
			FetchDone <= 1'b0;
			instruction = 32'd0;
		end
	else begin
		if (PCsrc == 2'b00) begin
			PCreg = PCnormal;
		end
		else if (PCsrc==2'b01) begin
			PCreg = PCbranch;	
		end
		else if (PCsrc==2'b10) begin
			PCreg = PCj;	
		end
		else if (PCsrc==2'b11) begin
			PCreg = PCstack;	
		end
			mem_address <= {nextPC[31:2],2'b00};
			instruction <= IM[PCreg];
			//FetchDone <= 1'b1;
			//PCreg <= nextPC;
			if (instruction != 32'd0 && FetchDone != 1'b1) begin
				FetchDone <= 1'b1;
				nextPC <= PCreg + 1'b1;
				PCreg <= PCreg + 1'b1;
			end //else begin
				//FetchDone = 1'b0;
			//end
	end
	
	
end


endmodule
