module WriteBack(
	input clk,
	input [31:0] ALU_out,
	input [31:0] Mem_out,
	input WBData,
	input WriteBackEnable,
	output reg [31:0] BusW
); 

always @(posedge clk) begin
	
	if(WriteBackEnable == 1'b1) begin

	if(WBData == 1'b0) begin
	
		BusW <= ALU_out;
		
	end
	else if(WBData == 1'b1) begin
	
		BusW <= Mem_out;
		
	end
	end
	
end

endmodule