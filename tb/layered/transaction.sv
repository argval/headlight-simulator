class transaction;
  
  bit clk;  // Clock should not be randomized
  rand bit rst;
  rand bit lt;
  rand bit rt;
  rand bit haz;
  
  logic [2:0] li;
  logic [2:0] ri;
  
  static int count;
  int pkt_id;
  
  // Constraint to prevent both left and right indicators being active when hazard is off
  constraint valid_signals {
    haz == 0 -> !(lt && rt);
  }
  
  function new();
    clk = 0;
  endfunction
  
  function transaction copy();
    transaction tr;
    tr = new();
    tr.clk = this.clk;
    tr.rst = this.rst;
    tr.lt = this.lt;
    tr.rt = this.rt;
    tr.haz = this.haz;
    tr.li = this.li;
    tr.ri = this.ri;
    tr.pkt_id = this.pkt_id;
    return tr;
  endfunction
  
  function void post_randomize();
    count++;
    pkt_id = count;
  endfunction
  
endclass
