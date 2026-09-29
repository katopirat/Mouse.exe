shader_type canvas_item;

// Těmito posuvníky v inspektoru nastavíte vzhled stolu
uniform float fov : hint_range(0.1, 2.0) = 0.8;
uniform float y_offset : hint_range(-1.0, 1.0) = 0.0;

void fragment() {
    // Upravíme vertikální souřadnici, aby se spodní část stolu roztahovala 
    // a horní (v dálce) zužovala
    float perspective = 1.0 + (UV.y + y_offset) * fov;
    
    vec2 target_uv = UV;
    target_uv.x = (target_uv.x - 0.5) * perspective + 0.5;

    // Vykreslíme výsledný stůl ze sloučené paměti CanvasGroupu
    if (target_uv.x >= 0.0 && target_uv.x <= 1.0) {
        COLOR = texture(TEXTURE, target_uv);
    } else {
        COLOR = vec4(0.0); // Prázdná místa okolo stolu budou průhledná
    }
}
