function [output_data] = Level_2_Client_OPC_Hoisting(input)
persistent init_server;
persistent init_nodes;
persistent uaClient;
persistent var_node_in;
persistent dlh_ref dlh_in tmh;
Tmh=0;

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
    disp("1")
    init_nodes = 1;
    % OPC nodes
    var_node_in = findNodeByName(uaClient.Namespace,'GLOBALS','-once');
    % Inputs
    dlh_ref = findNodeByName(var_node_in,'dlh_ref','-once');
    dlh_in = findNodeByName(var_node_in,'dlh_in_pid','-once');
    % Outputs
    tmh = findNodeByName(var_node_in,'tmh','-once');
    disp(tmh);
end

if uaClient.isConnected == 1 && init_nodes == 1
    % Read values from OPC server (CODESYS)
    [Tmh,~,~]= readValue(uaClient,tmh);
    % Write values to OPC server (CODESYS)
    writeValue(uaClient,dlh_in,input(1));
    writeValue(uaClient,dlh_ref,input(2));
    disp(input(1));
end

output_data = double([Tmh,0]);

end