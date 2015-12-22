function [isPainting] = classifyImage(input, paint, threshold)
    %paintingScore = # of features that classified input as painting
      paintingScore = 0;
      paintingScore = paintingScore + ...
          ((paint(1,1) >  threshold(1)) == (input(1) > threshold(1)));
      paintingScore = paintingScore + ...
          ((paint(2,1) >  threshold(2)) == (input(2) > threshold(2)));
      paintingScore = paintingScore + ...
          ((paint(3,1) >  threshold(3)) == (input(3) > threshold(3)));
      fprintf('Classifier says painting in %d / 3 features \n', paintingScore);
      isPainting = (paintingScore > 1);
end