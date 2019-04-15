##this script tests the functionality of a single AES-128 bit block. The power trace for encrypting a plain text is saved in a csv file 

#FPGA
import d2xx
import time
from binascii import unhexlify
from binascii import hexlify
#Oscilloscope
import visa
import numpy
from struct import unpack
import csv

##rm=visa.ResourceManager()
##rm.list_resources()
##ins=rm.open_resource('USB0::0x0699::0x0408::C018437::INSTR')
##
##
##ins.write('DATA:SOU CH1')
##ins.write('DATA:WIDTH 1')
##ins.write('DATA:ENC RPB')
##ins.write('DATA:STOP 10000')
##
##ymult=float(ins.query('WFMPRE:YMULT?'))
##yzero=float(ins.query('WFMPRE:YZERO?'))
##yoff=float(ins.query('WFMPRE:YOFF?'))
##xincr=float(ins.query('WFMPRE:XINCR?'))
##ins.write("ACQ:STATE ON")
####ins.write("ACQ:STOPA SEQ")

d=d2xx.listDevices()
h=d2xx.open(0)
h.setBitMode(0xff,0x40)
h.setUSBParameters(0x32000,0x320000)
h.setLatencyTimer(3)
h.purge()
wr_cmd='01'
rd_cmd='00'
rd_data=[]
##rd_val=None
key_raw='00000000000000000000000000000000'
data_raw='0000000000000000000000000fffffff'
key=key_raw[-1::-1]
data=data_raw[-1::-1]


for i in range(0,8):
    a=hex(i)
    datastring=wr_cmd+'222'+a[2]+data[i*4:(i*4+4)]
    dstr=unhexlify(datastring)
    h.write(dstr)
    #print dstr
    #time.sleep(.05)
    
for i in range(0,8):
    a=hex(i)
    keystring=wr_cmd+'333'+a[2]+key[i*4:(i*4+4)]
    kstr=unhexlify(keystring)
    h.write(kstr)
    #print kstr
    #time.sleep(.05)
#time.sleep(.05)
##ins.write("ACQ:STATE ON")
##ins.write("ACQ:STOPA SEQ")
trig=unhexlify(wr_cmd+'1234'+'0003')
h.write(trig)
#print trig
#time.sleep(1)


j=0
while j<1:
    for i in range (0,8):
        a=hex(i)
        rd_string=rd_cmd+'555'+a[2]
    ##    print rd_string
        rstr=unhexlify(rd_string)
        h.write(rstr)
##        rdval=hexlify(h.read(h.getQueueStatus()))
##        print rdval
    ##    if i==3:
    ##        rdval=hexlify(h.read(h.getQueueStatus()))
    ##        rd_data.append(rdval)
    ##        time.sleep(.001)
    ##    if i==7:
    ##        rdval=hexlify(h.read(h.getQueueStatus()))
    ##        rd_data.append(rdval)
    ##        time.sleep(.001)
    ##    time.sleep(.001)
    ##    rdval=hexlify(h.read(h.getQueueStatus()))
    ##    rdval=hexlify(h.read(1))
    ##    print rdval
    ##    rd_data.append(rdval)
    ##    rdval=hexlify(h.read(1))
    ##    rd_data.append(rdval)
    print h.getQueueStatus()
    rdval=hexlify(h.read(h.getQueueStatus()))
    print rdval
    sz=32-len(rdval)
    print sz
    if sz>0:
        rdval=rdval+hexlify(h.read(h.getQueueStatus()))
        print rdval
    for i in range(16):
        rd_data.append(rdval[2*i]+rdval[2*i+1])
        

##    print h.getQueueStatus()
    j=j+1
##
rdval=hexlify(h.read(h.getQueueStatus()))
rd_data.append(rdval)
print rd_data
##ins.write('CURV?')
##data=ins.read_raw()
##headerlen=2+int(data[1])
##header=data[:headerlen]
##ADC_wave=data[headerlen:-1]
##
##ADC_wave=numpy.array(unpack('%sB' %len(ADC_wave), ADC_wave))
##
##Volts=(ADC_wave-yoff)*ymult+yzero
##TIme=numpy.linspace(0,xincr*len(Volts),num=len(Volts))
##a=numpy.asarray(Volts)
##numpy.savetxt('clk_temp.csv',a,delimiter=',')
h.close()
