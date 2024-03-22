
:-consult(data).

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
%11
getTheDifferenceInPriceBetweenItemAndAlternative(Item,A,DiffPrice):-
    alternative(Item, A),
    priceOfItem(Item,ItemPrice),
    priceOfItem(A, AlternativePrice),
    DiffPrice is ItemPrice -  AlternativePrice .

priceOfItem(Item, Price) :-
    item(Item,_, Price).
%10
calcPriceAfterReplacingBoycottItemsFromAnOrder(UserName, OrderID, NewList, TotalPrice) :-
      replaceBoycottItemsFromAnOrder(UserName, OrderID, NewList),
      calculateTotalPrice(NewList, TotalPrice).
calculateTotalPrice([], 0).
calculateTotalPrice([Item|T], TotalPrice) :-
    priceOfItem(Item, Price),
    calculateTotalPrice(T, RemainingPrice),
    TotalPrice is Price + RemainingPrice.
