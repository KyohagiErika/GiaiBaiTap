program baitap_026;
const
	MAX_N = 10000;
	LINK = 'MAX.';
	IP = 'INP';
	OP = 'OUT';
type
	matrix = array[0..MAX_N,0..MAX_N] of Integer;
	vector = array[0..MAX_N] of Integer;
var
	f: text;
	n, m, s, t, k, _reslt, maxp: Integer;
	tbl,c,lock: matrix;
	Free, trace, reslt: vector;
procedure Input();
var
	i,j: Integer;
begin
	assign(f,LINK+IP);
	reset(f);
	readln(f,n,m);
	for i := 1 to n do 
		for j := 1 to m do
			read(f,tbl[i,j]);
	close(f);
end;
procedure setupGraph();
var
	i, j, r, count: Integer;
begin
	k := (n*m)+1;
	s := 0;
	t := k;
	for i := 1 to n do
	begin
		c[0,i] := -tbl[i,1];
		if c[0,i] = 0 then 
			lock[0,i] := 1;
	end;
	count := 0;
	for j := 1 to m-1 do
		for i := 1 to n do
		begin
		 	count := count + 1;
		 	r := -1;
		 	if ((i-1) > 0) then
		 	begin
		 		c[count,count+r+5] := -tbl[i-1,j+1];
		 		if c[count,count+r+5] = 0 then
		 			lock[count,count+r+5] := 1;
		 	end;
		 	r := r + 1;
		 	c[count,count+r+5] := -tbl[i,j+1];
		 	if c[count,count+r+5] = 0 then
		 			lock[count,count+r+5] := 1;
		 	r := r + 1;
		 	if ((i+1) <= n) then
		 	begin
				c[count,count+r+5] := -tbl[i+1,j+1];
				if c[count,count+r+5] = 0 then
		 			lock[count,count+r+5] := 1;
		 	end;
		end;
	for i := k-5 to k do
		lock[i,t] := 1;
end;
procedure minPath();
var
	j, i, u, v, min: Integer;
begin
	for i := 0 to k do 
	begin
		Free[i] := 1;
		trace[i] := s;
	end;
	for i := 0 to k do
		for j := 0 to k do
			if (c[i,j] = 0) and (lock[i,j] <> 1) then
				c[i,j] := MAX_N;
	c[s,s] := 0;
	trace[s] := -1;
	repeat
		min := MAX_N;
		u := -1;
		for i := 0 to k do
			if (Free[i] = 1) and (c[s,i] < min) then
			begin
				min := c[s,i];
				u := i;
			end;
		if (u = t) or (u = -1) then break;
		Free[u] := 0;
		for v := 0 to k do
			if (Free[v] = 1) and (c[s,v] > c[s,u] + c[u,v]) then
			begin
				c[s,v] := c[s,u] + c[u,v];
				trace[v] := u;
			end;
	until false;
end;
procedure resltProcess();
var
	i, j, r, tmp: Integer;
begin
	maxp := -c[s,t];
	_reslt := 0;
	t := trace[t];
	while (t <> s) do
	begin
		_reslt := _reslt + 1;
		reslt[_reslt] := t;
		t := trace[t];
	end;
	i := 1;
	j := _reslt;
	repeat
		tmp := reslt[i];
		reslt[i] := reslt[j];
		reslt[j] := tmp;
		i := i + 1;
		j := j - 1;
	until i >= j;
	r := -5;
	for i := 1 to _reslt do
	begin
		r := r + 5;
		reslt[i] := reslt[i] - r;
	end;
end;
procedure Process();
begin
	setupGraph;
	minPath;
	resltProcess;
end;
procedure Output();
var
	i: Integer;
begin
	assign(f,LINK+OP);
	rewrite(f);
	writeln(f,maxp);
	for i := 1 to _reslt do
		writeln(f,reslt[i]);
	close(f);
end;
begin
	Input;
	Process;
	Output;
end.
