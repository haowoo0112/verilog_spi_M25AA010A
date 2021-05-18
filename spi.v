`timescale 1ns/1ns
module spi(
	input clk_50M,
	input reset,
	input write,
	input 	read,
    output reg	read_complete,
	output reg write_complete,
	input [7:0]write_value,
	output reg [7:0] read_value,
	output reg spi_sck,
	output reg spi_csn,
	output reg spi_do,
	output reg spi_di
	);
wire write_w;
reg [4:0]clk;
wire spi_clk_w;
reg [4:0]state;
reg [7:0]value;
reg [2:0]flag;
reg [7:0]prevalue;
wire clk_in;

always @(posedge clk_50M or negedge reset) begin
	if (!reset) begin
		clk<=0;
	end
	else begin
		clk<=clk+1'b1;
	end
end


always @(posedge clk_50M or negedge reset) begin
	if (!reset) begin
		clk<=0;
	end
	else begin
		clk<=clk+5'b1;
	end
end

always @(posedge clk_50M or negedge reset) begin
	if (!reset) begin
		state<=5'd0;
		spi_do<=1'b0;
		spi_sck<=1'b0;
		spi_csn<=1'b1;
		write_complete<=1'b1;
		value<=7'd0;
		flag<=3'd3;
	end
	else begin
		if (write_w) begin
			spi_csn<=1'b0;
			state<=state+5'd1;
			write_complete<=1'b0;
		end
		
			if (spi_clk_w) begin
					case(state)
						5'd0:begin spi_do<=1'b0;spi_sck=1'b0;end
						5'd1:begin spi_do<=write_value[7];spi_sck<=1'b0;write_complete<=1'b0;state<=state+5'd1;end
						5'd2:begin spi_do<=write_value[7];spi_sck<=1'b1;state<=state+5'd1;end
						5'd3:begin spi_do<=write_value[6];spi_sck<=1'b0;state<=state+5'd1;end
						5'd4:begin spi_do<=write_value[6];spi_sck<=1'b1;state<=state+5'd1;end
						5'd5:begin spi_do<=write_value[5];spi_sck<=1'b0;state<=state+5'd1;end
						5'd6:begin spi_do<=write_value[5];spi_sck<=1'b1;state<=state+5'd1;end
						5'd7:begin spi_do<=write_value[4];spi_sck<=1'b0;state<=state+5'd1;end
						5'd8:begin spi_do<=write_value[4];spi_sck<=1'b1;state<=state+5'd1;end
						5'd9:begin spi_do<=write_value[3];spi_sck<=1'b0;state<=state+5'd1;end
						5'd10:begin spi_do<=write_value[3];spi_sck<=1'b1;state<=state+5'd1;end
						5'd11:begin spi_do<=write_value[2];spi_sck<=1'b0;state<=state+5'd1;end
						5'd12:begin spi_do<=write_value[2];spi_sck<=1'b1;state<=state+5'd1;end
						5'd13:begin spi_do<=write_value[1];spi_sck<=1'b0;state<=state+5'd1;end
						5'd14:begin spi_do<=write_value[1];spi_sck<=1'b1;state<=state+5'd1;end
						5'd15:begin spi_do<=write_value[0];spi_sck<=1'b0;state<=state+5'd1;end
						5'd16:begin spi_do<=write_value[0];spi_sck<=1'b1;state<=state+5'd1;end
						5'd17:begin spi_sck<=1'b0;write_complete<=1'b1;state<=state+5'd1;
							if(flag==3'd3)begin
								value<=write_value;
								flag<=flag-3'd1;
								state<=state+5'd1;
							end
							if(value==0'h06)begin
								flag<=flag-3'd1;
								case(flag)
									2'd2:state<=5'd0;
									2'd1:state<=5'd0;
									2'd0:begin state<=state+5'd1;flag<=3'd3; end
								endcase
							end

						end
						5'd18:begin spi_csn<=1'b1;state<=0;end
					endcase
				
			end
		
	end
end




edge_detect_pos u1(.clk(clk_50M),.rst_n(reset),.data_in(write),.pos_edge(write_w));
edge_detect_pos u2(.clk(clk_50M),.rst_n(reset),.data_in(clk[4]),.pos_edge(spi_clk_w));
endmodule