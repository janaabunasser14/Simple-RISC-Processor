module StackTest;
  
  reg clk;
  reg write;
  reg read;
  reg [31:0] data_in;
  wire [31:0] data_out;
  
  // Instantiate the Stack module
  Stack dut (
    .clk(clk),
    .write(write),
    .read(read),
    .data_in(data_in),
    .data_out(data_out)
  );
  
  // Clock generation
  always #5 clk = ~clk;
  
  // Test sequence
  initial begin
    clk = 0;
    write = 0;
    read = 0;
    data_in = 0;
    
    // Push data onto the stack
    #10;
    write = 1;
    data_in = 32'h12345678; // Data to be pushed
    #10;
    write = 0;
    
    #10;
    write = 1;
    data_in = 32'hAABBCCDD; // Data to be pushed
    #10;
    write = 0;
    
    #10;
    write = 1;
    data_in = 32'h11223344; // Data to be pushed
    #10;
    write = 0;
    
    // Pop data from the stack
    #20;
    read = 1;
    #10;
    read = 0;
	#220;
    
    // Verify the popped data
    if (data_out === 32'h11223344) begin
      $display("Popped data is correct!");
    end else begin
      $display("Popped data is incorrect!");
    end
    
    #10;
    read = 1;
    #10;
    read = 0;
    
    // Verify the popped data
    if (data_out === 32'hAABBCCDD) begin
      $display("Popped data is correct!");
    end else begin
      $display("Popped data is incorrect!");
    end
    
    // Perform additional push/pop operations as needed
    
    #20;
    $finish; // End simulation
  end
  
endmodule
