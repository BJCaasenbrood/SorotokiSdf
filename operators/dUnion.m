function d = dUnion(d1,d2) 
d=[d1(:,1:(end-1)),d2(:,1:(end-1))];
d=[d,min(d1(:,end),d2(:,end))];
end