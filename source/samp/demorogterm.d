module guas.samp.demorogterm;

import std.stdio;
import raylib;

import guas.render;
import guas.math.point;
import guas.math.rect;
import guas.graphics.terminal;
import guas.graphics.frame;

class DemoRogTerm : Terminal {
    int _counter = 0;
    Point mapSize;
    int[] map;
    Point playerPos;

    this(Renderer renderer) {
        super(renderer, Point(60, 46));
        mapSize = Point(20, 20);
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

    override void update() {
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
    }

    override void render() {
        super.render();

        drawSidebar();
        drawField();

        // print field
        this.setCursor(Point(0, 0));

        // draw the field
        for (int y = 0; y < mapSize.y; y++) {
            for (int x = 0; x < mapSize.x; x++) {
                this.setColor(GREEN);
                this.setBg(BLACK);
                int dch = map[mapIndex(Point(x, y))];
                switch (dch) {
                    case 0:
                        this.print(".");
                        break;
                    case 1:
                        this.print("\xDB");
                        break;
                    case 2:
                        this.print("\xFE");
                        break;
                    default:
                        this.print("?");
                        break;
                }
            }
            print("\n");
        }

        // draw the player
        this.setCursor(playerPos);
        this.print("@");
    }

    private void drawSidebar() {
        Frame sidebar = new Frame(this, Rect(44, 0, 16, this._dimens.y));
        sidebar.outline(GRAY);
        sidebar.fill(DARKGRAY);
        this.addFrame(sidebar);

        this.setCursor(Point(sidebar.bounds.x, sidebar.bounds.y));
        this.setColor(GREEN);
        this.setBg(BLUE);
        this.print("fake rogue.\n");
        this.setBg(DARKGRAY);
        this._cur.x = sidebar.bounds.x;
        this.print("HP: [14 / 15]\n");
        this._cur.x = sidebar.bounds.x;
        this.print("STR: 8\n");
        this._cur.x = sidebar.bounds.x;
        this.print("INT: 12\n");
        this._cur.x = sidebar.bounds.x;
        this.print("PER: 10\n");
        this._cur.x = sidebar.bounds.x;
        this.print("DEX: 9\n");
    }

    private void drawField() {
        // draw screen
        Frame field = new Frame(this, Rect(0, 0, 44, this._dimens.y));
        field.outline(GREEN);
        field.fill(BLACK);
        this.addFrame(field);
    }
}
