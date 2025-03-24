module alu(a,b,op1,op2,y,y1,opcode);
input  signed [7:0]a,b;
input opcode;
output reg signed [8:0]y;
input op1;
input [1:0]op2;
output reg [7:0]y1;
always@(*)
if(opcode)
begin
case(op1)
1'b0:y=a+b;
1'b1:y=a-b;
endcase
end
else
begin
case(op2)
2'b00:y1=~($unsigned (a));
2'b01:y1=~($unsigned (b));
2'b10:y1=($unsigned (a&b));
2'b11:y1=($unsigned(a|b));

endcase
end
endmodule

//testbench for the alu
module test_alu();
reg signed [7:0] a,b;
reg opcode;
reg op1;
reg [2:0]op2;
wire signed [8:0]y;
wire [7:0]y1;
alu dut(.a(a),.b(b),.op1(op1),.y(y),.op2(op2),.y1(y1),.opcode(opcode));
initial
begin
//opcode 1 statrs from here
opcode=1;#10
op1=1'b0;a=5;b=6;#10
$display("5+6=%d",y);
op1=1'b1;a=-8;b=-9;#20
$display("8-9=%d(Hex:%h)",y,y);
op1=1'b1;a=-1;b=9;#30
$display("-1-9=%d(Hex:%h)",y,y);
//opcode 0 start from here
opcode=0;#40
op2=2'b10;a=3'b010;b=3'b111;#40;
$display("a&b=%b(Hex:%h)",y1,y1);
op2=2'b00;a=28;#50;
$display("a=%d(Hex:%h,a in binary:%b),~a=%d(Hex:%h,y in binary:%b)",a,a,a,y1,y1,y1);
op2=2'b01;b=25;#60;
$display("b=%d(Hex:%h,b in binary:%b),~b=%d(Hex:%h,y in binary:%b)",b,b,b,y1,y1,y1);
op2=2'b11;a=3'b101;b=3'b011;#70;
$display("a|b=%b(Hex:%h)",y1,y1);

$finish;

end
endmodule
