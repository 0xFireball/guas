module guas.math.point;

struct Point {
    int x;
    int y;

    Point opBinary(string op)(Point rhs)
    {
        static if (op == "+") return Point(x + rhs.x, y + rhs.y);
        else static if (op == "-") return Point(x - rhs.x, y - rhs.y);
        else static assert(0, "Operator "~op~" not implemented");
    }
}
