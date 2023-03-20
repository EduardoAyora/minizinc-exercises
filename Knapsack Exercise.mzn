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
%constraint sum(i in items)(selected[i]*value[i]) = TotalValue ;

% 2: Volumen 2000 cm3

array [items] of int: volume = [250, 500, 300, 250, 650, 130, 150, 600] ;

var int: TotalVolume;

constraint sum(i in items)(selected[i]*volume[i]) = TotalVolume ;
constraint TotalVolume <= 2000 ;

% 3: En combinación consigues más o menos valor

array [items,items] of int: extra_value =
      [| 0, 0, 0,-5, 0, 0, 0, 0
       | 0, 0, 0, 0, 3, 0,-2, 0
       | 0, 0, 0, 0, 0, 0, 0, 0
       |-5, 0, 0, 0, 0,-2, 0, 0
       | 0, 3, 0, 0, 0, 0, 0, 0
       | 0, 0, 0,-2, 0, 0, 0, 0
       | 0,-2, 0, 0, 0, 0, 0, 0
       | 0, 0, 0, 0, 0, 0, 0, 0
|] ;

% No se puede hacer, es inconsistente
% constraint sum(i in items)(selected[i]*value[i]) = TotalValue ;
% constraint forall(i,j in items)(TotalValue = TotalValue + extra_value[i,j]);


var int: CombinationValue;
var int: SelectedValue;

constraint sum(item1,item2 in items where selected[item1] == 1 /\ selected[item2] == 1)(extra_value[item1,item2]) = CombinationValue;

constraint sum(i in items)(selected[i]*value[i]) = SelectedValue ;

constraint CombinationValue + SelectedValue = TotalValue ;

solve maximize TotalValue ;
