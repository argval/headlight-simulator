module tailLight(clk, rst, lt, rt, haz, li, ri);

  input clk, rst, lt, rt, haz;
  reg [2:0] ps, ns;
  parameter s0 = 3'd0, s1 = 3'd1, s2 = 3'd2, s3 = 3'd3, s4 = 3'd4, s5 = 3'd5;
  output reg [2:0] li;
  output reg [2:0] ri;

  // Sequential logic for state transitions
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      ps <= s0;
    end else begin
      ps <= ns;
    end
  end

  // Combinational logic for next state and outputs
  always @(*) begin
    // Default assignments
    ns = s0;
    {li, ri} = 6'b000000;

    if (haz) begin
      case (ps)
        s0: begin
          {li, ri} = 6'b000000;
          ns = s1;
        end
        s1: begin
          {li, ri} = 6'b100001;
          ns = s2;
        end
        s2: begin
          {li, ri} = 6'b110011;
          ns = s3;
        end
        s3: begin
          {li, ri} = 6'b111111;
          ns = s4;
        end
        s4: begin
          {li, ri} = 6'b110011;
          ns = s5;
        end
        s5: begin
          {li, ri} = 6'b100001;
          ns = s0;
        end
        default: begin
          {li, ri} = 6'b000000;
          ns = s0;
        end
      endcase
    end else if (lt || rt) begin
      case (ps)
        s0: begin
          if (lt) {li, ri} = 6'b100000;
          if (rt) {li, ri} = 6'b000001;
          ns = s1;
        end
        s1: begin
          if (lt) {li, ri} = 6'b110000;
          if (rt) {li, ri} = 6'b000011;
          ns = s2;
        end
        s2: begin
          if (lt) {li, ri} = 6'b111000;
          if (rt) {li, ri} = 6'b000111;
          ns = s3;
        end
        s3: begin
          if (lt) {li, ri} = 6'b111000;
          if (rt) {li, ri} = 6'b000111;
          ns = s0;
        end
        default: begin
          {li, ri} = 6'b000000;
          ns = s0;
        end
      endcase
    end
  end
endmodule