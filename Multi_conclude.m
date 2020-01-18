function Multi_conclude()
delete(gcp('nocreate'));
parpool('local',1);
addpath(genpath(fileparts(mfilename('fullpath'))));%add path 
    for dim=10
        test_case={
            @OptMPNDS,@MPMOP1,100,1,1,1000*dim*2,dim;
            @OptMPNDS,@MPMOP2,100,1,1,1000*dim*2,dim;
            @OptMPNDS,@MPMOP3,100,1,1,1000*dim*2,dim;
            @OptMPNDS,@MPMOP4,100,1,1,1000*dim*2,dim;
            @OptMPNDS,@MPMOP5,100,1,1,1000*dim*2,dim;
            @OptMPNDS,@MPMOP6,100,1,1,1000*dim*2,dim;
            @OptMPNDS,@MPMOP7,100,1,1,1000*dim*3,dim;
            @OptMPNDS,@MPMOP8,100,1,1,1000*dim*3,dim;
            @OptMPNDS,@MPMOP9,100,1,1,1000*dim*3,dim;
            @OptMPNDS,@MPMOP10,100,1,1,1000*dim*3,dim;
            @OptMPNDS,@MPMOP11,100,1,1,1000*dim*3,dim;
            @OptAll,@MPMOP1,100,1,1,1000*dim*2,dim;
            @OptAll,@MPMOP2,100,1,1,1000*dim*2,dim;
            @OptAll,@MPMOP3,100,1,1,1000*dim*2,dim;
            @OptAll,@MPMOP4,100,1,1,1000*dim*2,dim;
            @OptAll,@MPMOP5,100,1,1,1000*dim*2,dim;
            @OptAll,@MPMOP6,100,1,1,1000*dim*2,dim;
            @OptAll,@MPMOP7,100,1,1,1000*dim*3,dim;
            @OptAll,@MPMOP8,100,1,1,1000*dim*3,dim;
            @OptAll,@MPMOP9,100,1,1,1000*dim*3,dim;
            @OptAll,@MPMOP10,100,1,1,1000*dim*3,dim;
            @OptAll,@MPMOP11,100,1,1,1000*dim*3,dim;
            };
        for i=1:11
            Score=[];
            for j=0
                spmd(1)
                    display(j+labindex);
                     s = RandStream.create('mrg32k3a','NumStreams',30,'StreamIndices',j+labindex);
                    RandStream.setGlobalStream(s); 
                    result=main('-algorithm',test_case{i,1},'-problem',test_case{i,2},'-N',test_case{i,3},'-save',test_case{i,4},'-run',test_case{i,5}, ...,
                        '-evaluation',test_case{i,6},'-D',test_case{i,7});
                 end
                   result=  cat(1, result{1:end});          
                   Score=[Score;result];
            end    
            result_mean=mean(Score);
            result_std=std(Score);
            location={sprintf('Data/2/%s',func2str(test_case{i,1}))};
           [~,~]=mkdir(sprintf('%s/%d/',location{1},dim));
           save(sprintf('%s/%d/%s_%s(%d).mat',location{1},dim,func2str(test_case{i,2}),func2str(test_case{i,1}),test_case{i,6}),'result_mean','result_std','Score');
        end 
        
    end
end



