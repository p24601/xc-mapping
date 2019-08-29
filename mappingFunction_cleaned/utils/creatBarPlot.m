function creatBarPlot(barMatrix,groupIDs,source4EachGroup)

figure
hold on
w = 0.25;
h1 = plot(nan,nan,'square','MarkerFaceColor', [1,0,0],'Color',[1,0,0]);
h2 = plot(nan,nan,'square','MarkerFaceColor', [0,1,0],'Color',[0,1,0]);
h3 = plot(nan,nan,'square','MarkerFaceColor', [0,0,1],'Color',[0,0,1]);

for ii = 1:size(barMatrix,1)
    currSources = source4EachGroup{ii};
    init1 = ii - w - w/4;
    init2 = ii + w/4;
    switch currSources{1}
        case 'vivo'
            colorVec = [1, 0, 0];
            colorVec = colorVec/sum(colorVec);
        case 'moto'
            colorVec = [0, 1, 0];
            colorVec = colorVec/sum(colorVec);
        case 'ttsim'
            colorVec = [1,0,0];
            colorVec = colorVec/sum(colorVec);
    end
    rectangle('Position',[init1,0,w,barMatrix(ii,1)],'FaceColor',colorVec,'LineWidth',1)
    switch currSources{2}
        case 'vivo'
            colorVec = [1, 0, 0];
            colorVec = colorVec/sum(colorVec);
        case 'moto'
            colorVec = [0, 1, 0];
            colorVec = colorVec/sum(colorVec);
        case 'ttsim'
            colorVec = [0,0,1];
            colorVec = colorVec/sum(colorVec);
    end
    rectangle('Position',[init2,0,w,barMatrix(ii,2)],'FaceColor',colorVec,'LineWidth',1)
end
legend([h1,h2,h3],{'vivo','moto','ttsim'});
set(gca,'XTick',1:size(barMatrix,1),'XTickLabel',groupIDs);
hold off

%code for 3d bar plot
Z = zeros(3,3);
for ii = 1:size(Z,1)
    %currTarget = groupIDs{ii};
    currSources = source4EachGroup{ii};
    for jj = 1:2
            currSource = currSources{jj};
            Z(ii,strcmp(currSource,groupIDs)) = barMatrix(ii,jj);
    end
end

figure
hold on
b = bar3(Z);
for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end
for i = 1:numel(b)
  index = logical(kron(Z(:, i) == 0, ones(6, 1)));
  zData = get(b(i), 'ZData');
  zData(index, :) = nan;
  set(b(i), 'ZData', zData);
end
xlabel('Source')
ylabel('Target')
colormap jet
colorbar
set(gca,'XTickLabel',groupIDs,'YTickLabel',groupIDs)
hold off
end