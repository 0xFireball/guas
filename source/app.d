module guas.app;

import std.stdio;
import std.format;
import std.process;
import raylib;

import guas.meta;
import guas.render;
import guas.resources;
import guas.math.point;
import guas.graphics.terminal;

void main() {
	writefln("guas [engine] v%s", VERSION);

    auto renderer = new Renderer(Point(800, 600));

    // TODO: read an engine configuration file for resolution, etc.

    // resources
    Resources.setPath("res/");

    renderer.init();
    renderer.load();

    auto term = new Terminal(renderer, Point(60, 45));
    term.init();
    renderer.setTerminal(term);

    while (!raylib.WindowShouldClose()) {
        raylib.BeginDrawing();

        term.setColor(WHITE);
        term.setCursor(Point(2, 2));
        term.setColor(WHITE);
        term.print("guas ");
        term.setColor(GRAY);
        term.print("vterm ");
        term.setColor(GREEN);
        term.print("[engine]");

        renderer.render();

        raylib.EndDrawing();
    }
}
