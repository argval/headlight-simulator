class scoreboard;
  
  mailbox mon2scb;
  
  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
  endfunction
  
  task main;
    transaction trans;
    repeat(1)
      begin
        mon2scb.get(trans);
        
        
        /*if(trans.lt == trans.rt == 1)
          $display("No result expected");
        else
          $display("Result is expected");*/
        
        //trans.display("Scoreboard");
      end
  endtask
endclass
