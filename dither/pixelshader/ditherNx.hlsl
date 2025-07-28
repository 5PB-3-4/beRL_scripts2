/* ditherNx */
Texture2D src : register(t0);
cbuffer constant0 : register(b0) {
  float3 col_sper;
  float sampling_mode;
};

float3 reduction(float3 color, float3 sperate_n, float sample) {
  float3 col_cvt = 255.0f * color;
  float3 col1 = floor(col_cvt/sperate_n);
  float3 color_block = (sample==0.0f) ? floor(255.0f/floor(255.0f/sperate_n-1.0f)) : sperate_n;
  float3 col2 = col1 * color_block / 255.0f;
  return col2;
}

float4 ditherNx(float4 pos : SV_Position) : SV_Target {
  float4 color = src.Load(int3(pos.xy, 0));
  float3 col_rdc = reduction(color.rgb, col_sper, sampling_mode); 
  return float4(col_rdc, color.a);
}
