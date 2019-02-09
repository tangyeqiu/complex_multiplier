
//complex number multiplier 
module cnmctrl (output logic[7:0] LED,
							 input logic[9:0] SW,
							 input logic clk);
	logic nreset;
	
	logic signed[7:0] rea;
	logic signed[7:0] ima;
	logic signed[7:0] req;
	logic signed[7:0] imq;
	
	logic signed[15:0] rep;
	logic signed[15:0] imp;
	
	cnm cnm (.rep(rep),.imp(imp),.rea(rea),.ima(ima),.req(req),.imq(imq));

	enum {start, inprea, wait0, inpima, wait1, inpreq, wait2, inpimq, wait3, disprep, dispimp} state;
	
	always_ff@(posedge clk or negedge nreset)
		begin
			if(~nreset)
				begin
					rea <= '0;
					ima <= '0;
					req <= '0;
					imq <= '0;
					LED <= '0;
				end
			else
				begin
					unique case(state)
					start: 
						begin
							state <= inprea;
						end
					
					inprea:
						begin
							if(SW[8])
								begin
									rea <= SW[7:0];
									state <= wait0;
								end
							else
								begin
									rea <= '0;
									state <= inprea;
								end
						end
						
					wait0:
						begin
							LED <= SW[7:0];
							if(SW[8])
								state <= wait0;
							else
								state <= inpima;
						end
						
					inpima:
						begin
							if(SW[8])
								begin
									ima <= SW[7:0];
									state<=wait1;
								end
							else
								begin
									ima <= '0;
									state <= inpima;
								end
						end
					
					wait1:
						begin
							LED <= SW[7:0];
							if(SW[8])
								state <= wait1;
							else
								state <= inpreq;
						end
						
					inpreq:
						begin
							if(SW[8])
								begin
									req <= SW[7:0];
									state<=wait2;
								end
							else
								begin
									req <= '0;
									state<=inpreq;
								end
						end
					
					wait2:
						begin
							LED <= SW[7:0];
							if(SW[8])
								state <= wait2;
							else
								state <= inpimq;
						end
						
					inpimq:
						begin
							if(SW[8])
								begin
									imq <= SW[7:0];
									state<=wait3;
								end
							else
								begin
									imq <= '0;
									state<=inpimq;
								end
						end
						
					wait3:
						begin
							LED <= SW[7:0];
							if(SW[8])
								state <= wait3;
							else
								state <= disprep;
						end
						
					disprep:
						begin
							if(SW[8])
								begin
									state <= dispimp;
									LED <= '0;
								end
							else
								begin
									state <= disprep;
									LED <= rep[14:7];
								end
						end
						
					dispimp:
						begin
							if(SW[8])
								begin
									state <= dispimp;
									LED <= imp[14:7];
								end
							else
								begin
									state <= start;
									LED <= '0;
								end
						end
					endcase
				end
		end
		
	always_comb
		begin
			nreset = SW[9];
		end
endmodule
