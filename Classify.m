function class = Classify(v,N,Means,Invcors,Dim,Aprioris)

        evals = zeros(N,1);
        IC = zeros(Dim,Dim);
        for i = 1 : N
            IC = reshape(Invcors(i,:,:),Dim,Dim);
            evals(i) = MultiVariate(v,Means(i,:),IC,Aprioris(i));
        end
        evaluations = evals'
        bestclasses = find(evals == max(evals));
        class = bestclasses(1);

