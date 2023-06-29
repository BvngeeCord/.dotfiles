//
// Example blue light filter shader.
//
// Path: ~/.config/hypr/shader/blue_light_filter.frag
// 

precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

void main() {

    vec4 pixColor = texture2D(tex, v_texcoord);

    pixColor[2] *= 1.00;

    gl_FragColor = pixColor;
}
