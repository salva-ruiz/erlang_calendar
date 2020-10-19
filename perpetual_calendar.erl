-module(perpetual_calendar).
-export([day_of_week/3, iso8601_day_of_week/3, days_in_month/2]).

day_of_week(Year, 1, Day) -> day_of_week(Year - 1, 13, Day);
day_of_week(Year, 2, Day) -> day_of_week(Year - 1, 14, Day);
day_of_week(Year, Month, Day) ->
	C = Year div 100,
	Y = Year rem 100,
	N = (13 * (Month - 2) - 1) div 5 + Y div 4 + C div 4 + Day + Y - 2 * C,
	if
		N >= 0 -> N rem 7;
		true   -> (N + (7 * ceil(abs(N) / 7))) rem 7
	end.

iso8601_day_of_week(Year, Month, Day) ->
	D = day_of_week(Year, Month, Day),
	if
		D == 0 -> 6;
		true   -> D - 1
	end.

days_in_month(Year, 2) when (Year rem 400 == 0) -> 29;
days_in_month(Year, 2) when (Year rem 4 == 0) and not (Year rem 100 == 0) -> 29;
days_in_month(_, 2) -> 28;
days_in_month(_, Month) ->
	T = lists:member(Month, [4, 6, 9, 11]),
	if
		T    -> 30;
		true -> 31
	end.
