
server = opcuaserverinfo('localhost');
uaClient = opcua(server);
%uaClient = opcua('localhost', 4840);
connect(uaClient, 'facundo','facundo');

disp(uaClient.isConnected)

% finish_in = findNodeByName(uaClient.Namespace,'finish', '-once');
% [fin,~,~] = readValue(uaClient,finish_in);
% 
% disp(fin)
% 
disconnect(uaClient);
