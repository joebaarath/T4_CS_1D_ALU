# ALU-1D

## FPGA Display
### Input
|Input|No. of bits|FPGA input|
|------------------|:------------------:|------------------|
|ALUFN|6|`io_dip[2][5:0]`|
|a/b|16|`io_dip[1:0]`|

### Output
|Output|No. of bits|FPGA output|
|------------------|:------------------:|------------------|
|z|1|`io_led[2][0]`|
|v|1|`io_led[2][1]`|
|n|1|`io_led[2][2]`|
|out|16|`io_led[1:0]`|

## Flow of our FPGA
Initialise -> Manual Mode (by default)

Manual:
`io_sel[0]` shows the current state.
||Step|`io_sel[0]`|
|------------------|------------------|------------------|
|1|Use `io_dip[2][5:0]` to adjust ALUFN signal|before getting final output|
|2|Use `io_dip[1:0]` to key in **a** (16-bit)|`A`|
|3|Press `io_button[2]` (down) to save input a|`A` -> `b`|
|4|Use `io_dip[1:0]` to key in **b** (16-bit)|`b`|
|5|Press `io_button[2]` (down) to save input b|`b` -> `0`|
|6|The output will be displayed on io_led|`0`|
|7|Press `io_button[2]` (down) again to restart Manual Cycle|`0`->`A`|

To switch to Auto Mode, press `io_button[0]` (up).

Auto:
`io_sel` shows the current state. (default: `0000`)
|`io_sel[3]`|`io_sel[2]`|`io_sel[1]`|`io_sel[0]`|
|------------------|------------------|------------------|------------------|
|`0`|`0`|Module number|`0`: testing, `7`: fail, `8`:pass|

Test module numbers: 1-Adder, 2-Compare, 3-Bool, 4-Shift, 5-Multiplier, 6-Modulo.

Use `io_button[3]` (left) and `io_button[4]` (right) to toggle between the different tests for each component

To return to Manual Mode, press `io_button[0]` (up).


## ALUFN signal
|Function|ALUFN[5:0]|
|:------------------:|------------------|
|Addition| 0 0 0 0 0 0 |
|Subtraction| 0 0 0 0 0 1 |
|Multiply| 0 0 0 0 1 0 |
|A| 0 0 1 0 1 0 |
|B| 0 0 1 1 0 0 |
|NOT A| 0 0 0 1 0 1 |
|NOT B| 0 0 0 0 1 1 |
|AND| 0 0 1 0 0 0 |
|OR| 0 0 1 1 1 0 |
|XOR| 0 0 0 1 1 0 |
|NOR| 0 0 0 0 0 1 |
|XNOR| 0 0 1 0 0 1 |
|NAND| 0 0 0 1 1 1 |
|SHL| 1 0 0 0 0 0 |
|SHR| 1 0 0 0 0 1 |
|SRA| 1 0 0 0 1 0 |
|=| 1 1 0 0 1 1 |
|<| 1 1 0 1 0 1 |
|<=| 1 1 0 1 1 1 |
|Modulo| 0 0 0 1 0 0 |

## Test Cases 
### Addition
|No.|Test case|a|b|out|zvn|
|------------------|:------------------:|------------------|------------------|------------------|------------------|
|1|0+0|16h0000|16h0000| 16h0000 = 0 = 00000000 00000000 | 100 |
|2|10+10|16h000A|16h000A| 16h0014 = 20 = 00000000 01100100 | 000 |
|3|10+(-10)|16h000A|16hFFF6| 16h0000 = 0 = 00000000 00000000 | 100 |
|4|(-10)+(-12)|16hFFF6|16hFFF4| 16hFFE8 = -24 = 11111111 10001110 | 001 |
|5|(-32767)+(-32767)|16h8001|16h8001| 16h02 = -65534 = 00000000 00000010 | 010 |
|6|32767+32767|16h7FFF|16h7FFF| 16hFFFE = 65534 = 11111111 11111110 | 011 |

### Subtraction
|No.|Test case|a|b|out|zvn|
|------------------|:------------------:|------------------|------------------|------------------|------------------|
|1|0-0|16h0000|16h0000| 16h0000 = 0 = 00000000 00000000 | 100 |
|2|10-(-10)|16h000A|16hFFF6| 16h0064 = 100 = 00000000 01100100 | 000 |
|3|10-10|16h000A|16h000A| 16h0000 = 0 = 00000000 00000000 | 100 |
|4|(-10)-(12)|16hFFF6|16hFFF4| 16hFFE8 = -24 = 11111111 10001110 | 001|
|5|(-32767)-32767|16h8001|16h7FFF| 16h02 = -65534 = 00000000 00000010 | 010|
|6|32767-(-32767)|16h7FFF|16h8001| 16hFFFE = 65534 = 11111111 11111110 | 011 | 

### Multiply
|No.|Test case|a|b|out|
|------------------|:------------------:|------------------|------------------|------------------|
|1|0*0|16h0000|16h0000|16h0000 = 0 = 00000000 00000000|
|2|1*1|16h0001|16h0001|16h0001 = 1 = 00000000 00000001|
|3|(-1)*(-1)|16hFFFF|16hFFFF|16h0001 = 1 = 00000000 00000001|
|4|0*2|16h0000|16h0002|16h0000 = 0 = 00000000 00000000|
|5|1*13107|16h0001|16h3333|16h3333 = 13107 = 00110011 00110011|
|6|(-1)*13107|16hFFFF|16h3333|16hCCCD = -13107 = 11001100 11001101|
|7|0*(-3191)|16h0000|16hF389|16h0000 = 0 = 00000000 00000000|
|8|1*(-3191)|16h0001|16hF389|16hF389 = -3191 = 11110011 10001001|
|9|(-1)*(-3191)|16hFFFF|16hF389|16h0C77 = 3191 = 00001100 01110111|
|10|2*5|16h0002|16h0005|16h000A = 10 = 00000000 00001010|

### Boolean
|No.|Test case|a|b|out|
|------------------|:------------------:|------------------|------------------|------------------|
|1|AND|4b111100|4b101000|16b101000|
|2|OR|4b111100|4b101000|16b111100|
|3|XOR|4b111100|4b101000|16b010100|
|4|A|4b111100|4b101000|16b111100|
|5|B|4b111100|4b101000|16b101000|
|6|~A|16b111100|16b101000|16hFFC3|
|7|~B|16b111100|16b101000|16hFFD7|
|8|NOR|4b111100|4b101000|16hFFC3|
|9|XNOR|4b111100|4b101000|16hFFEB|
|10|NAND|16111100|16b101000|16hFFD7|

### Shifter
|No.|Test case|a|b|out|
|------------------|------------------|------------------|------------------|------------------|
|1|SHL(0)|16hFFFF|4b0000|16hFFFF|
|2|SHL(4)|16hFFFF|4b0100|16hFFF0|
|3|SHL(15)|16hF00F|4b1111|16h8000|
|4|SHR(0)|16hFFFF|4b0000|16hFFFF|
|5|SHR(8)|16hFFFF|4b1000|16h00FF|
|6|SHR(15)|16hFF0F|4b1111|16h0001|
|7|SRA(0)|16hFFFF|4b0000|16hFFFF|
|8|SRA(4)|16hFFFF|4b0100|16hFFFF|
|9|SRA(8)|16hF00F|4b1000|16hFFF0|
|10|SRA(15)|16hF00F|4b1111|16hFFFF|
|11|SRA(4)|16h2468|4b0100|16h0246|

### Compare
|No.|Test case|a|b|out|
|------------------|:------------------:|------------------|------------------|------------------|
|1|=|16h0000|16h0000|16h0001|
|2|=|16h0005|16h000B|16h0000|
|3|=|16hFFFF|16h0002|16h0000|
|4|<|16h0000|16h0000|16h0000|
|5|<|16h0005|16h000B|16h0001|
|6|<|16h7000|16h6FFF|16h0001|
|7|<=|16h0000|16h0000|16h0001|
|8|<=|16h0005|16h000B|16h0001|
|9|<=|16FFFD|16hFFFF|16h0001|


### Modulo (positive a/b)
|No.|Test case|a|b|out|
|------------------|:------------------:|------------------|------------------|------------------|
|1|10 % 2|16h000A|16h0002| 16h0000 = 0 = 00000000 00000000 |
|2|10 % 15|16h000A|16h000F| 16h000A = 10 = 00000000 00001010 |
