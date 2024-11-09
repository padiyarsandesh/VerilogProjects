# VerilogProjects

<h2>1. Asynchronous FIFO </h2> 
Designed an asynchronous FIFO of depth 2^n and relevent pointer synchronizing circuits in Verilog and verified its functionality. <br>

<b>References</b> <br>
  The design is greatly inspired from : http://www.sunburst-design.com/papers/CummingsSNUG2002SJ_FIFO1.pdf <br>
  I found this blog also very helpful:  https://zipcpu.com/blog/2018/07/06/afifo.html

<h2>2. SPI Master </h2> 
Implemented SPI master which supports all 4 modes of SPI and verified functionality using Verilog.
  
 <b>References</b> <br>
   Motorola SPI Specs  : http://www.ee.nmt.edu/~rison/datasheets/ee308/S12SPIV2.pdf
  
<h2>3. BIST Design </h2> 
Designed and implemented in Verilog to add Built in Self Test (BIST) capabilities to a given combinational logic. The Test Pattern Generator (TPG), Output Response Analyzer (ORA) and BIST controller were designed. A 1-bit full adder was considered as the circuit under test (CUT) with faults injected at various nets to verify the functionality.<br>
