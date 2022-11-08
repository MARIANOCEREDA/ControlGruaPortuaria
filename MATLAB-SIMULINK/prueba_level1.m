function output_data= prueba_level1(flag)
persistent init_server;
persistent init_nodes;
persistent uaClient;
persistent var_node_in;
persistent var_node_out;
persistent dxt
persistent flagg;
if (isempty(init_server))
    init_server = 0;
    init_nodes = 0;
end
disp(flag);
disp(init_nodes)
if init_server == 0
    init_server = 1;
    uaClient = opcua('localhost',4840);
    connect(uaClient,'facundo', 'facundo');
end

if uaClient.isConnected == 1 && init_nodes == 0
    init_nodes = 1;
    % OPC nodes
    var_node_in = findNodeByName(uaClient.Namespace,'GVL');
    var_node_out = findNodeByName(uaClient.Namespace,'GVL','-once');
    % Inputs
    flagg = findNodeByName(var_node_in,'flag','-once');
    % Outputs
    dxt = findNodeByName(var_node_out,'dxt','-once');
end
if uaClient.isConnected == 1 && init_nodes == 1
    % Read values from OPC server (CODESYS)
    disp("1");
    [Dxt,~,~] = readValue(uaClient,dxt);
    disp("iniini");
    % Write values to OPC server (CODESYS)
    writeValue(uaClient,flagg,flag);
end

output_data=double([Dxt]);

end
