class driver;
  
  virtual intf.DRIVER vif;
  mailbox #(transaction) gen2driv;
  
  function new(virtual intf.DRIVER vif, mailbox #(transaction) gen2driv);
    this.vif = vif;
    this.gen2driv = gen2driv;
  endfunction
  
  task reset();
    vif.rst = 1'b1;
    vif.lt = 1'b0;
    vif.rt = 1'b0;
    vif.haz = 1'b0;
    repeat(2) @(posedge vif.clk);
    vif.rst = 1'b0;
  endtask
  
  task main();
    transaction trans;
    
    // Initial reset
    reset();
    
    forever begin
      gen2driv.get(trans);
      
      @(posedge vif.clk);
      // Drive the signals
      vif.rst = trans.rst;
      vif.lt = trans.lt;
      vif.rt = trans.rt;
      vif.haz = trans.haz;
      
      // Sample the outputs
      @(posedge vif.clk);
      trans.li = vif.li;
      trans.ri = vif.ri;
    end
  endtask
  
endclass