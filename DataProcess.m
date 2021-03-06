%load dataset
% clear all
% close all
% Flights=readtable('C:\Users\bijia\Documents\MATLAB\CapturePoints\flights.csv');
% save('Flights.mat');
% load('Flights.mat');

% create table
stringTable(:,2)=string(Flights.DESTINATION_AIRPORT);
stringTable(:,1)=string(Flights.ORIGIN_AIRPORT);
% find unique by rows
%[C,ia,ic]= unique(stringTable(:,1:2),'rows');
% find unique by conlum
[Cc,iac,icc]= unique(stringTable(:,1:2),'stable');
Y = [1:length(Cc)];
Cc(:,2)=num2cell(Y');
%create map
MAP = containers.Map(Cc(:,1),Cc(:,2));
% reput index into table
for i=1:length(stringTable)
stringTable{i,3}=MAP(stringTable{i,1}); % start nodes
stringTable{i,4}=MAP(stringTable{i,2}); % end nodes
end
%create matrix
GraphMatrix=zeros(length(Cc),length(Cc));
court=1;
for ii=1:length(stringTable)
        GraphMatrix(stringTable{ii,3},stringTable{ii,4})=GraphMatrix(stringTable{ii,3},stringTable{ii,4})+court;
end

 G_2 = graph(stringTable(:,3),stringTable(:,4));
% H = simplify(G_2); %uniq the edges from 5819079 to 8609.

%%% Using Block cut tree graph method to find the key structure of
%%% graph.
G_tree = bctree(G_2); % 183 nodes with 181 edges.
K=size(G_tree.Edges);
K_value=K(1,1);

%%% Retrieve whole dataset to create edge.csv file.
flight_edge=[stringTable(:,3),stringTable(:,4)];
csvwrite('flight_edges.csv',flight_edge);
