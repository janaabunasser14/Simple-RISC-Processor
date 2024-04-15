module MemTest;
  
  reg clk;
  reg [31:0] address;
  reg [31:0] data_in;
  reg MemRd;
  reg MemWr;
  reg MemEnable;
  wire [31:0] data_out;
  
  // Instantiate the Memory module
  Memory dut (
    .clk(clk),
    .address(address),
    .data_in(data_in),
    .MemRd(MemRd),
    .MemWr(MemWr),
	.MemEnable(MemEnable),
    .data_out(data_out)
  );
  
  // Clock generation
  always #5 clk = ~clk;
  
  // Test sequence
  initial begin
	MemEnable = 1'b1;
    clk = 0;
    address = 0;
    data_in = 0;
    MemRd = 0;
    MemWr = 0;
    
    // Perform write operation
    #10;
    MemWr = 1;
    address = 0; // Address to write to
    data_in = 32'h12345678; // Data to be written
    #10;
    MemWr = 0;
	#10
    
    // Perform read operation
    #10;
    MemRd = 1;
    address = 0; // Address to read from
    #10;
    MemRd = 0;
    
    // Verify the read data
    if (data_out === 32'h12345678) begin
      $display("Read data is correct!");
    end else begin
      $display("Read data is incorrect!");
    end
    
    // Perform additional read/write operations as needed
    
    #20;
    $finish; // End simulation
  end
  
endmodule
