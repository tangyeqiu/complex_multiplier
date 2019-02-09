	module cnm(rep,imp,rea,ima,req,imq); //8-bit multiplier

	output logic signed[15:0] rep, imp;
	input  logic signed[7:0] rea, req, ima, imq;
	
	logic signed[15:0] y0,y1,y2,y3;
	
	mult reaXreq (.y(y0), .a(rea), .b(req));
	mult imaXimq (.y(y1), .a(ima), .b(imq));
	mult reaXimq (.y(y2), .a(rea), .b(imq));
	mult imaXreq (.y(y3), .a(ima), .b(req));
	
	always_comb
		begin
			rep = y0-y1;
			imp = y2+y3;
		end
endmodule