function [value]=Model_NN(idata,net,n,iniY)
% this function returns output vector produced by NN-based model  net on
% the bases of iodata n is the order of the model, iniY is the vector to
% initialize output

[read veerud]=size(idata); % get the size of input-output data

    
for i=1:n
    output(i)=iniY(i); % initialize first n
end

% let us simulate the network now
for i=n+1:read
    for j=1:n
        P{j,1}=[idata(i-n+j-1); output(i-n+j-1)]; % assemble input vector fo NN-simulator
    end
    size(P)
    %P={[iodata(i-n,1); iodata(i-n,veerud+1)];[iodata(i-n+1,1); iodata(i-n+1,veerud+1)]; [iodata(i-n+2,1); iodata(i-n+2,veerud+1)]; [iodata(i-n+3,1); iodata(i-n+3,veerud+1)]; [iodata(i-n+4,1); iodata(i-n+4,veerud+1)]};
    %P=[iodata(i-n,1); iodata(i-n,veerud+1); iodata(i-n+1,1); iodata(i-n+1,veerud+1)]';
    M=sim(net,P);

    output(i)=M{1,1};
end

value=output;

end


