/* ditherNn */
Texture2D src : register(t0);
Texture2D map : register(t1);
cbuffer constant0 : register(b0) {
  float3 col_sper;
  float bayer_sq;
  float sampling_mode;
  float dithering_mode;
};

float3 reduction(float3 color, float3 sperate_n, float sample) {
  float3 col_cvt = 255.0f * color;
  float3 col1 = floor(col_cvt/sperate_n);
  float3 color_block = (sample==0.0f) ? floor(255.0f/floor(255.0f/sperate_n-1.0f)) : sperate_n;
  float3 col2 = col1 * color_block / 255.0f;
  return col2;
}

float3 rgb2hsv(float3 c) {
  float4 K = float4(0.0f, -1.0f / 3.0f, 2.0f / 3.0f, -1.0f);
  float4 p = lerp(float4(c.bg, K.wz), float4(c.gb, K.xy), step(c.b, c.g));
  float4 q = lerp(float4(p.xyw, c.r), float4(c.r, p.yzx), step(p.x, c.r));

  float d = q.x - min(q.w, q.y);
  float e = 1.0e-10;
  return float3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

float3 hsv2rgb(float3 c) {
  float4 K = float4(1.0f, 2.0f / 3.0f, 1.0f / 3.0f, 3.0f);
  float3 p = abs(frac(c.xxx + K.xyz) * 6.0f - K.www);
  return c.z * lerp(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

float3 dithering(float3 color, float2 fpos, float bayer_sq2, float dither_md) {
  float2 mtx_id = fmod(floor(fpos), float2(bayer_sq2, bayer_sq2));
  float4 col_map = map.Load(int3(mtx_id, 0));
  float thres = 255.0 * col_map.x / (bayer_sq2*bayer_sq2);
  float3 col3 = step(float3(thres, thres, thres), color);
  float2 col_XY = dither_md*color.xy + step(dither_md,0.5f)*col3.xy;
  return float3(col_XY, col3.z);
}

float4 ditherNn(float4 pos : SV_Position) : SV_Target {
  float4 color = src.Load(int3(pos.xy, 0));
  float3 col_rdc = reduction(color.rgb, col_sper, sampling_mode);
  float3 col_1 = (dithering_mode==1.0f) ? rgb2hsv(col_rdc) : col_rdc;
  float3 col_dit = dithering(col_1, pos.xy, bayer_sq, dithering_mode);
  float3 col_2 = (dithering_mode==1.0f) ? hsv2rgb(col_dit) : col_dit;
  return float4(col_2, color.a);
}
