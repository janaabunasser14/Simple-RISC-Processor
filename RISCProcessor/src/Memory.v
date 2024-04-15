module Memory(
	input clk,
	input [31:0] address,
	input [31:0] data_in,
	input MemRd,
	input MemWr,
	input MemEnable,
	output reg [31:0] data_out
);
	
reg [31:0] memory [255:0];

initial begin
  integer i;
  reg [31:0] lfsr;

  // Initialize the LFSR register
  lfsr = 32'hACE1B5ED;

  // Loop through each element of the array
  for (i = 0; i < 256; i = i + 1) begin
    memory[i] = lfsr;
    lfsr = {lfsr[0] ^ lfsr[1] ^ lfsr[3] ^ lfsr[4], lfsr[31:1]};
  end
end

always @(posedge clk) begin
	
	if(MemEnable == 1'b1) begin

	if(MemWr == 1'b1) begin
	
		memory[address] = data_in;	
		
	end
	else if(MemRd == 1'b1) begin
	
		data_out = memory[address];
	
	end
	end
	
	
end

endmodule