sampler Target;

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
   Output.oColor = tex2D(Target, Input.uv);
   return Output.oColor;
}
