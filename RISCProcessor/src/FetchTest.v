`timescale 1ns/1ps

module Fetch_tb;

  reg clk;
  reg reset;
  reg [1:0] PCsrc;
  reg [31:0] PCdecode;
  reg [31:0] PCj;
  reg [31:0] PCbranch;
  reg [31:0] PCstack;
  wire [31:0] nextPC;
  wire [31:0] instruction;
  wire valid;

  Fetch uut (
    .clk(clk),
    .reset(reset),
    .PCsrc(PCsrc),
	.PCdecode(PCdecode),
    .PCj(PCj),
    .PCbranch(PCbranch),
    .PCstack(PCstack),
    .nextPC(nextPC),
    .instruction(instruction),
    .valid(valid)
  );

  initial begin
    clk = 0;
    reset = 1;
    PCsrc = 0;
    PCj = 0;
    PCbranch = 0;
    PCstack = 0;
    #10 
	reset = 0; // Assert reset for 10 time units
    #20;
    $finish;
  end

  always #5 clk = ~clk;

endmodule
