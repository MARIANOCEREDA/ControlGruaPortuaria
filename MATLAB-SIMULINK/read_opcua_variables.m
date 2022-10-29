
server = opcuaserverinfo('localhost');
uaClient = opcua('localhost', 4840);
connect(uaClient, 'AUTOMATAS_PLC','mariano99');
% serverNodes = browseNamespace(uaClient);
%
% simNode = findNodeByName(uaClient.Namespace,'GLOBALS',"-once")
var_node_in = findNodeByName(uaClient.Namespace,'GLOBALS','-once');
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
mass_flag = findNodeByName(var_node_in,'mass_flag','-once');
ml = findNodeByName(var_node_in,'ml','-once');
dxt = findNodeByName(var_node_in,'dxt','-once');
dlh = findNodeByName(var_node_in,'dlh','-once');
balance = findNodeByName(var_node_in,'balance','-once');


[dxt,~,~] = readValue(uaClient,dxt);
[dlh,~,~]=readValue(uaClient,dlh);
[balance,~,~]=readValue(uaClient,balance);
writeValue(uaClient,turn_on_system,1);
pause(10);
writeValue(uaClient,turn_on_system,0);

disp(dxt);
disp(dlh);


disp(uaClient.isConnected)

disconnect(uaClient);
