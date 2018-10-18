module guas.app;

import std.stdio;
import std.process;
import raylib;

import guas.meta;
import guas.render;
import guas.game.world;
import guas.resources;

void main() {
	writefln("guas [engine] v%s", VERSION);

    auto world = new World();
    auto renderer = new Renderer(world);

    // TODO: read an engine configuration file for resolution, etc.

    // resources
    Resources.setPath("res/");
    renderer.load();

    raylib.InitWindow(800, 600, "guas");
    while (!raylib.WindowShouldClose()) {
        raylib.BeginDrawing();

        renderer.render();

        raylib.EndDrawing();
    }
}
