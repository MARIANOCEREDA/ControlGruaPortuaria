function [output_data] = Level_2_Client_OPC_Trolley(input)
persistent init_server;
persistent init_nodes;
persistent uaClient;
persistent var_node_in;
persistent dxt_ref dxt_in tmt


if (isempty(init_server))
    init_server = 0;
    init_nodes = 0;
end
if init_server == 0
    init_server = 1;
    uaClient = opcua('localhost',4840);
    %connect(uaClient,'AUTOMATAS_PLC', 'mariano99');
    connect(uaClient,'facundo', 'facundo');
end

if uaClient.isConnected == 1 && init_nodes == 0
    init_nodes = 1;
    % OPC nodes
    var_node_in = findNodeByName(uaClient.Namespace,'GLOBALS','-once');
    % Inputs
    dxt_ref = findNodeByName(var_node_in,'dxt_ref','-once');
    dxt_in = findNodeByName(var_node_in,'dxt_in_pid','-once');
    % Outputs
    tmt = findNodeByName(var_node_in,'tmt','-once');
end

if uaClient.isConnected == 1 && init_nodes == 1
    % Read values from OPC server (CODESYS)
    [Tmt,~,~]= readValue(uaClient,tmt);
    % Write values to OPC server (CODESYS)
    writeValue(uaClient,dxt_in,input(1));
    writeValue(uaClient,dxt_ref,input(2));
end

output_data = double(Tmt);

end