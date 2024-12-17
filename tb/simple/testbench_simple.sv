module testbench_simple;
  
  // Signals
  reg clk;
  reg rst;
  reg lt;
  reg rt;
  reg haz;
  wire [2:0] li;
  wire [2:0] ri;
  
  // Instantiate the DUT
  tailLight DUT (
    .clk(clk),
    .rst(rst),
    .lt(lt),
    .rt(rt),
    .haz(haz),
    .li(li),
    .ri(ri)
  );
  
  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  // Test stimulus
  initial begin
    // Initialize
    rst = 1;
    lt = 0;
    rt = 0;
    haz = 0;
    
    // Wait a few cycles and release reset
    repeat(3) @(posedge clk);
    rst = 0;
    
    // Test left turn signal
    @(posedge clk);
    lt = 1;
    repeat(10) @(posedge clk);
    lt = 0;
    
    // Test right turn signal
    @(posedge clk);
    rt = 1;
    repeat(10) @(posedge clk);
    rt = 0;
    
    // Test hazard
    @(posedge clk);
    haz = 1;
    repeat(20) @(posedge clk);
    haz = 0;
    
    // Test reset during operation
    @(posedge clk);
    haz = 1;
    repeat(5) @(posedge clk);
    rst = 1;
    repeat(2) @(posedge clk);
    rst = 0;
    haz = 0;
    
    // Run for a few more cycles and finish
    repeat(10) @(posedge clk);
    $finish;
  end
  
  // Monitor the outputs
  initial begin
    $dumpfile("headlight.vcd");
    $dumpvars(0, testbench_simple);
    
    $monitor("Time=%0t rst=%b lt=%b rt=%b haz=%b li=%b ri=%b",
             $time, rst, lt, rt, haz, li, ri);
  end
  
endmodule
