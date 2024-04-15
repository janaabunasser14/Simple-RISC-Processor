module Stack(
  input clk,
  input write,
  input read,
  input [31:0] data_in,
  output reg [31:0] data_out
);

  reg [31:0] stack [0:31];
  reg [4:0] top = 5'b00000;

  always @(posedge clk) begin
    if (write) begin
      if (top < 31) begin
        stack[top] = data_in;
		top = top + 5'b00001;
      end
    end
    else if (read) begin
      if (top > 5'b00000) begin
		top = top - 1;
        data_out = stack[top];
      end
    end
  end

endmodule
