shader_type spatial; 
render_mode skip_vertex_transform, diffuse_lambert_wrap, ambient_light_disabled;

uniform vec4 color : hint_color;
uniform sampler2D albedoTex : hint_albedo;
uniform float specular_intensity : hint_range(0, 1);
uniform float resolution = 256;
uniform float cull_distance = 1000;
uniform vec2 uv_scale = vec2(1.0, 1.0);
uniform vec2 uv_offset = vec2(.0, .0);
uniform float uv_warp_intensity : hint_range(0, 1);

varying vec4 vertex_coordinates;
varying vec4 warped_vertex_coordinates;

void vertex() {
	UV = UV * uv_scale + uv_offset;
	
	float vertex_distance = length((MODELVIEW_MATRIX * vec4(VERTEX, 1.0)));
	
	VERTEX = (MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
	float vPos_w = (PROJECTION_MATRIX * vec4(VERTEX, 1.0)).w;
	VERTEX.xy = vPos_w * floor(resolution * VERTEX.xy / vPos_w) / resolution;
	vertex_coordinates = vec4(UV, 0, .0);
	warped_vertex_coordinates = vec4(UV * VERTEX.z, VERTEX.z, 0);
	
	if (vertex_distance > cull_distance)
		VERTEX = vec3(.0);
}

void fragment() {
	vec4 tex = texture(albedoTex, 
		mix(vertex_coordinates.xy, warped_vertex_coordinates.xy / warped_vertex_coordinates.z, uv_warp_intensity));
	
	ALBEDO = tex.rgb * color.rgb;
	SPECULAR = specular_intensity;
}