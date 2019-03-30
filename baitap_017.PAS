{
	bài làm dù đã hoàn thành nhưng code viết lộn xộn, chưa tối ưu, dẫn đến chậm chạp
}
program baitap_017;
const
	MAX = 100;
	LINK = 'BOARD.';
	IP = 'INP';
	OP = 'OUT';
type
	matrix = array[0..MAX,0..MAX] of Integer;
var
	f: text;
	n, m: Integer;
	c, g: matrix;
	X, Y: array[1..8] of Integer;
procedure Input();
var
	i, j : Integer;
begin
	assign(f,LINK+IP);
	reset(f);
	readln(f,n,m);
	n := n;
	m := m;
	for i := 0 to n-1 do 
		for j := 0 to m-1 do
			read(f,c[i,j]);
	close(f);
	for i := 0 to n-1 do
		for j := 0 to m-1 do
			g[i,j] := n * i + j;
	X[1] := -2;
	X[2] := -2;
	X[3] := -1;
	X[4] := -1;
	X[5] := 1;
	X[6] := 1;
	X[7] := 2;
	X[8] := 2;

	Y[1] := -1;
	Y[2] := 1;
	Y[3] := -2;
	Y[4] := 2;
	Y[5] := -2;
	Y[6] := 2;
	Y[7] := -1;
	Y[8] := 1;
end;
procedure PrintWay(x1,y1,x2,y2 : Integer);
var
	_tmp, tmp, i: Integer;
begin
	tmp := abs(x1-x2) + abs(y1-y2);
	if tmp = 3 then
	begin
		writeln(f,x1,' ',y1,' ',x2,' ',y2);
		_tmp := c[x1,y1];
		c[x1,y1] := c[x2,y2];
		c[x2,y2] := _tmp;
	end
	else
	begin
		for i := 1 to 8 do
			if ((x1 + X[i]) >= 0) and ((x1 + X[i]) < n) and ((y1 + Y[i]) >= 0) and ((y1 + Y[i]) < m) then
				if (abs((x1 + X[i]) - x2) + abs((y1 + Y[i]) - y2)) < tmp then
				begin
					writeln(f,x1,' ',y1,' ',x1 + X[i],' ',y1 + Y[i]);
					_tmp := c[x1,y1];
					c[x1,y1] := c[x1 + X[i],y1 + Y[i]];
					c[x1 + X[i],y1 + Y[i]] := _tmp;
					PrintWay(x1 + X[i],y1 + Y[i],x2,y2);
					break;
				end;
	end;
end;
procedure Process(u, v : Integer);
var
	i, j, tmp: Integer;
	stop : Boolean;
begin
	if (u = n) then
		close(f)
	else
		if (v = m) then
			Process(u+1,0)
		else
			if c[u,v] <> g[u,v] then
			begin
				for i := 0 to n-1 do
				begin
					stop := false;
					for j := 0 to m-1 do
						if g[i,j] = c[u,v] then
						begin
							stop := true;
							PrintWay(i,j,u,v);
							break;
						end;
					if stop then
						break;
				end;
				if stop then
						Process(0,0)
				else
					Process(u,v);
			end
			else
				Process(u,v+1);
end;
procedure Test();
var
	i, j: Integer;
begin
	for i := 0 to n-1 do
	begin
		for j := 0 to m-1 do 
			write(c[i,j],' ');
		writeln();
	end;
end;
begin
	Input;
	assign(f,LINK+OP);
	rewrite(f);
	Process(0,0);
	Test;
end.
