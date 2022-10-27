function output_data = Level_1_Client_OPC(input)
persistent init_server;
persistent init_nodes1;
persistent uaClient;
persistent var_node_in;
persistent var_node_out;
persistent dxt dlh balance;
persistent y x dlh_in dxt_in joy_x joy_t cycle twt auto_mode loading where_ mass_flag ml;


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
    var_node_in = findNodeByName(uaClient.Namespace,'input','-once');
    var_node_out = findNodeByName(uaClient.Namespace,'output','-once');
    % Inputs
    x = findNodeByName(var_node_in,'x','-once');
    y = findNodeByName(var_node_in,'y','-once');
    dxt_in = findNodeByName(var_node_in,'dxt_in','-once');
    dlh_in = findNodeByName(var_node_in,'dlh_in','-once');
    joy_x = findNodeByName(var_node_in,'joy_x','-once');
    joy_t = findNodeByName(var_node_in,'joy_y','-once');
    cycle = findNodeByName(var_node_in,'cycle','-once');
    twt = findNodeByName(var_node_in,'twt','-once');
    auto_mode = findNodeByName(var_node_in,'auto_mode','-once');
    loading = findNodeByName(var_node_in,'loading','-once');
    where_ = findNodeByName(var_node_in,'where_','-once');
    mass_flag = findNodeByName(var_node_in,'mass_flag','-once');
    ml = findNodeByName(var_node_in,'ml','-once');
    % Outputs
    dxt = findNodeByName(var_node_out,'dxt','-once');
    dlh = findNodeByName(var_node_out,'dlh','-once');
    balance = findNodeByName(var_node_out,'balance','-once');
end

if uaClient.isConnected == 1 && init_nodes1 == 1
    % Read values from OPC server (CODESYS)
    [dxt,~,~] = readValue(uaClient,dxt);
    [dlh,~,~]=readValue(uaClient,dlh);
    [balance,~,~]=readValue(uaClient,balance);
    % Write values to OPC server (CODESYS)
    writeValue(y,input(1));
    writeValue(x,input(2));
    writeValue(dlh_in,input(3));
    writeValue(dxt_in,input(4));
    writeValue(joy_x,input(5));
    writeValue(joy_t,input(6));
    writeValue(cycle,input(7));
    writeValue(twt,input(8));
    writeValue(auto_mode,input(9));
    writeValue(loading,input(10));
    writeValue(where_,input(11));
    writeValue(mass_flag,input(12));
    writeValue(ml,input(13));
end

output_data = double([dxt,dlh,balance]);

end