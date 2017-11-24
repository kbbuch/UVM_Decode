#! /usr/bin/env python

import uvmf_gen
env = uvmf_gen.EnvironmentClass('decode')

## Specify parameters for this interface package.
## These parameters can be used when defining signal and variable sizes.
# addParamDef(<name>,<type>,<value>)

# addRegisterModel(   sequencer,                    transactionType,   adapterType,       busMap,  useAdapter=True, useExplicitPrediction=True)
## env.addRegisterModel('control_plane_in.sequencer', 'mem_transaction', 'mem2reg_adapter', 'bus_map',useAdapter=True,useExplicitPrediction=True)

## Specify the agents contained in this environment
##   addAgent(<agent_handle_name>,<agent_package_name>,<clock_name>,<reset_name>,<{interfaceParameter1:value1,interfaceParameter2:value2}>, initResp = 'RESPONDER')
# Note: the agent_package_name will have _pkg appended to it.

env.addAgent('agent_in',      'decode_in',       'clock', 'reset', initResp = 'INITIATOR' )
env.addAgent('agent_out',     'decode_out',       'clock', 'reset')




##env.addAgent('secure_data_plane_in',  'pkt',       'clock',  'reset')
##env.addAgent('secure_data_plane_out', 'pkt',       'clock',  'reset')

## Define the predictors contained in this environment (not instantiate, yet)
## addAnalysisComponent(<keyword>,<predictor_type_name>,<dict_of_exports>,<dict_of_ports>) - 
## If the transaction types are parameterized and the default parameter values are desired then
## the #() is required as part of defining the transaction type used by the analysis component.
## doing this will add the requested analysis component to the list, enabling the use of the 
## given template (identified by <keyword>)
env.defineAnalysisComponent('predictor','decode_predictor',{'analysis_export':'decode_in_transaction'},
                                                           {'decode_predictor_ap':'decode_out_transaction'})

														   
## Instantiate the components in this environment
## addAnalysisComponent(<name>,<type>)
env.addAnalysisComponent('de_pred','decode_predictor')




## Specify the scoreboards contained in this environment
## addUvmfScoreboard(<scoreboard_handle_name>, <uvmf_scoreboard_type_name>, <transaction_type_name>)
env.addUvmfScoreboard('de_sb','uvmf_in_order_race_scoreboard','decode_out_transaction')





##env.addUvmfScoreboard('secure_data_plane_sb', 'uvmf_in_order_race_scoreboard','pkt_transaction')

## Specify environment-level analysis ports and exports
##env.addAnalysisPort('control_plane_in_ap','mem_transaction','control_plane_in.monitored_ap')
##env.addAnalysisPort('control_plane_out_ap','mem_transaction','control_plane_out.monitored_ap')
##env.addAnalysisExport('external_pkt_ep','pkt_transaction','block_a_pred.secure_data_plane_in_ae')




## Specify the connections in the environment
## addConnection(<output_component>, < output_port_name>, <input_component>, <input_component_export_name>)
## Connection 00
env.addConnection('agent_in', 'monitored_ap', 'de_pred', 'analysis_export')
## Connection 01
env.addConnection('de_pred', 'decode_predictor_ap', 'de_sb', 'expected_analysis_export')
## Connection 02
env.addConnection('agent_out', 'monitored_ap', 'de_sb', 'actual_analysis_export')



## Connection 03
##env.addConnection('block_a_pred', 'secure_data_plane_sb_ap', 'secure_data_plane_sb', 'expected_analysis_export')
## Connection 04
##env.addConnection('control_plane_out', 'monitored_ap', 'control_plane_sb', 'actual_analysis_export')
## Connection 05
##env.addConnection('secure_data_plane_out','monitored_ap',  'secure_data_plane_sb', 'actual_analysis_export')

## Specify configuration variables for the environment.
##   addConfigVar(<name>,<type>)
##     optionally can specify if this variable may be specified as 'rand'
##env.addConfigVar('block_a_cfgVar1','bit',isrand=False)
##env.addConfigVar('block_a_cfgVar3','bit [3:0]',isrand=True)
##env.addConfigVar('block_a_cfgVar4','int',isrand=True)
##env.addConfigVar('block_a_cfgVar5','int',isrand=True)

## Specify configuration variable constraint
## addConfigVarConstraint(<constraint_body_name>,<constraint_body_definition>)
##env.addConfigVarConstraint('element_range_c','{ block_a_cfgVar4>block_a_cfgVar5; }')
##env.addConfigVarConstraint('non_negative_c','{ (block_a_cfgVar1==0) -> block_a_cfgVar4==0;}')

env.create() 
