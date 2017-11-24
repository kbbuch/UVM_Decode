#! /usr/bin/env python

import uvmf_gen

## The input to this call is the name of the desired interface
intf = uvmf_gen.InterfaceClass('decode_in')

## Specify parameters for this interface package.
## These parameters can be used when defining signal and variable sizes.
# addHdlParamDef(<name>,<type>,<value>)

## Specify the clock and reset signal for the interface
intf.clock = 'clock'
intf.reset = 'reset'
intf.resetAssertionLevel = True

## Specify the ports associated with this interface.
## The direction is from the perspective of the test bench as an INITIATOR on the bus.
##   addPort(<name>,<width>,[input|output|inout])
intf.addPort('enable_decode',1,'output')
intf.addPort('dout',16,'output')
intf.addPort('npc_in',16,'output')

## Specify typedef for inclusion in typedefs_hdl file
# addHdlTypedef(<name>,<type>)
intf.addHdlTypedef('op_t','enum bit [3:0] { ADD=4\'b0001 , AND=4\'b0101 , NOT=4\'b1001 ,  LD=4\'b0010 , LDR=4\'b0110 , LDI=4\'b1010 , LEA=4\'b1110 ,  ST=4\'b0011 , STR=4\'b0111 , STI=4\'b1011 , BR=4\'0000, JMP=4\'1100}')
intf.addHdlTypedef('reg_t','enum bit [2:0] { R0=3\'b000 , R1=3\'b001 , R2=3\'b010 , R3=3\'b011 , R4=3\'b100 , R5=3\'b101 , R6=3\'b110 , R7=3\'b111 }')
intf.addHdlTypedef('imm5_t','bit [4:0]')
intf.addHdlTypedef('','bit [4:0]')
intf.addHdlTypedef('immediate_t','bit')
intf.addHdlTypedef('offset6_t','bit [5:0]')
intf.addHdlTypedef('pcoffset9_t','bit [8:0]')
intf.addHdlTypedef('baser_t','bit [2:0]')
intf.addHdlTypedef('instruction_t','bit [15:0]')


## Specify typedef for inclusion in typedefs file
# addHvlTypedef(<name>,<type>)

## Specify transaction variables for the interface.
##   addTransVar(<name>,<type>)
##     optionally can specify if this variable may be specified as 'rand'
##     optionally can specify if this variable may be specified as used in do_compare()
#intf.addTransVar('immediate','immediate_t',isrand=True,iscompare=False)
#intf.addTransVar('op','op_t',isrand=True,iscompare=True)
#intf.addTransVar('sr1','reg_t',isrand=True,iscompare=True)
#intf.addTransVar('sr2','reg_t',isrand=True,iscompare=True)
#intf.addTransVar('dr','reg_t',isrand=True,iscompare=True)
#intf.addTransVar('baser','baser_t',isrand=True,iscompare=True)
#intf.addTransVar('imm5','imm5_t',isrand=True,iscompare=True)
#intf.addTransVar('offset6','offset6_t',isrand=True,iscompare=True)
#intf.addTransVar('pcoffset9','pcoffset9_t',isrand=True,iscompare=True)
intf.addTransVar('dout','bit [15:0]',isrand=False,iscompare=True)
intf.addTransVar('enable_decode','bit',isrand=False,iscompare=True)
intf.addTransVar('npc_in','bit [15:0]',isrand=True,iscompare=True)

## Specify transaction variable constraint
## addTransVarConstraint(<constraint_body_name>,<constraint_body_definition>)
# intf.addTransVarConstraint('valid_address_range_c','{ address inside {[2048:1055], [1024:555], [511:0]}; }')

## Specify configuration variables for the interface.
##   addConfigVar(<name>,<type>)
##     optionally can specify if this variable may be specified as 'rand'

## Specify configuration variable constraint
## addConfigVarConstraint(<constraint_body_name>,<constraint_body_definition>)

## This will prompt the creation of all interface files in their specified
##  locations
intf.inFactReady = False
intf.create()