module ALU (
  input wire clk,
  input wire reset,
  input wire [3:0] ALUop,
  input wire [31:0] rs1,
  input wire [31:0] rs2,
  input wire [13:0] imm,
  input wire [4:0] SA,
  input wire ALUEnable,
  output wire [31:0] result,
  output wire zero
);

  reg [31:0] reg_rd;
  reg zero_reg;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      reg_rd <= 0;
      zero_reg <= 0;
    end 
  else 
	begin
		if(ALUEnable == 1'b1) begin
      case (ALUop)
        4'b0000: // AND
          reg_rd <= rs1 & rs2;

        4'b0001: // ADD 
			begin
		     	reg_rd <= rs1 + rs2;
			end		
			
        4'b0010: // SUB	 
			begin
		          reg_rd <= rs1 - rs2;
			end	 
			
        4'b0011: // CMP
	          zero_reg <= (rs1 < rs2);
	          // No need to assign reg_rd, carry, or overflow in CMP case

        4'b0100: // ANDI
        		reg_rd <= rs1 & { {18{imm[13]}}, imm }; // Sign-extend 14-bit immediate to 32-bit

        4'b0101: // ADDI 
			begin
		          reg_rd <= rs1 + { {18{imm[13]}}, imm }; // Sign-extend 14-bit immediate to 32-bit
			end	 
			
        4'b0110: // LW
          	reg_rd <= rs1 + imm;

        4'b0111: // SW
          	reg_rd <= rs1 + imm;

        4'b1000: // BEQ	 
			begin
		          zero_reg <= (rs1 == rs2);
		          // Reset carry and overflow flags for BEQ
			end
        4'b1011: // SLL
         	reg_rd <= rs1 <<< SA;

        4'b1100: // SRL
          	reg_rd <= rs1 >>> SA;

        4'b1101: // SLLV
         	reg_rd <= rs1 <<< rs2;

        4'b1110: // SRLV
        		reg_rd <= rs1 >>> rs2;
		
        default:   
		  begin
          	reg_rd <= 0;
		  end	 
		  
      endcase//of case	  
		  
      zero_reg <= (reg_rd == 0);
    end	//of else
  end
  end

  assign result = reg_rd;
  assign zero = zero_reg;

endmodule
