//-----------------------------------------------------------------------------
//
// Title       : No Title
// Design      : RISCProcessor
// Author      : Sewe
// Company     : BZU
//
//-----------------------------------------------------------------------------
//
// File        : C:\Users\user\Desktop\MulticycleProcessor\RISCProcessor\compile\Processor.v
// Generated   : Sun Jul  9 15:54:43 2023
// From        : C:\Users\user\Desktop\MulticycleProcessor\RISCProcessor\src\Processor.bde
// By          : Bde2Verilog ver. 2.01
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------

`ifdef _VCP
`else
`define library(a,b)
`endif


// ---------- Design Unit Header ---------- //
`timescale 1ps / 1ps

module Processor (clk,reset,clk3,clk2,clk4,clk5) ;

// ------------ Port declarations --------- //
input clk;
wire clk;
input reset;
wire reset;
input clk3;
wire clk3;
input clk2;
wire clk2;
input clk4;
wire clk4;
input clk5;
wire clk5;

// ----------- Signal declarations -------- //
wire NET10930;
wire NET10959;
wire NET10967;
wire NET11059;
wire NET11090;
wire NET11953;
wire NET14513;
wire NET14523;
wire NET15096;
wire NET179;
wire NET189;
wire NET3686;
wire NET535;
wire NET554;
wire NET573;
wire NET803;
wire NET811;
wire [31:0] BUS10722;
wire [4:0] BUS14319;
wire [1:0] BUS14350;
wire [31:0] BUS1691;
wire [31:0] BUS17197;
wire [31:0] BUS17218;
wire [31:0] BUS17654;
wire [31:0] BUS17666;
wire [13:0] BUS229;
wire [3:0] BUS265;
wire [31:0] BUS5401;
wire [4:0] BUS6949;
wire [31:0] BUS7035;
wire [31:0] BUS7155;
wire [31:0] BUS7232;
wire [31:0] BUS7655;
wire [31:0] BUS7661;
wire [31:0] BUS7878;
wire [31:0] BUS8011;
wire [4:0] BUS81;
wire [1:0] BUS821;
wire [31:0] BUS829;
wire [4:0] BUS89;
wire [4:0] BUS97;

// -------- Component instantiations -------//

Register U10
(
	.in(BUS7035),
	.out(BUS7155)
);



RegisterFile U11
(
	.clk(NET3686),
	.RegWR(NET179),
	.RegSrc(NET189),
	.Rs(BUS81),
	.Rt(BUS89),
	.Rd(BUS97),
	.RegFileEnable(NET15096),
	.BusW(BUS1691),
	.BusA(BUS7035),
	.BusB(BUS7232)
);



Register U12
(
	.in(BUS7232),
	.out(BUS10722)
);



Register U13
(
	.in(BUS7655),
	.out(BUS7661)
);



Register U14
(
	.in(BUS7878),
	.out(BUS8011)
);



Decode U16
(
	.clk(NET3686),
	.instruction(BUS5401),
	.DecodeEnable(NET11059),
	.func(BUS14319),
	.Rs(BUS81),
	.Rt(BUS89),
	.Rd(BUS97),
	.op(BUS14350),
	.I_imm(BUS229),
	.SA(BUS6949),
	.pcJ(BUS17654),
	.pcB(BUS17666),
	.stop(NET14513)
);



ControlUnit U2
(
	.clk(NET3686),
	.reset(reset),
	.func(BUS14319),
	.op(BUS14350),
	.stop_bit(NET14513),
	.zero(NET14523),
	.FetchDone(NET11953),
	.PCSrc(BUS821),
	.StackRd(NET803),
	.StackWr(NET811),
	.RegWr(NET179),
	.RegSrc(NET189),
	.ALUOp(BUS265),
	.MemWr(NET554),
	.MemRd(NET535),
	.WBData(NET573),
	.FetchEnable(NET11090),
	.DecodeEnable(NET11059),
	.RegFileEnable(NET15096),
	.ALUEnable(NET10967),
	.MemEnable(NET10930),
	.WriteBackEnable(NET10959)
);



ALU U3
(
	.clk(NET3686),
	.reset(reset),
	.ALUop(BUS265),
	.rs1(BUS7155),
	.rs2(BUS10722),
	.imm(BUS229),
	.SA(BUS6949),
	.ALUEnable(NET10967),
	.result(BUS7655),
	.zero(NET14523)
);



Memory U4
(
	.clk(NET3686),
	.address(BUS7661),
	.data_in(BUS10722),
	.MemRd(NET535),
	.MemWr(NET554),
	.MemEnable(NET10930),
	.data_out(BUS7878)
);



Register U5
(
	.in(BUS17218),
	.out(BUS5401)
);



Stack U6
(
	.clk(NET3686),
	.write(NET811),
	.read(NET803),
	.data_in(BUS17197),
	.data_out(BUS829)
);



Fetch U7
(
	.clk(NET3686),
	.reset(reset),
	.PCsrc(BUS821),
	.PCnormal(BUS17197),
	.PCj(BUS17654),
	.PCbranch(BUS17666),
	.PCstack(BUS829),
	.FetchEnable(NET11090),
	.nextPC(BUS17197),
	.instruction(BUS17218),
	.valid(),
	.FetchDone(NET11953)
);



WriteBack U9
(
	.clk(NET3686),
	.ALU_out(BUS7661),
	.Mem_out(BUS8011),
	.WBData(NET573),
	.WriteBackEnable(NET10959),
	.BusW(BUS1691)
);



// ----------- Terminals assignment --------//
//	       ---- Input terminals ---         //
assign NET3686 = clk;
assign NET3686 = clk3;
assign NET3686 = clk2;
assign NET3686 = clk4;
assign NET3686 = clk5;

endmodule 
