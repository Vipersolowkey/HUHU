/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_asiclab_example (
    input  wire  [7:0] ui_in,     // Dedicated inputs
    output reg   [7:0] uo_out,    // Dedicated outputs
    input  wire  [7:0] uio_in,    // IOs: Input path
    output wire  [7:0] uio_out,   // IOs: Output path
    output wire  [7:0] uio_oe,    // IOs: Enable path (active high: 0=input, 1=output)
    input  wire        ena,       // Always 1 when the design is powered
    input  wire        clk,       // Clock
    input  wire        rst_n      // Active-low reset
);

    wire reset = ~rst_n;

    // Disable IOs (tri-state)
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            uo_out <= 8'b0;
        end else begin
            uo_out[3:0] <= ui_in[7:4] + ui_in[3:0];
            uo_out[7:4] <= 4'b0;
        end
    end

    // Unused signals grouped to avoid warnings
    wire _unused;
    assign _unused = &{ena, uio_in, clk};

endmodule
