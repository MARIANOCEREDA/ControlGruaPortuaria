function [output_data] = Level_1_Client_OPC(input)
persistent init_server;
persistent init_nodes;
persistent uaClient;
persistent var_node_in;
persistent dxt dlh balance;
persistent turn_on_system;
persistent y x dlh_in dxt_in joy_h joy_t cycle twt auto_mode loading where mass_flag ml;

Dxt = 0;
Dlh = 0;
Balance =0;

disp(init_nodes)
if (isempty(init_server)  || input(15)==0)
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
    var_node_in = findNodeByName(uaClient.Namespace,'GLOBALS');
    % var_node_out = findNodeByName(uaClient.Namespace,'GLOBALS','-once');
    % Inputs
    turn_on_system = findNodeByName(var_node_in,'turn_on_system','-once');
    x = findNodeByName(var_node_in,'x','-once');
    y = findNodeByName(var_node_in,'y','-once');
    dxt_in = findNodeByName(var_node_in,'dxt_in','-once');
    dlh_in = findNodeByName(var_node_in,'dlh_in','-once');
    joy_h = findNodeByName(var_node_in,'joy_h','-once');
    joy_t = findNodeByName(var_node_in,'joy_t','-once');
    cycle = findNodeByName(var_node_in,'cycle','-once');
    twt = findNodeByName(var_node_in,'twt','-once');
    auto_mode = findNodeByName(var_node_in,'auto_mode','-once');
    loading = findNodeByName(var_node_in,'loading','-once');
    where = findNodeByName(var_node_in,'where','-once');
    ml = findNodeByName(var_node_in,'ml','-once');
    mass_flag = findNodeByName(var_node_in,'mass_flag','-once');
    % Outputs
    dxt = findNodeByName(var_node_in,'dxt','-once');
    dlh = findNodeByName(var_node_in,'dlh','-once');
    balance = findNodeByName(var_node_in,'balance','-once');
end

if uaClient.isConnected == 1 && init_nodes == 1
    % Read values from OPC server (CODESYS)
    [Dxt,~,~] = readValue(uaClient,dxt);
    [Dlh,~,~]=readValue(uaClient,dlh);
    [Balance,~,~]=readValue(uaClient,balance);
    disp("iniini");
    % Write values to OPC server (CODESYS)
    writeValue(uaClient,y,input(1));
    writeValue(uaClient,x,input(2));
    writeValue(uaClient,dlh_in,input(3));
    writeValue(uaClient,dxt_in,input(4));
    writeValue(uaClient,joy_t,input(5));
    writeValue(uaClient,joy_h,input(6));
    writeValue(uaClient,cycle,input(7));
    writeValue(uaClient,twt,input(8));
    writeValue(uaClient,auto_mode,input(9));
    writeValue(uaClient,loading,input(10));
    writeValue(uaClient,where,input(11));
    writeValue(uaClient,ml,input(13));
    writeValue(uaClient,mass_flag,input(12));
    writeValue(uaClient,turn_on_system,input(14));
end

output_data = double([Dxt,Dlh,Balance]);

end