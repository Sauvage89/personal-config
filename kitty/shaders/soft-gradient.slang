#language slang 2026

import kitty_custom_shader_types;

static const float SPEED = 0.08;
static const float STRENGTH = 0.70;

public float4
fragment_main(
    float4 color,
    KittyTextures t,
    KittyCustomShaderData d)
{
    float2 uv = t.pos;
    float time = d.timestamp * SPEED;

    // Palette
    float3 base   = float3(0.008, 0.005, 0.012);
    float3 sand   = float3(0.30, 0.12, 0.06);
    float3 violet = float3(0.18, 0.05, 0.30);
    float3 pink   = float3(0.45, 0.12, 0.25);

    // Vent
    float wind1 = sin(uv.y * 10.0 - time * 1.4);
    float wind2 = sin(uv.y * 22.0 - time * 2.0 + uv.x * 3.0);

    uv.x += wind1 * 0.035;
    uv.x += wind2 * 0.012;

    // Grandes zones
    float2 p1 = float2(
        0.20 + 0.18 * sin(time),
        0.70 + 0.12 * cos(time * 0.8)
    );

    float2 p2 = float2(
        0.75 + 0.15 * cos(time * 0.7),
        0.40 + 0.15 * sin(time * 0.9)
    );

    float2 p3 = float2(
        0.50 + 0.20 * sin(time * 0.5),
        0.15 + 0.10 * cos(time * 0.6)
    );

    float g1 = exp(-5.0 * dot(uv - p1, uv - p1));
    float g2 = exp(-4.0 * dot(uv - p2, uv - p2));
    float g3 = exp(-5.0 * dot(uv - p3, uv - p3));

    float3 bg = base;

    bg = lerp(bg, sand,   g1 * 0.55 * STRENGTH);
    bg = lerp(bg, violet, g2 * 0.50 * STRENGTH);
    bg = lerp(bg, pink,   g3 * 0.30 * STRENGTH);

    // Vagues
    float wave_phase =
        uv.y * 11.0
        + sin(uv.x * 4.0 - time * 0.8) * 1.5
        - time * 1.7;

    float wave = 0.5 + 0.5 * sin(wave_phase);
    float crest = pow(wave, 5.0);

    float detail =
        0.5 + 0.5 *
        sin(
            uv.y * 25.0
            - time * 2.4
            + sin(uv.x * 7.0) * 2.0
        );

    crest *= lerp(0.65, 1.0, detail);

    // Intensification
    bg += sand   * crest * 0.10 * STRENGTH;
    bg += violet * crest * 0.08 * STRENGTH;
    bg += pink   * crest * 0.06 * STRENGTH;

    // Masque du fond
    float delta = length(color.rgb - d.background.rgb);

    float background_mask =
        1.0 - smoothstep(0.01, 0.05, delta);

    color.rgb = lerp(color.rgb, bg, background_mask);

    return color;
}
