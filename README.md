# single-stage-pipeline-register-using-a-valid-ready-handshake
A clean, synthesizable "single-stage pipeline register" implementing a standard "valid/ready handshake"
This module safely buffers one data word between an upstream and downstream
interface, correctly handling backpressure **without data loss or duplication**.

---

## ✨ Features

- One-deep pipeline / skid buffer
- Standard valid/ready handshake
- Fully synthesizable (FPGA/ASIC safe)
- Clean reset to empty state
- Written in both **Verilog** and **SystemVerilog**
- Suitable for AXI-Stream, DSP pipelines, radar signal chains

---

## 📐 Handshake Rules

Data transfer occurs **only when**:

valid && ready == 1


- `in_valid`  : input data is valid
- `in_ready`  : pipeline can accept data
- `out_valid` : pipeline holds valid data
- `out_ready` : downstream can accept data

---

## 📦 Module Behavior

- Holds **exactly one data word**
- Accepts new data when empty or when downstream consumes data
- Automatically stalls upstream on backpressure
- Never drops or duplicates data

---

## 🧠 Core Logic

in_ready = !out_valid || out_ready


This ensures correct flow control under all conditions.

---

## 📂 RTL Files

| File | Description |
|----|----|
| `rtl/pipeline_reg.v` | Verilog implementation |
| `rtl/pipeline_reg.sv` | SystemVerilog implementation |

---

## 🧪 Simulation

A simple SystemVerilog testbench is provided in `sim/` to validate:
- normal transfers
- backpressure
- reset behavior

---

## 🛠 Use Cases

- AXI-Stream register slice
- DSP / radar pipelines
- FIFO front-end buffer
- Clocked dataflow systems
