function [output_data] = Level_0_Client_OPC(input)
persistent init_server;
persistent init_nodes;
persistent uaClient;
persistent var_node_in;
persistent alert alert_t alert_h alert_wd;
persistent fdct_r fdct_l fdch_up fdch_down emergency_button;
persistent wd_in wd_reset manual_reset;

Alert_t = 0;
Alert_wd = 0;
Alert_h = 0;
Alert = 0;

if (isempty(init_server))
    init_server = 0;
    init_nodes = 0;
end
if init_server == 0
    init_server = 1;
    uaClient = opcua('localhost',4840);
    connect(uaClient,'AUTOMATAS_PLC', 'mariano99');
    %connect(uaClient,'facundo', 'facundo');
end

if uaClient.isConnected == 1 && init_nodes == 0
    init_nodes = 1;
    % OPC nodes
    var_node_in = findNodeByName(uaClient.Namespace,'GLOBALS','-once');
    % Inputs
    fdct_r = findNodeByName(var_node_in,'fdct_r','-once');
    fdct_l = findNodeByName(var_node_in,'fdct_l','-once');
    fdch_up = findNodeByName(var_node_in,'fdch_up','-once');
    fdch_down = findNodeByName(var_node_in,'fdch_down','-once');
    emergency_button = findNodeByName(var_node_in,'emergency_button','-once');
    manual_reset = findNodeByName(var_node_in,'manual_reset','-once');
    wd_in = findNodeByName(var_node_in,'wd_in','-once');
    wd_reset = findNodeByName(var_node_in,'wd_reset','-once');
    % Outputs
    alert_t = findNodeByName(var_node_in,'alert_t','-once');
    alert_h = findNodeByName(var_node_in,'alert_h','-once');
    alert = findNodeByName(var_node_in,'alert','-once');
    alert_wd = findNodeByName(var_node_in,'alert_wd','-once');
end

if uaClient.isConnected == 1 && init_nodes == 1
    % Read values from OPC server (CODESYS)
    [Alert_t,~,~]= readValue(uaClient,alert_t);
    [Alert_h,~,~]= readValue(uaClient,alert_h);
    [Alert_wd,~,~]= readValue(uaClient,alert_wd);
    [Alert,~,~]= readValue(uaClient,alert);
    % Write values to OPC server (CODESYS)
    %{
    writeValue(uaClient,fdct_r,input(1));
    writeValue(uaClient,fdct_l,input(2));
    writeValue(uaClient,fdch_up,input(3));
    writeValue(uaClient,fdch_down,input(4));
    writeValue(uaClient,emergency_button,input(5));
    writeValue(uaClient,wd_in,input(6));
    writeValue(uaClient,wd_reset,input(7));
    writeValue(uaClient,manual_reset,input(8));
    %}
end

output_data = double([Alert_t,Alert_h,Alert,Alert_wd]);

end


