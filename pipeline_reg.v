module pipeline_reg #
(
    parameter DATA_WIDTH = 32
)
(
    input  wire                  clk,
    input  wire                  rst,
    input  wire                  in_valid,
    output wire                  in_ready,
    input  wire [DATA_WIDTH-1:0] in_data,
    output wire                  out_valid,
    input  wire                  out_ready,
    output wire [DATA_WIDTH-1:0] out_data
);
    reg [DATA_WIDTH-1:0] data_r;
    reg                  valid_r;
    assign in_ready = !valid_r || out_ready;
    assign out_valid = valid_r || in_valid;
    assign out_data  = valid_r ? data_r : in_data;

    always @(posedge clk) begin
        if (rst) begin
            valid_r <= 1'b0;
            data_r  <= {DATA_WIDTH{1'b0}};
        end
        else begin
            // Case 1: buffer empty, downstream stalled -store incoming data
            if (in_valid && in_ready && !out_ready) begin
                data_r  <= in_data;
                valid_r <= 1'b1;
            end
            // Case 2: downstream consumes buffered data
            else if (out_ready) begin
                valid_r <= 1'b0;
            end
        end
    end

endmodule
