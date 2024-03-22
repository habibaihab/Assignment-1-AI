# Assignment1AI
:-consult(data).
:-dynamic
    item/3,
    alternative/2,
    boycott_company/2.

%3
getItemsInOrderById(CustName,OrderId, Items):-
    customer(Id, CustName),
    order(Id, OrderId, Items).

%6
isBoycott(Name):-
    item(Name,Company, _) -> boycott_company(Company, _);
    boycott_company(Name, _ ).


% 9
replaceBoycottItemsFromAnOrder(UserName, OrderID, NewList) :-
    customer(UserID, UserName),
    order(UserID, OrderID, OrderItems),
    replaceBoycottItems(OrderItems, NewList).

replaceBoycottItems([], []).
replaceBoycottItems([Item|T], [NewItem|NewT]) :-
    (   boycott_company(_, _), alternative(Item, NewItem) ->
        true
    ;   NewItem = Item
    ),
    replaceBoycottItems(T, NewT).


%10
calcPriceAfterReplacingBoycottItemsFromAnOrder(UserName, OrderID, NewList, TotalPrice) :-
      replaceBoycottItemsFromAnOrder(UserName, OrderID, NewList),
      calculateTotalPrice(NewList, TotalPrice).
calculateTotalPrice([], 0).
calculateTotalPrice([Item|T], TotalPrice) :-
    priceOfItem(Item, Price),
    calculateTotalPrice(T, RemainingPrice),
    TotalPrice is Price + RemainingPrice.

%11
getTheDifferenceInPriceBetweenItemAndAlternative(Item,A,DiffPrice):-
    alternative(Item, A),
    priceOfItem(Item,ItemPrice),
    priceOfItem(A, AlternativePrice),
    DiffPrice is ItemPrice -  AlternativePrice .

priceOfItem(Item, Price) :-
    item(Item,_, Price).



% bonus 12
add_item(Name, Company, ID):-
    assert(item(Name, Company, ID)).
remove_item(Name, Company, ID):-
    retract(item(Name, Company, ID)).

add_alternative(Item, Alter):-
    assert(alternative(Item, Alter)).
remove_alternative(Item, Alter):-
    retract(alternative(Item, Alter)).

add_boycott_company(Company, Text):-
    assert(boycott_company(Company, Text)).
remove_boycott_company(Company, Text):-
    retract(boycott_company(Company, Text)).






