
module mult(y,a,b); //8-bit multiplier

	output logic [15:0] y;
	input  logic [7:0] a,b;
	
	logic [15:0] y_tmp;
	logic [7:0]  a_tmp;
	logic [7:0]  b_tmp;
	
	logic [14:0] c1;
	logic [10:0] c2;            
	logic [14:0] out1;
	logic [12:0] out2;
	logic [10:0] out3;
	logic [8:0]  out4;
	logic [14:0] m_temp0;
	logic [13:0] m_temp1;
	logic [12:0] m_temp2;
	logic [11:0] m_temp3;
	logic [10:0] m_temp4;
	logic [9:0]  m_temp5;
	logic [8:0]  m_temp6;
	logic [7:0]  m_temp7;

	always_comb
		begin
			if(a[7])
				begin
					a_tmp = ~a+1'b1;
					if(b[7])
						begin
							b_tmp = ~b+1'b1;
							y = y_tmp ;
						end
					else
						begin
							b_tmp = b;
							y = ~y_tmp+1'b1;
						end
				end
			else
				begin
					a_tmp = a;
					if(b[7])
						begin
							b_tmp = ~b+1'b1;
							y = ~y_tmp+1'b1;
						end
					else
						begin
							b_tmp = b;
							y = y_tmp;
						end
				end
			
		end
	
	always_comb
		begin
			out1 = m_temp0 + m_temp1;
			out2 = m_temp2 + m_temp3;
			out3 = m_temp4 + m_temp5;
			out4 = m_temp6 + m_temp7;
			c1   = out1    + out2;
			c2   = out3    + out4;
			y_tmp= c1      + c2;
		end
		
	always_comb
		begin		
			m_temp0[14:7] = b_tmp[7]?a_tmp:8'b00000000;
			m_temp0[6:0]  = 7'b0000000;
			m_temp1[13:6] = b_tmp[6]?a_tmp:8'b00000000;
			m_temp1[5:0]  = 6'b000000;
			m_temp2[12:5] = b_tmp[5]?a_tmp:8'b00000000;
			m_temp2[4:0]  = 5'b00000;
			m_temp3[11:4] = b_tmp[4]?a_tmp:8'b00000000;
			m_temp3[3:0]  = 4'b0000;
			m_temp4[10:3] = b_tmp[3]?a_tmp:8'b00000000;
			m_temp4[2:0]  = 3'b000;
			m_temp5[9:2]  = b_tmp[2]?a_tmp:8'b00000000;
			m_temp5[1:0]  = 2'b00;
			m_temp6[8:1]  = b_tmp[1]?a_tmp:8'b00000000;
			m_temp6[0]    = 1'b0;
			m_temp7       = b_tmp[0]?a_tmp:8'b00000000;
		end
endmodule
