function prob = MultiVariate(Vec,Mean,Invcor,apriori)

        diff = Vec-Mean;
        dist = diff*Invcor*diff';
        n = length(Vec);
        wgt = 1/sqrt(det(inv(Invcor)));
        prob = apriori * ( 1 / (2*pi)^(n/2) ) * wgt * exp(-0.5*dist);

