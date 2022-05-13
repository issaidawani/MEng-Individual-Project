%toRemove = [];
test = zeros(34-length(toRemove),34-length(toRemove));
count = zeros(34-length(toRemove),1);
accuracies = zeros(34-length(toRemove),1);
false_positives = zeros(34-length(toRemove),1);
false_negatives = zeros(34-length(toRemove),1);
true_positives = zeros(34-length(toRemove),1);

for i = 2:length(errors)
    test(errors(1,i),errors(2,i)) = test(errors(1,i),errors(2,i)) + 1;
    count(errors(2,i)) = count(errors(2,i)) + 1;
end

highest = -1;
coords = [];
for x = 1:34-length(toRemove)
    true_positives(x) = test(x,x);
    for y = 1:34-length(toRemove)
        if(x~=y)
            if(test(x,y) > highest)
                highest = test(x,y);
                coords = [x y];
            end

            false_positives(x) = false_positives(x) + test(x,y);
            false_negatives(y) = false_negatives(y) + test(x,y);
        end
    end
end

precisions = true_positives./(true_positives+false_positives);
recalls = true_positives./(true_positives+false_negatives);
f1_scores = 2.*(precisions.*recalls)./(precisions+recalls);
accuracies = (sum(count)- false_negatives - false_positives)./(sum(count));

h = heatmap(test);
h.Title = 'Confusion Matrix of the 16 Channel CNN without 12 gestures';
h.XLabel = 'True Class';
h.YLabel = 'Predicted Class';
