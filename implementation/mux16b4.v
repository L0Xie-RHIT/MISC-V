module mux16b2(
    input[15:0] a,
    input[15:0] b,
    input[15:0] c,
    input[15:0] d,
    input[1:0] s,
    output[15:0] r
);

if(s[1] == 0) begin
    if (s[0] == 0) begin
        assign s = a;
    end else begin
        assign s = b;
    end
end else begin
    if (s[0] == 0) begin
        assign s = c;
    end else begin
        assign s = d;
    end
end

endmodule