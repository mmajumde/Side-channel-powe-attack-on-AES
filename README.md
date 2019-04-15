# Side-channel-powe-attack-on-AES
The AES implementation was targeted for Xilinx Kintex-7 FPGA of SAKURA-x board.

Instructions for generating bitstream for AES:
  1. Use ISE or VIVADO (recommended) for bitstream generation
  2. Provide information for Kintex-7 fpga while creating the project
  3. Two version of AES_core is AES/source/design/AES_core.vhd and AES/source/design/AES_core_mitigation.vhd
  4. For successful attack demonstration use the AES/sources/design/AES_core.vhd file
  5. For incrasing attak complexity use AES/sources/design/AES_core_mitigation.vhd
  6. Use constraint file .ucf or .xdc based on tools used: ISE or VIVADO, respectively
  7. Generate bitsteam and load on the kintex-7 fpga on SAKURA-x board using the Xilinx platform cable
  
Instruction for Oscilloscope (Tektronics MD03000) setting:
  1. Channel 1 connects to power probe j19 of SAKURA-x board.
  2. Channel 2 connects to the trigger signal from CN8,1 probe of SAKURA-x board
  3. Chanel 3 connect to the clock signal from CN8,3 probe of SAKURA-x board
  4. Set offset of channel 1 to 1.05 V.
  5. Try tuning the amplitude controll knob of channel 1 to fit the power waveform withing the range. Typically ~2 mv.
  6. Try to tune the frequency control knob to fit the whole waveform withing the oscilloscope screen
  7. Set chhanel 2 as the trigger source
  8. Set negative edge as the trigger edge
  9. Set 1 V as the trigger level.
  
Instruction for communication between the AES and pc using python script.
All python script used here was developed in Python 2.6.6. Used packages are 
  i.   d2xx (pyusb-1.6)
  ii.  pyvisa-1.4
  iii. numpy
  
  1. Use the Python_scripts/AES_VHDL_test_only_fpga.py to test the functionlity of the AES
  2. Waveform for the clock signal is saved as clk_temp.csv.
  3. 11 power segments can be visible from the waveform. 1 for plaintext loading and 10 for 10 rounds of AES
  4. Record the index range for the last rounds which is used for attack.
  5. The line "power[i]=max(a[8927:9861])" of Python_scripts/CPA_test_AES_VHDL_fast.py is edited based on last round power trace index range.
  6. Number of observation is set in "measure" variable of the CPA_Test_AES_VHDL_fast.py script
  
