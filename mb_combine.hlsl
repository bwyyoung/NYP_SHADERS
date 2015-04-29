float blur;
sampler2D Target;
sampler2D Sum;

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
   float4 Render_Color = tex2D(Target, Input.uv);
   float4 Sum_Color = tex2D(Sum, Input.uv);

   Output.oColor = lerp(Render_Color, Sum_Color, blur);
   return Output.oColor;
}
