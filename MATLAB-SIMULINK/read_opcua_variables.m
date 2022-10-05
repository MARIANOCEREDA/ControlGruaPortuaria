

uaClient = opcua('localhost', 4840);
connect(uaClient,'AUTOMATAS_PLC', 'mariano99');

disp(uaClient.isConnected)

finish_in = findNodeByName(uaClient.Namespace,'finish', '-once');
[fin,~,~] = readValue(uaClient,finish_in);

disp(fin)

disconnect(uaClient);
