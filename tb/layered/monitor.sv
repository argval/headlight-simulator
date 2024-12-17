class monitor;
  virtual intf vif;
  mailbox mon2scb;
  
  function new(virtual intf vif, mailbox mon2scb);
    this.vif = vif;
    this.mon2scb = mon2scb;
  endfunction
  
  task main;
    repeat(1)
      #3;
    begin
      transaction trans;
      trans = new();
      @(vif.monitor_cb);
      trans.clk = vif.clk;
      trans.rst = vif.rst;
      trans.lt = vif.lt;
      trans.rt = vif.rt;
      trans.haz = vif.haz;
      trans.li = vif.li;
      trans.ri = vif.ri;
      mon2scb.put(trans);
      //trans.display("Monitor");
    end
  endtask
endclass