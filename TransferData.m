%%% transfer json to mat
fname='flight.json'; %% your json dataset
group=jsondecode(fileread(fname));
%%% prepare new map (number to words)
Cc_index=str2double(Cc(:,2))-1;
Cc_i=string(Cc_index);
ReMap=containers.Map(Cc_i,Cc(:,1));
%%% rename json files name
Gtable=struct2table(group);
Gtable_name=string(Gtable.Properties.VariableNames);
Gtable_index=regexprep(Gtable_name,'x','');
Gtable_value=string(table2array(Gtable));
StaNode=cell(length(ReMap),1);
EndNode=cell(length(ReMap),1);
for index=1:length(ReMap)
    StaNode(index)={ReMap(Gtable_index(index))};
    EndNode(index)={ReMap(Gtable_value(index))};
end

NewG_Path=[StaNode,EndNode];
NewG_Node=unique(EndNode,'rows');