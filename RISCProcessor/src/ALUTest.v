module ALUTest;

  reg clk;
  reg reset;
  reg [3:0] ALUop;
  reg [31:0] rs1;
  reg [31:0] rs2;
  reg [13:0] imm;
  reg [4:0] SA;
  wire [31:0] result;
  wire zero;
  wire carry;
  wire overflow;
  
  ALU dut (
    .clk(clk),
    .reset(reset),
    .ALUop(ALUop),
    .rs1(rs1),
    .rs2(rs2),
    .imm(imm),
    .SA(SA),
    .result(result),
    .zero(zero),
    .carry(carry),
    .overflow(overflow)
  );
  
  initial begin
    clk = 0;
    reset = 1;
    ALUop = 4'b0000;
    rs1 = 32'b00000000000000000000000000000100;
    rs2 = 32'd2;
    imm = 14'b00000000100100;
    SA = 5'b00101;
    
    #10 reset = 0;
    
    // Test case 10: SLL
    ALUop = 4'b0100;
    #50;
    
    
    $finish;
  end
  
  always #5 clk = ~clk;
  
endmodule
