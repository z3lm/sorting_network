clc

% Sim parameters
Nio = 10; % Number of inputs (=Number of outputs)
Npn = 100; % Number of pool-nodes
Ncp = 5*Npn; % Number of couplings inside pool

I = [0 0 0 1 0 1 0 1 0 1]';% randi(2,Nio,1)-1;    % random, binary input vector
A = zeros(Npn,1);      % activity state vector, é(0...1)
O = zeros(Nio,1);        % init. output vector of same length

% Random synaptic pairing
sipi = randi( Npn, Ncp, 1 ); % Signalling Partner Index
repi = randi( Npn, Ncp, 1 ); % Receiving Partner Index

iri = randi( Nio, Nio, 1 ); % Input Receiver Index
osi = randi( Nio, Nio, 1 ); % Output Sender Index

% Initialization of coupling constants
icp = 0.1*rand( Nio, 1 );
acp = 0.1*rand( Ncp, 1 );
ocp = 0.1*rand( Nio, 1 );

while sum(O)<sum(I)
    % Couple activation step
    A(iri) = A(iri) + icp.*I;
    for c=1:Ncp
        is=sipi(c); ir=repi(c);
        A(ir) = A(ir) + acp(c)*A(is);
    end
    clear ir is c
    O = O + ocp.*A(osi);
end

show_activation_state(I,A,O,Nio)

function show_activation_state(I,A,O,Nio)
iMF = 1;
format = '% 3.2f';
for row=1:Nio
    for col=1:Nio
        MatFormA(row,col) = A(iMF);
        iMF = iMF + 1;
    end
end
disp([
    num2str(I),'   ¦   '.*ones(Nio,1)...
    ,num2str(MatFormA,format),'   ¦   '.*ones(Nio,1)...
    ,num2str( round( O ) )
    ])
end






