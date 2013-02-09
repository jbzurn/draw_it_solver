function results = drawit_solver(list,choose)

%%%Solver for the game Draw It rev1.1 2013-0208
%%%Author: J. Brooks Zurn
%%%Language: Matlab
%%%Returns a list of potential words for the given 
%%% input characters, limited to wordlength 'choose'
%%%
%%%Example: list = 'abcdefghijklmn'; choose = 7;
%%%>>drawit_solver(list,choose)
% % % ans = 
% % %     'BAGLIKE',
% % %     'BECHALK'
% % %     'BIGHEAD'
% % %     'BLACKED'
% % %     'CHALKED'
% % %     'DIEBACK'
% % %     'FADLIKE'
% % %     'FILCHED'
% % %     'FLACKED'
% % %     'FLICKED'
% % %     'HACKLED'
% % %     'HIDABLE'
% % %     'JACKLEG'
%%%
%%%Notes: The dictionary doesn't contain 'new' words
%%% such as pop stars or current memes. If none of
%%% the returned words seem to fit the drawing, it
%%% may represent a word not contained in the 
%%% dictionary.
%%%
%%%Resources: Dictionary is TWL06.txt, obtained from 
%%% http://www.isc.ro/en/commands/lists.html  



%define dictionary
filename = 'TWL06.txt';

%load dictionary
wordlist = importdata(filename);

%get every subgroup
list=upper(list);
set = nchoosek(list,choose);
num_sets = size(set,1);
num_perms = factorial(choose)*num_sets;

temp_perms = perms(set(1,:));
all_perms = intersect(temp_perms,wordlist);

if(num_sets > 1)
    disp('completed: ');
    one_perc = num_sets/100;
    this_perc=0;
    
    for i=2:num_sets
        if((i>(this_perc*one_perc)))
            %this_perc=this_perc+1;
            this_perc = i/num_sets;
            fprintf('%2.1f percent\n',(this_perc*100));
        end

        %compute the current permutation
        temp_perms = perms(set(i,:));
        temp_perms2 = intersect(temp_perms,wordlist);
        all_perms = vertcat(all_perms,temp_perms2);
    end
    disp('done.');
end

results = unique(all_perms);
