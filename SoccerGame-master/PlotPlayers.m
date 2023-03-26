function [] = PlotPlayers(players)
pos = players{1};

%Players size
radie = 2;

hold on
team = players{3};
team1 = find(team == 0);
team2 = find(team == 1);

for i = 1:length(team1)
    plotpos = [pos(team1(i),1)-radie pos(team1(i),2)-radie 2*radie 2*radie];
    rectangle('Position',plotpos,'Curvature',[0.9 0.9],'FaceColor',[1 0 0],...
        'EdgeColor','none');
    plotpos = [pos(team1(i),1) pos(team1(i),2)-radie radie 2*radie];
    rectangle('Position',plotpos,'Curvature',[0.9 0.9],'FaceColor',[1 0 0],...
        'EdgeColor','none');
    plotpos = [pos(team1(i),1)-2*radie/6 pos(team1(i),2)-radie 2*radie/3 2*radie];
    rectangle('Position',plotpos,'FaceColor','#F4F5F0',...
        'EdgeColor','none');
    hold on
end
for i = 1:length(team2)
    plotpos = [pos(team2(i),1)-radie pos(team2(i),2)-radie 2*radie 2*radie];
    rectangle('Position',plotpos,'Curvature',[0.9 0.9],'FaceColor',[0 0.35 1],...
        'EdgeColor','none');
    plotpos = [pos(team2(i),1) pos(team2(i),2)-radie radie 2*radie];
    rectangle('Position',plotpos,'Curvature',[0.9 0.9],'FaceColor',[0 0.35 1],...
        'EdgeColor','none');
    plotpos = [pos(team2(i),1)-2*radie/6 pos(team2(i),2)-radie 2*radie/3 2*radie];
    rectangle('Position',plotpos,'FaceColor','#F4F5F0',...
        'EdgeColor','none');
    hold on
end
end