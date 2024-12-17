class generator;
  
  transaction trans;
  mailbox #(transaction) gen2driv;
  int num_transactions;
  
  function new(mailbox #(transaction) gen2driv, int num_transactions = 10);
    this.gen2driv = gen2driv;
    this.num_transactions = num_transactions;
    trans = new();
  endfunction
  
  task main();
    repeat(num_transactions) begin
      if (!trans.randomize()) begin
        $display("Randomization failed");
        break;
      end
      
      gen2driv.put(trans);
      #10;
    end
  endtask
  
endclass