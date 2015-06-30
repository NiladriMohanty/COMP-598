function [newcontents count]= processAbstract(contents,count)

contents=lower(contents);

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
end
  count=count+1;
  disp(count);
end

    
    