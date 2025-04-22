shader_type canvas_item;
render_mode unshaded;

uniform float strength : hint_range(0.0, 1.0) = 0.4;
uniform float speed : hint_range(0.0, 2.0) = 0.333;
uniform vec2 screen_resolution = vec2(1280.0, 720.0); 

void fragment() {
    float t = TIME * speed;
    vec3 col = vec3(0.0);
   
    vec2 pos = (UV - 0.5) * 2.0;
    

    pos.y *= (screen_resolution.y / screen_resolution.x);
    
    pos *= 4.0; 

    for (float k = 1.0; k < 7.0; k += 1.0) { 
        pos.x += strength * sin(2.0 * t + k * 1.5 * pos.y) + t * 0.5;
        pos.y += strength * cos(2.0 * t + k * 1.5 * pos.x);
    }

   
    col += 0.5 + 0.5 * cos(TIME + pos.xyx + vec3(0.0, 2.0, 4.0));


    col = pow(col, vec3(0.4545));

    // Set final output color (RGBA)
    COLOR = vec4(col, 1.0);
}
