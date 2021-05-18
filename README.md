# verilog_spi_M25AA010A

在EEPROM的位 址0寫入0x78，位址1寫入0x9A ，位址2寫入0xBC


| MODULE        | DESCRIPTION                                        |
| ------------- | -------------------------------------------------- |
| edge_detect_neg.v | gives one-tick pulses on every signal falling edge |
| edge_detect_pos.v    | gives one-tick pulses on every signal rising edge                                          |
| M25AA010A.v       | SPI slave EEPROM model                                               |
| spi_tb.v | testbench

## M25AA010A

### Functional Description
![](https://i.imgur.com/UYPKWP6.png)

### WREN Timing
![](https://i.imgur.com/yOsdfNC.png)

###  WRITE Timing 
![](https://i.imgur.com/Oe1PqSZ.png)
