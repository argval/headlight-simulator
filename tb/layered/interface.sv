interface intf;
  
  logic clk;
  logic rst;
  logic lt;
  logic rt;
  logic haz;
  logic [2:0] ps, ns;
  parameter s0=3'd0, s1=3'd1, s2=3'd2, s3=3'd3, s4=3'd4, s5=3'd5;
  logic [2:0] li;
  logic [2:0] ri;
  
  // Modports for driver and monitor
  modport DRIVER (
    input clk,
    output rst, lt, rt, haz,
    input li, ri
  );
  
  modport MONITOR (
    input clk, rst, lt, rt, haz, li, ri
  );
  
endinterface