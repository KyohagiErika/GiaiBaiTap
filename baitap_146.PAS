program baitap_146;
const
	MAX_N = 10000;
	LINK = 'MST.';
	IP = 'INP';
	OP = 'OUT';
type
	vector = array[1..MAX_N] of Integer;
	matrix = array[1..MAX_N,1..MAX_N] of Integer;
	edge = record
		x, y, w : Integer;
	end;
	edge_arr = array[1..MAX_N] of edge;
var
	f : text;
	n, m, min, _reslt: Integer;
	c, g: matrix;
	e: edge_arr;
	x, reslt : vector;
	checked : array[1..MAX_N] of Boolean;
procedure Input();
var
	i, u, v: Integer;
begin
	assign(f,LINK+IP);
	reset(f);
	readln(f,n,m);
	for i := 1 to m do
	begin
		with e[i] do readln(f,x,y,w);
		u := e[i].x;
		v := e[i].y;
		c[u,v] := e[i].w;
		c[v,u] := c[u,v];
	end;
	for i := 1 to n do checked[i] := false;
	close(f);
	min := 0;
	_reslt := 0;
end;
function FindEdge(_x, _y : Integer): Integer;
var
	i: Integer;
begin
	for i := 1 to m do
		if (e[i].x = _x) and (e[i].y = _y) then
			exit(i);
end;
procedure Process(i : Integer);
var
	j, _u, _v, _min, xi: Integer;
begin
	if (i = 1) then
	begin
		x[i] := 1;
		checked[x[i]] := true;
		Process(i+1);
	end
	else
	begin
		_u := 0;
		_v := 0;
		_min := MAX_N;
		for j := 1 to i-1 do
			for xi := 1 to n do
				if (not checked[xi]) and (c[x[j],xi] <> 0) and (c[x[j],xi] < _min) then
				begin
					_u := x[j];
					_v := xi;
					_min := c[_u,_v];
				end;
		if (_v = 0) then
			exit
		else
		begin
			min := min + _min;
			g[_u,_v] := _min;
			x[i] := _v;
			_reslt := _reslt + 1;
			reslt[_reslt] := FindEdge(_u,_v);
			checked[x[i]] := true;
			Process(i+1);
		end;
	end;
end;
procedure Output();
var
	i: Integer;
begin
	assign(f,LINK+OP);
	rewrite(f);
	writeln(f,min);
	for i := 1 to _reslt do
		writeln(f,reslt[i]);
	close(f);
end;
begin
	Input;
	Process(1);
	Output;
end.
