function [netY,tr,gof,FremskrevetY]=myNNtrainer(X,T)
% X1= Predictors
% Y = Response
    for i=1:1000
        net=fitnet(5,'trainlm');
        net.divideParam.trainRatio=34/100;
        net.divideParam.valRatio=33/100;
        net.divideParam.testRatio=33/100;
        [net,tr]=train(net,X',T');
        yPredY=net(X');
        [~,gof] = fit(T,yPredY','poly1','Lower',[-inf,0],'Upper',[inf,0]);
        FremskrevetY(:,i)=yPredY;
        netY{i}=net;
    end
end
