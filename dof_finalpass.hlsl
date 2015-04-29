float focus;
float range;
sampler2D Target;
sampler2D Blur1;
struct PS_INPUT
{
   float2 uv : TEXCOORD1;
};

struct PS_OUTPUT
{
   float4 oColor;
};

float4 ps_main(PS_INPUT Input) : COLOR0
{
   PS_OUTPUT Output;
   float4 sharp = tex2D(Target, Input.uv);
   float4 blur  = tex2D(Blur1, Input.uv);

   return lerp(sharp, blur, saturate(range * abs(focus - sharp.w)));
}


