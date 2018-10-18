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

import guas.samp.welcometerm;

void main() {
	writefln("guas [engine] v%s", VERSION);

    auto renderer = new Renderer(Point(800, 600));

    // TODO: read an engine configuration file for resolution, etc.

    // resources
    Resources.setPath("res/");

    renderer.init();
    renderer.load();

    auto term = new WelcomeTerminal(renderer, Point(60, 45));
    term.init();
    renderer.setTerminal(term);

    while (!raylib.WindowShouldClose()) {
        term.update();

        raylib.BeginDrawing();
        renderer.render();
        raylib.EndDrawing();
    }
}
