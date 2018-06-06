function [Q_pred,crv,gof,NSE] = linpredQ(Qmeas,lvl)
% Qmeas og lvl er sammenhængende datasæt med måling af Q og water level.
% Q_pred er den Q som bliver plottet ud fra lvl

[curve_lvl]=fit(lvl,Qmeas,'poly1');

Q_pred=curve_lvl.p1*lvl+curve_lvl.p2;

[crv,gof]=fit(Qmeas,Q_pred,'poly1');%,'Lower',[-inf,0],'Upper',[inf,0]); %Her plottes Q_meas mod Q_pred.

Top=(Qmeas-Q_pred).^2;
Bund=(Qmeas-mean(Qmeas)).^2;
NSE=1-(sum(Top)/sum(Bund));

end