module tb_top;
  
  // Instantiate the interface
  intf i_intf();
  
  // Clock generation
  initial begin
    i_intf.clk = 0;
    forever #5 i_intf.clk = ~i_intf.clk;
  end
  
  // Instantiate the DUT
  tailLight DUT (
    .clk(i_intf.clk),
    .rst(i_intf.rst),
    .lt(i_intf.lt),
    .rt(i_intf.rt),
    .haz(i_intf.haz),
    .li(i_intf.li),
    .ri(i_intf.ri)
  );
  
  // Declare the environment handle
  environment env;
  
  initial begin
    // Create the environment
    env = new(i_intf);
    
    // Run the test
    env.run();
    
    // Add some delay and finish
    #1000;
    $finish;
  end
  
  // Generate VCD file
  initial begin
    $dumpfile("headlight.vcd");
    $dumpvars(0, tb_top);
  end
  
endmodule
