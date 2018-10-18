module guas.app;

import std.stdio;
import std.process;
import raylib;

import guas.meta;
import guas.render;
import guas.game.world;
import guas.resources;
import guas.math.point;
import guas.graphics.terminal;

void main() {
	writefln("guas [engine] v%s", VERSION);

    auto world = new World();
    auto renderer = new Renderer(world, Point(800, 600));

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

        renderer.render();

        raylib.EndDrawing();
    }
}
