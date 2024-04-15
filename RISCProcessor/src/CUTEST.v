module ControlUnit_TB;

  // Inputs
  reg clk;
  reg reset;
  reg [4:0] func;
  reg [1:0] op;
  reg stop_bit;
  reg zero;

  // Outputs
  wire [1:0] PCSrc;
  wire StackRd;
  wire StackWr;
  wire RegWr;
  wire RegSrc;
  wire ExtOp;
  wire [3:0] ALUOp;
  wire [1:0] ALUSrc;
  wire MemWr;
  wire MemRd;
  wire WBData;

  // Instantiate the unit under test (UUT)
  ControlUnit dut (
    .clk(clk),
    .reset(reset),
    .func(func),
    .op(op),
    .stop_bit(stop_bit),
    .zero(zero),
    .PCSrc(PCSrc),
    .StackRd(StackRd),
    .StackWr(StackWr),
    .RegWr(RegWr),
    .RegSrc(RegSrc),
    .ALUOp(ALUOp),
    .MemWr(MemWr),
    .MemRd(MemRd),
    .WBData(WBData)
  );

  // Clock initialization
  initial
    clk = 0;

  always #5
    clk = ~clk;

  // Reset initialization
  initial
    reset = 1;

  always #10
    reset = 0;

  // Stimulus
  initial begin
    // Set initial input values

    // Test case 1
    #10;
    func = 5'b00000;
    op = 2'b01;
    stop_bit = 1'b0;
    zero = 1'b0;


    #100;
    $finish;
  end

endmodule
