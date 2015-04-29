float sampleDist0;
sampler2D Target;

// Simple blur filter
const float2 samples[12] = {
   -0.326212, -0.405805,
   -0.840144, -0.073580,
   -0.695914,  0.457137,
   -0.203345,  0.620716,
    0.962340, -0.194983,
    0.473434, -0.480026,
    0.519456,  0.767022,
    0.185461, -0.893124,
    0.507431,  0.064425,
    0.896420,  0.412458,
   -0.321940, -0.932615,
   -0.791559, -0.597705,
};

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
   float4 sum = tex2D(Target, Input.uv);
   
   for (int i = 0; i < 12; i++)
   {
      sum += tex2D(Target, Input.uv + sampleDist0 * samples[i]);
   }
   
   Output.oColor = sum / 13;
   
   return Output.oColor;
}




