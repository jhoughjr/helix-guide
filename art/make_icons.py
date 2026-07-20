#!/usr/bin/env python3
"""
Generate helix icon artwork and app icon assets.
Produces SVG masters and rasterized PNGs for iOS and macOS.
"""
import json
import math
import subprocess
import sys
from pathlib import Path


def round_2(x):
    """Round to 2 decimals."""
    return round(x, 2)


def generate_helix_artwork(width=1024, height=1024, clip_for_mac=False):
    """
    Generate SVG markup for the helix artwork.

    Args:
        width: canvas width
        height: canvas height
        clip_for_mac: if True, apply macOS squircle clipping

    Returns: SVG markup string
    """
    # Constants
    center_x = width / 2
    center_y = height / 2
    amplitude = 200
    y_start = 180
    y_end = 844
    helix_height = y_end - y_start
    period = 332  # exactly 2 full periods in helix_height

    # Sample the helix strands
    num_samples = 200
    strand_a_points = []
    strand_b_points = []

    for i in range(num_samples):
        y = y_start + (helix_height / (num_samples - 1)) * i
        # Strand A: x(y) = 512 + 200*sin(2*pi*(y-180)/332)
        angle = 2 * math.pi * (y - y_start) / period
        x_a = center_x + amplitude * math.sin(angle)
        x_b = center_x - amplitude * math.sin(angle)

        strand_a_points.append((round_2(x_a), round_2(y)))
        strand_b_points.append((round_2(x_b), round_2(y)))

    # Build the SVG
    svg_lines = []
    svg_lines.append('<?xml version="1.0" encoding="UTF-8"?>')
    svg_lines.append(f'<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="{width}" height="{height}" viewBox="0 0 {width} {height}">')

    # Define gradients
    svg_lines.append('<defs>')

    # Background gradient
    svg_lines.append(f'<linearGradient id="bgGrad" x1="0%" y1="0%" x2="0%" y2="100%">')
    svg_lines.append(f'<stop offset="0%" style="stop-color:#0F172A;stop-opacity:1" />')
    svg_lines.append(f'<stop offset="100%" style="stop-color:#1E293B;stop-opacity:1" />')
    svg_lines.append(f'</linearGradient>')

    # Strand A gradient (teal to cyan)
    svg_lines.append(f'<linearGradient id="strandAGrad" x1="0%" y1="0%" x2="0%" y2="100%">')
    svg_lines.append(f'<stop offset="0%" style="stop-color:#2DD4BF;stop-opacity:1" />')
    svg_lines.append(f'<stop offset="100%" style="stop-color:#22D3EE;stop-opacity:1" />')
    svg_lines.append(f'</linearGradient>')

    # Strand B gradient (purple to indigo)
    svg_lines.append(f'<linearGradient id="strandBGrad" x1="0%" y1="0%" x2="0%" y2="100%">')
    svg_lines.append(f'<stop offset="0%" style="stop-color:#A78BFA;stop-opacity:1" />')
    svg_lines.append(f'<stop offset="100%" style="stop-color:#818CF8;stop-opacity:1" />')
    svg_lines.append(f'</linearGradient>')

    if clip_for_mac:
        # macOS squircle clip path
        clip_size = 824
        clip_offset = 100
        clip_radius = 185
        svg_lines.append(f'<clipPath id="macClip">')
        svg_lines.append(f'<rect x="{clip_offset}" y="{clip_offset}" width="{clip_size}" height="{clip_size}" rx="{clip_radius}" ry="{clip_radius}" />')
        svg_lines.append(f'</clipPath>')

    svg_lines.append('</defs>')

    # Background
    svg_lines.append(f'<rect x="0" y="0" width="{width}" height="{height}" fill="url(#bgGrad)" />')

    if clip_for_mac:
        # For macOS, wrap everything in a group with the clip applied
        svg_lines.append(f'<g clip-path="url(#macClip)">')
        # Scale the entire artwork to fit in the clipped area
        # The artwork is 1024x1024, we want to fit it in 824x824 at offset 100,100
        # So scale = 824/1024 = 0.8046875
        svg_lines.append(f'<g transform="translate(100, 100) scale(0.8046875)">')

        # Background (for the clipped version, re-draw it scaled)
        svg_lines.append(f'<rect x="0" y="0" width="{width}" height="{height}" fill="url(#bgGrad)" />')

    # Draw rungs (before strands, so strands layer on top)
    for i in range(9):
        rung_y = y_start + i * 83
        angle = 2 * math.pi * (rung_y - y_start) / period
        x_a = center_x + amplitude * math.sin(angle)
        x_b = center_x - amplitude * math.sin(angle)
        svg_lines.append(f'<line x1="{round_2(x_a)}" y1="{rung_y}" x2="{round_2(x_b)}" y2="{rung_y}" stroke="#FFFFFF" stroke-width="20" stroke-linecap="round" opacity="0.32" />')

    # Draw Strand B (before Strand A, so A layers on top)
    path_b = "M " + " L ".join(f"{x} {y}" for x, y in strand_b_points)
    svg_lines.append(f'<path d="{path_b}" stroke="url(#strandBGrad)" stroke-width="46" stroke-linecap="round" fill="none" />')

    # Draw Strand A (on top)
    path_a = "M " + " L ".join(f"{x} {y}" for x, y in strand_a_points)
    svg_lines.append(f'<path d="{path_a}" stroke="url(#strandAGrad)" stroke-width="46" stroke-linecap="round" fill="none" />')

    if clip_for_mac:
        svg_lines.append(f'</g>')  # end scale group
        svg_lines.append(f'</g>')  # end clip group

    svg_lines.append('</svg>')

    return '\n'.join(svg_lines)


def render_svg_to_png(svg_path, png_path, width, height):
    """
    Render an SVG to PNG using rsvg-convert.

    Args:
        svg_path: path to input SVG
        png_path: path to output PNG
        width: output pixel width
        height: output pixel height
    """
    cmd = [
        '/opt/homebrew/bin/rsvg-convert',
        '-w', str(width),
        '-h', str(height),
        str(svg_path),
        '-o', str(png_path)
    ]
    result = subprocess.run(cmd, capture_output=True, text=True)
    if result.returncode != 0:
        print(f"ERROR rendering {svg_path}: {result.stderr}")
        sys.exit(1)


def main():
    repo_root = Path('/Users/jimmyhoughjr/repos/helix-guide')
    art_dir = repo_root / 'art'
    assets_dir = repo_root / 'hxguide' / 'Assets.xcassets' / 'AppIcon.appiconset'

    art_dir.mkdir(parents=True, exist_ok=True)
    assets_dir.mkdir(parents=True, exist_ok=True)

    # Step 1: Generate SVG masters
    icon_master_svg = art_dir / 'icon-master.svg'
    icon_mac_svg = art_dir / 'icon-mac.svg'

    print(f"Generating {icon_master_svg}...")
    icon_master_svg.write_text(generate_helix_artwork(clip_for_mac=False))

    print(f"Generating {icon_mac_svg}...")
    icon_mac_svg.write_text(generate_helix_artwork(clip_for_mac=True))

    # Step 2: Render iOS icon
    ios_png = assets_dir / 'icon-ios-1024.png'
    print(f"Rendering {ios_png}...")
    render_svg_to_png(icon_master_svg, ios_png, 1024, 1024)

    # Step 3: Render macOS icons
    mac_sizes = [
        (16, 'icon-mac-16.png'),
        (32, 'icon-mac-32.png'),
        (64, 'icon-mac-64.png'),
        (128, 'icon-mac-128.png'),
        (256, 'icon-mac-256.png'),
        (512, 'icon-mac-512.png'),
        (1024, 'icon-mac-1024.png'),
    ]

    mac_png_paths = {}
    for size, filename in mac_sizes:
        png_path = assets_dir / filename
        print(f"Rendering {png_path}...")
        render_svg_to_png(icon_mac_svg, png_path, size, size)
        mac_png_paths[size] = filename

    # Step 4: Generate Contents.json for AppIcon.appiconset
    contents = {
        "images": [
            {
                "filename": "icon-ios-1024.png",
                "idiom": "universal",
                "platform": "ios",
                "size": "1024x1024"
            }
        ],
        "info": {
            "author": "xcode",
            "version": 1
        }
    }

    # Add macOS icons
    # 16x16: @1x=16px, @2x=32px
    contents["images"].append({
        "filename": mac_png_paths[16],
        "idiom": "mac",
        "scale": "1x",
        "size": "16x16"
    })
    contents["images"].append({
        "filename": mac_png_paths[32],
        "idiom": "mac",
        "scale": "2x",
        "size": "16x16"
    })

    # 32x32: @1x=32px, @2x=64px
    contents["images"].append({
        "filename": mac_png_paths[32],
        "idiom": "mac",
        "scale": "1x",
        "size": "32x32"
    })
    contents["images"].append({
        "filename": mac_png_paths[64],
        "idiom": "mac",
        "scale": "2x",
        "size": "32x32"
    })

    # 128x128: @1x=128px, @2x=256px
    contents["images"].append({
        "filename": mac_png_paths[128],
        "idiom": "mac",
        "scale": "1x",
        "size": "128x128"
    })
    contents["images"].append({
        "filename": mac_png_paths[256],
        "idiom": "mac",
        "scale": "2x",
        "size": "128x128"
    })

    # 256x256: @1x=256px, @2x=512px
    contents["images"].append({
        "filename": mac_png_paths[256],
        "idiom": "mac",
        "scale": "1x",
        "size": "256x256"
    })
    contents["images"].append({
        "filename": mac_png_paths[512],
        "idiom": "mac",
        "scale": "2x",
        "size": "256x256"
    })

    # 512x512: @1x=512px, @2x=1024px
    contents["images"].append({
        "filename": mac_png_paths[512],
        "idiom": "mac",
        "scale": "1x",
        "size": "512x512"
    })
    contents["images"].append({
        "filename": mac_png_paths[1024],
        "idiom": "mac",
        "scale": "2x",
        "size": "512x512"
    })

    app_icon_json = assets_dir / 'Contents.json'
    print(f"Writing {app_icon_json}...")
    app_icon_json.write_text(json.dumps(contents, indent=2))

    # Step 5: Update AccentColor.colorset
    accent_color_dir = repo_root / 'hxguide' / 'Assets.xcassets' / 'AccentColor.colorset'
    accent_color_json = accent_color_dir / 'Contents.json'

    accent_contents = {
        "colors": [
            {
                "color": {
                    "color-space": "srgb",
                    "components": {
                        "alpha": "1.000",
                        "blue": "0.749",
                        "green": "0.831",
                        "red": "0.176"
                    }
                },
                "idiom": "universal"
            },
            {
                "appearances": [
                    {
                        "appearance": "luminosity",
                        "value": "dark"
                    }
                ],
                "color": {
                    "color-space": "srgb",
                    "components": {
                        "alpha": "1.000",
                        "blue": "0.749",
                        "green": "0.831",
                        "red": "0.176"
                    }
                },
                "idiom": "universal"
            }
        ],
        "info": {
            "author": "xcode",
            "version": 1
        }
    }

    print(f"Writing {accent_color_json}...")
    accent_color_json.write_text(json.dumps(accent_contents, indent=2))

    print("\nIcon generation complete!")


if __name__ == '__main__':
    main()
