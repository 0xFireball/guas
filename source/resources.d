module guas.resources;

import std.format;
import std.string : toStringz;

enum string R_FONT_8x12 = "font_8x12.png";
enum string R_FONT_12x12 = "font_12x12.png";

class Resources {
    static string _root;

    static void setPath(string path) {
        _root = path;
    }

    static immutable(char*) path(string resource) {
        return toStringz(format! "%s%s"(_root, resource));
    }
}
