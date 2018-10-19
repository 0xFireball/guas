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
    Terminal gui;

    this(Renderer renderer) {
        _renderer = renderer;
        screen = new Terminal(renderer, Point(40, 46));
        screen.cursorVisible = false;
        gui = new Terminal(renderer, Point(20, 46));
        mapSize = Point(20, 20);
    }

    void init() {
        TermFont font12x12 = TermFont(
            raylib.LoadTexture(Resources.path(R_FONT_12x12)),
            16, 12, 12
        );
        TermFont font8x12 = TermFont(
            raylib.LoadTexture(Resources.path(R_FONT_8x12)),
            16, 8, 12
        );
        // set up screen terminal
        screen.loadFont(font12x12);
        screen.init();
        screen.outline(GetColor(0x158e15ff));
        _renderer.addTerminal(screen, Vector2(16, 16));
        // set up gui terminal
        gui.loadFont(font8x12);
        gui.outline(GRAY);
        gui.init();
        _renderer.addTerminal(gui, Vector2(screen._bounds.x + screen._bounds.width + 8, screen._bounds.y));
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
        drawSidebar();
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

    private void drawSidebar() {
        Frame sidebar = new Frame(gui, Rect(0, 0, gui._dimens.x, gui._dimens.y));
        sidebar.outline(GRAY);
        sidebar.fill(DARKGRAY);
        gui.addFrame(sidebar);

        gui.setCursor(Point(sidebar.bounds.x, sidebar.bounds.y));
        gui.setColor(GREEN);
        gui.setBg(BLUE);
        gui.print("fake rogue.\n");
        gui.setBg(DARKGRAY);
        gui._cur.x = sidebar.bounds.x;
        gui.print("HP: [14 / 15]\n");
        gui._cur.x = sidebar.bounds.x;
        gui.print("STR: 8\n");
        gui._cur.x = sidebar.bounds.x;
        gui.print("INT: 12\n");
        gui._cur.x = sidebar.bounds.x;
        gui.print("PER: 10\n");
        gui._cur.x = sidebar.bounds.x;
        gui.print("DEX: 9\n");
    }

    private void drawField() {
        // draw screen
        Frame field = new Frame(screen, Rect(0, 0, 40, screen._dimens.y));
        field.outline(GREEN);
        field.fill(BLACK);
        screen.addFrame(field);
    }
}
