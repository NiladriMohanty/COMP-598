function [word_indices count]= processAbstract_WI(contents,count,dict)

contents=lower(contents);
word_indices = [];
vocabList=dict;

newcontents=[];

while ~isempty(contents)
    [str, contents]=strtok(contents,...
        [' @$/#.-:&*+=[]?\!(){},''">_<;%' char(10) char(13)]);
    
    %%stem the word
    try str = porterStemmer(strtrim(str)); 
    catch str = ''; 
        continue;
    end;
    newcontents=[newcontents,' ', str];
    
    word_indices=[word_indices;find(strcmp(str,vocabList))];
end
  count=count+1;
  disp(count);
  
  %%%comparing word indices with the vocabulary list to get indices value
  
   
end