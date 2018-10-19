module guas.samp.demorog;

import std.stdio;
import raylib;

import guas.render;
import guas.resources;
import guas.graphics.termfont;
import guas.math.point;
import guas.math.rect;
import guas.graphics.terminal;
import guas.graphics.frame;

class DemoRog {
    Renderer _renderer;

    int _counter = 0;
    Point mapSize;
    int[] map;
    Point playerPos;
    Terminal screen;
    // Terminal gui;

    this(Renderer renderer) {
        _renderer = renderer;
        screen = new Terminal(renderer, Point(60, 46));
        screen.cursorVisible = false;
        mapSize = Point(20, 20);
    }

    void init() {
        TermFont font = TermFont(
            raylib.LoadTexture(Resources.path(R_FONT_12x12)),
            16, 12, 12
        );
        screen.loadFont(font);
        screen.init();
        _renderer.addTerminal(screen, Vector2(16, 16));
        // set up map
        map = new int[mapSize.x * mapSize.y];
        map = [
            2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
            2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
            2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
            2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
            2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
            2, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 2,
            2, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 2,
            2, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 2,
            2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 2,
            2, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 2,
            2, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 2,
            2, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 2,
            2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 2,
            2, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 2,
            2, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 2,
            2, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 2,
            2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 2,
            2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
            2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
            2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
        ];
        playerPos = Point(7, 8);
    }

    pragma(inline):
    private int mapIndex(Point pos) {
        return pos.y * mapSize.x + pos.x;
    }

    void update() {
        screen.update();

        _counter++;

        Point newPos = playerPos;
        if (raylib.IsKeyPressed(KEY_J)) {
            newPos.y += 1;
        } else if (raylib.IsKeyPressed(KEY_K)) {
            newPos.y -= 1;
        } else if (raylib.IsKeyPressed(KEY_H)) {
            newPos.x -= 1;
        } else if (raylib.IsKeyPressed(KEY_L)) {
            newPos.x += 1;
        }
        // check if moveable
        int newPosTile = map[mapIndex(newPos)];
        if (newPosTile == 0) {
            playerPos = newPos;
        }

        draw();
    }

    /// draw to the terminal
    void draw() {
        // drawSidebar();
        drawField();

        // print field
        screen.setCursor(Point(0, 0));

        // draw the field
        for (int y = 0; y < mapSize.y; y++) {
            for (int x = 0; x < mapSize.x; x++) {
                screen.setColor(GREEN);
                screen.setBg(BLACK);
                int dch = map[mapIndex(Point(x, y))];
                switch (dch) {
                    case 0:
                        screen.print(".");
                        break;
                    case 1:
                        screen.print("\xDB");
                        break;
                    case 2:
                        screen.print("\xFE");
                        break;
                    default:
                        screen.print("?");
                        break;
                }
            }
            screen.print("\n");
        }

        // draw the player
        screen.setCursor(playerPos);
        screen.print("@");
    }

    // private void drawSidebar() {
    //     Frame sidebar = new Frame(this, Rect(44, 0, 16, screen._dimens.y));
    //     sidebar.outline(GRAY);
    //     sidebar.fill(DARKGRAY);
    //     screen.addFrame(sidebar);

    //     screen.setCursor(Point(sidebar.bounds.x, sidebar.bounds.y));
    //     screen.setColor(GREEN);
    //     screen.setBg(BLUE);
    //     screen.print("fake rogue.\n");
    //     screen.setBg(DARKGRAY);
    //     screen._cur.x = sidebar.bounds.x;
    //     screen.print("HP: [14 / 15]\n");
    //     screen._cur.x = sidebar.bounds.x;
    //     screen.print("STR: 8\n");
    //     screen._cur.x = sidebar.bounds.x;
    //     screen.print("INT: 12\n");
    //     screen._cur.x = sidebar.bounds.x;
    //     screen.print("PER: 10\n");
    //     screen._cur.x = sidebar.bounds.x;
    //     screen.print("DEX: 9\n");
    // }

    private void drawField() {
        // draw screen
        Frame field = new Frame(screen, Rect(0, 0, 44, screen._dimens.y));
        field.outline(GREEN);
        field.fill(BLACK);
        screen.addFrame(field);
    }
}
