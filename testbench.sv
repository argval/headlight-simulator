`timescale 1ns/1ns
`include "interface.sv"
`include "test.sv"

module tailLight_tb;

  reg haz, rt, lt, clk, rst;
  logic [2:0] li;
  logic [2:0] ri;

  intf i_intf();
  test t1(i_intf);

  initial clk = 1'b0;
  initial forever #10 clk =~clk;
  
    
  /*always @(posedge i_intf.clk or negedge i_intf.rst) begin
    // Drive li and ri signals from the interface
    li <= i_intf.li;
    ri <= i_intf.ri;
  end*/
  
  initial
    begin
      #10 haz=0;rst=1;rt=0;lt=1;
      #90 lt=0;
      #100 haz=0;rst=0;rt=0;lt=1;
      #100 haz=1;lt=0;
      #130 haz=0;rt=1;
    end

  tailLight DUT (
    .clk(i_intf.clk),
    .rst(i_intf.rst),
    .lt(i_intf.lt),
    .rt(i_intf.rt),
    .haz(i_intf.haz),
    .li(i_intf.li),
    .ri(i_intf.ri)
  );

  initial begin
    $dumpfile("taillight.vcd");
    $dumpvars(0, tailLight_tb);
    #700 $finish;
  end

endmodule
