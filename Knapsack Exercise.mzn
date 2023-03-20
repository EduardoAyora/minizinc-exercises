% Use this editor as a MiniZinc scratch book
% Mochila 20 kg
int: weightLimit = 20 ;
int: itemCount = 8;
enum items = {book, jacket, washbag, computer, boots,
                alarmclock, anorak, food} ;
                
array [items] of int: weight = [2,4,3,8,7,1,2,6] ;

% 1: Valor maximo

array [items] of int: value = [6,10,8,25,22,4,5,20] ;

array [items] of var 0..1: selected ;
var int: TotalValue;
var int: TotalWeight;

constraint sum(i in items)(selected[i]*weight[i]) = TotalWeight ;
constraint TotalWeight <= weightLimit ;
constraint sum(i in items)(selected[i]*value[i]) = TotalValue ;

solve maximize TotalValue ;