
module Branch_Predictor (
    input wire clk,
    input wire reset,
    input wire [31:0] pc,
    input reg actual,
    output reg predict
);

// Define the history table
reg [31:0] history_table;

// Define the index into the history table
reg [6:0] index;

// Define the prediction
reg prediction;

// On reset, initialize the history table to all taken
initial begin
    history_table = 1024'hfffff;
end

if (reset) begin
    history_table = 1024'hfffff;
end

// On each clock cycle, update the prediction based on the history table
always @(posedge clk) begin
    // Calculate the index into the history table
    index = pc[6:0];

    // Get the current prediction from the history table
    prediction = history_table[index];

    // Update the history table based on the actual outcome of the branch
    if (actual) begin
        history_table[index] <= history_table[index] << 1 | 1;
    end else begin
        history_table[index] <= history_table[index] << 1;
    end
end

// Output the prediction
assign predict = prediction;

endmodule
