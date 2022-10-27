function output_data = Level_0_Client_OPC(input)
persistent init_server;
persistent init_nodes1;
persistent uaClient;
persistent var_node_in;
persistent var_node_out;
persistent alert alert_t alert_h alert_wd;
persistent dlh_in dxt_in fdct_r fdct_l fdch_up fdch_down emergency_button mass_flag;
persistent wd_in wd_reset manual_reset ml;


if (isempty(init_server))
    init_server = 0;
    init_nodes1 = 0; 
end
if init_server == 0
    init_server = 1;
    uaClient = opcua('localhost',4840);
    connect(uaClient,'AUTOMATAS_PLC', 'mariano99');
end

if uaClient.isConnected == 1 && init_nodes1 == 0
    init_nodes1 = 1;
    % OPC nodes
    var_node_in = findNodeByName(uaClient.Namespace,'INPUT','-once');
    var_node_out = findNodeByName(uaClient.Namespace,'OUTPUT','-once');
    % Inputs
    dxt_in = findNodeByName(var_node_in,'dxt_in','-once');
    dlh_in = findNodeByName(var_node_in,'dlh_in','-once');
    fdct_r = findNodeByName(var_node_in,'fdct_r','-once');
    fdct_l = findNodeByName(var_node_in,'fdct_l','-once');
    fdch_up = findNodeByName(var_node_in,'fdch_up','-once');
    fdch_down = findNodeByName(var_node_in,'fdch_down','-once');
    emergency_button = findNodeByName(var_node_in,'emergency_button','-once');
    manual_reset = findNodeByName(var_node_in,'manual_reset','-once');
    mass_flag = findNodeByName(var_node_in,'mass_flag','-once');
    ml = findNodeByName(var_node_in,'ml','-once');
    wd_in = findNodeByName(var_node_in,'wd_in','-once');
    wd_reset = findNodeByName(var_node_in,'wd_reset','-once');
    % Outputs
    alert_t = findNodeByName(var_node_out,'alert_t','-once');
    alert_h = findNodeByName(var_node_out,'alert_h','-once');
    alert = findNodeByName(var_node_out,'alert','-once');
    alert_wd = findeNodeByName(var_node_out,'alert_wd','-once');
end

if uaClient.isConnected == 1 && init_nodes1 == 1
    % Read values from OPC server (CODESYS)
    [alert_t,~,~] = readValue(uaClient,alert_t);
    [alert_h,~,~]=readValue(uaClient,alert_h);
    [alert_wd,~,~]=readValue(uaClient,alert_wd);
    [alert,~,~]=readValue(uaClient,alert);
    % Write values to OPC server (CODESYS)
    writeValue(dlh_in,input(1));
    writeValue(dxt_in,input(2));
    writeValue(fdct_r,input(3));
    writeValue(fdct_l,input(4));
    writeValue(fdch_up,input(5));
    writeValue(fdch_down,input(6));
    writeValue(emergency_button,input(7));
    writeValue(mass_flag,input(8));
    writeValue(wd_in,input(9));
    writeValue(wd_reset,input(10));
    writeValue(manual_reset,input(11));
    writeValue(ml,input(12));
end

output_data = [alert_t,alert_h,alert,alert_wd];

end