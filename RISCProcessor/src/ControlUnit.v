module ControlUnit(
	input clk,
	input reset,
	input [4:0] func,
	input [1:0] op,
	input stop_bit,
	input zero,
	input FetchDone,
	output reg [1:0] PCSrc,
	output reg StackRd,
	output reg StackWr,
	output reg RegWr,
	output reg RegSrc,
	output reg [3:0] ALUOp,
	output reg MemWr,
	output reg MemRd,
	output reg WBData,
	output reg FetchEnable,
	output reg DecodeEnable,
	output reg RegFileEnable,
	output reg ALUEnable,
	output reg MemEnable,
	output reg WriteBackEnable
);

	//reg FETCH;
	//reg DECODE;
	//reg EXECUTE;
	//reg MEM_ACCESS;
	//reg WRITE_BACK;
	
	parameter [2:0] FETCH = 3'b000;
    parameter [2:0] DECODE = 3'b001;
    parameter [2:0] EXECUTE = 3'b010;
    parameter [2:0] MEM_ACCESS = 3'b011;
    parameter [2:0] WRITE_BACK = 3'b100;

    reg [2:0] STATE;
    reg [2:0] NEXT_STATE;

    initial begin
        STATE = FETCH;
		FetchEnable = 1'b1;
		DecodeEnable = 1'b1;
		RegFileEnable = 1'b1;
    end	
	
	always @(posedge clk) begin
        if (reset) begin
            STATE <= FETCH;
        end
        else begin
            STATE <= NEXT_STATE;
        end
    end

    always_comb begin
        case (STATE)
            FETCH:
                NEXT_STATE = DECODE;
            DECODE:
                NEXT_STATE = EXECUTE;
            EXECUTE:
                NEXT_STATE = MEM_ACCESS;
            MEM_ACCESS:
                NEXT_STATE = WRITE_BACK;
            default:
                NEXT_STATE = FETCH;
        endcase
    end
	
	always @(posedge clk) begin
        case (STATE)
            FETCH:
                begin
                    if(FetchDone==1'b1) begin
						FetchEnable<=1'b0;	
					end
					else begin
						FetchEnable <= 1'b1;
					end
					DecodeEnable <= 1'b1;
					ALUEnable <= 1'b0;
					MemEnable <= 1'b0;
					WriteBackEnable <= 1'b0;

                end
            DECODE:
                begin
                    // Control signals assignment for DECODE stage
                    FetchEnable <= 1'b0;
					DecodeEnable <= 1'b0;
					RegFileEnable <= 1'b1;
					ALUEnable <= 1'b1;
					MemEnable <= 1'b0;
					WriteBackEnable <= 1'b0;
                end
            EXECUTE:
                begin
                    // Control signals assignment for EXECUTE stage
                    FetchEnable <= 1'b0;
					DecodeEnable <= 1'b0;
					RegFileEnable <= 1'b0;
					ALUEnable <= 1'b1;
					MemEnable <= 1'b0;
					WriteBackEnable <= 1'b0;
                end
            MEM_ACCESS:
                begin
                    // Control signals assignment for MEM_ACCESS stage
                    FetchEnable <= 1'b0;
					DecodeEnable <= 1'b0;
					ALUEnable <= 1'b0;
					MemEnable <= 1'b1;
					WriteBackEnable <= 1'b0;
                end
            WRITE_BACK:
                begin
                    // Control signals assignment for WRITE_BACK stage
                    FetchEnable <= 1'b1;
					DecodeEnable <= 1'b0;
					ALUEnable <= 1'b0;
					MemEnable <= 1'b0;
					WriteBackEnable <= 1'b1;
					RegFileEnable <= 1'b1;
                end
        endcase
    end
	
	always @(posedge clk) begin
			
		//R type
		if(op==2'b00) begin
			PCSrc <= 2'b00;
			StackRd <= stop_bit;
			StackWr <= 1'b0;
			RegWr <= 1'b1;
			RegSrc <= 1'b0;
			MemWr <= 1'b0;
			MemRd <= 1'b0;
			WBData <= 1'b0;
			if(func==5'b00000) begin
				
				ALUOp <= 4'b0000;//AND
				
			end
			else if(func==5'b00001) begin
				
				ALUOp <= 4'b0001;//ADD
				
			end
			else if(func==5'b00010) begin
				
				ALUOp <= 4'b0010;//SUB
				
			end
			else if(func==5'b00011) begin
				
				ALUOp <= 4'b0011;//CMP
				
			end
			
			
		end//end of R type
		
		else if((op==2'b10) && (func==5'b00000)) begin
			//ANDI
			PCSrc <= 2'b00;
			StackRd <= stop_bit;
			StackWr <= 1'b0;
			RegWr <= 1'b1;
			RegSrc <= 1'b0;//we dont care
			MemWr <= 1'b0;
			MemRd <= 1'b0;
			WBData <= 1'b0;
			ALUOp <= 4'b0100;//ANDI
			
		end
		else if((op==2'b10) && (func==5'b00001)) begin
			//ADDI
			PCSrc <= 2'b00;
			StackRd <= stop_bit;
			StackWr <= 1'b0;
			RegWr <= 1'b1;
			RegSrc <= 1'b0;//we dont care
			MemWr <= 1'b0;
			MemRd <= 1'b0;
			WBData <= 1'b0;
			ALUOp <= 4'b0101;//ADDI
			
		end
		else if((op==2'b10) && (func==5'b00010)) begin
			//LW
			PCSrc <= 2'b00;
			StackRd <= stop_bit;
			StackWr <= 1'b0;
			RegWr <= 1'b1;
			RegSrc <= 1'b0;//we dont care
			MemWr <= 1'b0;
			MemRd <= 1'b1;
			WBData <= 1'b1;
			ALUOp <= 4'b0110;//LW
			
		end
		else if((op==2'b10) && (func==5'b00011)) begin
			//SW
			PCSrc <= 2'b00;
			StackRd <= stop_bit;
			StackWr <= 1'b0;
			RegWr <= 1'b0;
			RegSrc <= 1'b0;//we dont care
			MemWr <= 1'b1;
			MemRd <= 1'b0;
			WBData <= 1'b0;
			ALUOp <= 4'b0111;//SW
			
		end
		else if((op==2'b10) && (func==5'b00100) && (zero==1'b0)) begin
			//BEQ NOT TAKEN
			PCSrc <= 2'b00;
			StackRd <= stop_bit;
			StackWr <= 1'b0;
			RegWr <= 1'b0;
			RegSrc <= 1'b1;//we dont care
			MemWr <= 1'b0;
			MemRd <= 1'b0;
			WBData <= 1'b0;
			ALUOp <= 4'b1000;//BEQ
			
		end
		else if((op==2'b10) && (func==5'b00100) && (zero==1'b1)) begin
			//BEQ TAKEN
			PCSrc <= 2'b01;
			StackRd <= stop_bit;
			StackWr <= 1'b0;
			RegWr <= 1'b0;
			RegSrc <= 1'b1;//we dont care
			MemWr <= 1'b0;
			MemRd <= 1'b0;
			WBData <= 1'b0;
			ALUOp <= 4'b1000;//BEQ
			
		end
		else if((op==2'b01) && (func==5'b00000)) begin
			//Jump
			PCSrc <= 2'b10;
			StackRd <= stop_bit;
			StackWr <= 1'b0;
			RegWr <= 1'b0;
			RegSrc <= 1'b1;//we dont care
			MemWr <= 1'b0;
			MemRd <= 1'b0;
			WBData <= 1'b0;
			ALUOp <= 4'b1001;//J
			
		end
		else if((op==2'b01) && (func==5'b00001)) begin
			//Jump and link
			PCSrc <= 2'b10;
			StackRd <= stop_bit;
			StackWr <= 1'b1;
			RegWr <= 1'b0;
			RegSrc <= 1'b1;//we dont care
			MemWr <= 1'b0;
			MemRd <= 1'b0;
			WBData <= 1'b0;
			ALUOp <= 4'b1010;//Jal
			
		end
		else if((op==2'b11) && (func==5'b00000)) begin
			//SLL
			PCSrc <= 2'b00;
			StackRd <= stop_bit;
			StackWr <= 1'b0;
			RegWr <= 1'b1;
			RegSrc <= 1'b1;//we dont care
			MemWr <= 1'b0;
			MemRd <= 1'b0;
			WBData <= 1'b0;
			ALUOp <= 4'b1011;//SLL
			
		end
		else if((op==2'b11) && (func==5'b00001)) begin
			//SLR
			PCSrc <= 2'b00;
			StackRd <= stop_bit;
			StackWr <= 1'b0;
			RegWr <= 1'b1;
			RegSrc <= 1'b1;//we dont care
			MemWr <= 1'b0;
			MemRd <= 1'b0;
			WBData <= 1'b0;
			ALUOp <= 4'b1100;//SLR
			
		end
		else if((op==2'b11) && (func==5'b00010)) begin
			//SLLV
			PCSrc <= 2'b00;
			StackRd <= stop_bit;
			StackWr <= 1'b0;
			RegWr <= 1'b1;
			RegSrc <= 1'b0;
			MemWr <= 1'b0;
			MemRd <= 1'b0;
			WBData <= 1'b0;
			ALUOp <= 4'b1101;//SLLV
			
		end
		else if((op==2'b11) && (func==5'b00011)) begin
			//SLRV
			PCSrc <= 2'b00;
			StackRd <= stop_bit;
			StackWr <= 1'b0;
			RegWr <= 1'b1;
			RegSrc <= 1'b0;
			MemWr <= 1'b0;
			MemRd <= 1'b0;
			WBData <= 1'b0;
			ALUOp <= 4'b1110;//SLRV
			
		end
		
		if(stop_bit==1'b1) begin//if stop bit is 1
		
			PCSrc <= 2'b11;
			
		end
		
		
		
	end
	
	
	
endmodule
