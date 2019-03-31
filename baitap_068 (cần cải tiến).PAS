{
  có 2 điều cần cải tiến trong bài này:
  1. kéo xuống dòng 76 và chạy test :v
  2. bài này làm bằng tham ăn + ngẫu nhiên nên chưa đúng hết mọi trường hợp
}
program baitap_068;
const
	MAX_N = 10000;
	LINK = 'TOUR.';
	IP = 'INP';
	OP = 'OUT';
type
	vector = array[1..MAX_N] of Integer;
	matrix = array[1..MAX_N,1..MAX_N] of Integer;
var
	f: text;
	n, m, s, _reslt,min: Integer;
	c: matrix;
	x: vector;
	checked: array[1..MAX_N] of Boolean;
procedure Input();
var
	i, u, v: Integer;
begin
	assign(f,LINK+IP);
	reset(f);
	readln(f,n,m);
	for i := 1 to m do 
		readln(f,u,v,c[u,v]);
	close(f);
	randomize();
	s := 1+random(n);
	min := 0;
end;
function minEdge(u : integer): Integer;
var
	tmp, i: Integer;
begin
	minEdge := 0;
	for i := 1 to n do 
		if (not checked[i]) and (c[u,i] <> 0) and (c[u,i] < tmp) then
		begin
			tmp := c[u,i];
			minEdge := i;
		end;
end;
procedure Process(i : Integer);
var
	j: Integer;
	ok : Boolean;
begin
	if (i = 1) then
	begin
		
		x[i] := s;
		checked[x[i]] := true;
		Process(i+1);
	end
	else
	begin
		x[i] := minEdge(x[i-1]);
		if x[i] = 0 then
			if c[x[i-1],s] <> 0 then
			begin
				ok := true;
				for j := 1 to n do
					if not checked[j] then
					begin
						ok := false;
						_reslt := 0;
						break;
					end;
				if ok then
				begin
					_reslt := i-1;
					min := min + c[x[i-1],s];
					writeln();      // note dòng này lại, chạy và cảm nhận :V
				end;
			end else
				_reslt := 0
		else
		begin
			min := min + c[x[i-1],x[i]];
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
	if (_reslt = 0) then
		writeln(f,_reslt)
	else
	begin
		writeln(f,1);
		writeln(f,min);
		writeln(f,_reslt);
		for i := 1 to _reslt do
			write(f,x[i],' ');
	end;
	close(f);
end;
begin
	Input;
	Process(1);
	Output;
end.
