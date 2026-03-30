from PIL import Image, ImageDraw, ImageFont
import os

ATLAS_PATH = "download.png"
OUTPUT_DIR = "extracted_spears"
GRID_PREVIEW_PATH = "atlas_grid_preview.png"

TILE_SIZE = 16

# Put your tile positions here as:
SPEAR_TILES = {
    "wooden_spear":  (35, 2),
    "stone_spear":   (33, 2),
    "iron_spear":    (56, 1),
    "golden_spear":  (53, 1),
    "diamond_spear": (50, 1),
}

# If True, trims away solid black border around the cropped tile
TRIM_BLACK_BORDER = True


# Helpers
def is_black(pixel):
    if isinstance(pixel, int):
        return pixel == 0
    if len(pixel) >= 3:
        return pixel[0] == 0 and pixel[1] == 0 and pixel[2] == 0
    return False


def trim_black(img):
    pixels = img.load()
    w, h = img.size

    min_x, min_y = w, h
    max_x, max_y = -1, -1

    for y in range(h):
        for x in range(w):
            if not is_black(pixels[x, y]):
                if x < min_x:
                    min_x = x
                if y < min_y:
                    min_y = y
                if x > max_x:
                    max_x = x
                if y > max_y:
                    max_y = y

    if max_x == -1 or max_y == -1:
        return img

    return img.crop((min_x, min_y, max_x + 1, max_y + 1))


def make_grid_preview(atlas, tile_size, out_path):
    preview = atlas.convert("RGB").copy()
    draw = ImageDraw.Draw(preview)

    width, height = preview.size
    tiles_x = width // tile_size
    tiles_y = height // tile_size

    try:
        font = ImageFont.load_default()
    except Exception:
        font = None

    # draw grid
    for x in range(0, width, tile_size):
        draw.line((x, 0, x, height), fill=(0, 255, 0))
    for y in range(0, height, tile_size):
        draw.line((0, y, width, y), fill=(0, 255, 0))

    # label tiles
    for ty in range(tiles_y):
        for tx in range(tiles_x):
            px = tx * tile_size + 1
            py = ty * tile_size + 1
            label = f"{tx},{ty}"
            draw.text((px, py), label, fill=(255, 0, 0), font=font)

    preview.save(out_path)
    print(f"[OK] Saved grid preview: {out_path}")


def crop_tile(atlas, tx, ty, tile_size):
    left = tx * tile_size
    top = ty * tile_size
    right = left + tile_size
    bottom = top + tile_size
    return atlas.crop((left, top, right, bottom))


# Main Function
def main():
    os.makedirs(OUTPUT_DIR, exist_ok=True)

    atlas = Image.open(ATLAS_PATH)
    width, height = atlas.size

    if width % TILE_SIZE != 0 or height % TILE_SIZE != 0:
        print("[WARN] Atlas size is not evenly divisible by TILE_SIZE.")
        print(f"       Atlas size: {width}x{height}, TILE_SIZE={TILE_SIZE}")

    make_grid_preview(atlas, TILE_SIZE, GRID_PREVIEW_PATH)

    for name, (tx, ty) in SPEAR_TILES.items():
        tile = crop_tile(atlas, tx, ty, TILE_SIZE)

        if TRIM_BLACK_BORDER:
            tile = trim_black(tile)

        out_path = os.path.join(OUTPUT_DIR, f"{name}.png")
        tile.save(out_path)
        print(f"[OK] Saved {name}: {out_path}  (tile {tx},{ty})")


if __name__ == "__main__":
    main()