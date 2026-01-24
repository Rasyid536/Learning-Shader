Shader "BasicLearn/BasicTexturing"
{
    Properties
    {
        _BaseColor("BaseColor", Color) = (1, 1, 1, 1)
        _BaseTexture("Basic Texture", 2D) = "white" {}
    }

    SubShader
    {
        Tags 
        {
            "RenderPipeline" = "UniversalPipeline" 
            "RenderType" = "Opaque"
            "Queue" = "Geometry" 
        }

        pass 
        {
            HLSLPROGRAM

            #pragma vertex vert
            #pragma fragment frag
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            CBUFFER_START(UnityPerMaterial) // CBUFFER(constant buffer) Compatibility to SRP Batcher for minimize draw call
            float4 _BaseColor;
            float4 _BaseTexture_ST;
            CBUFFER_END

            TEXTURE2D(_BaseTexture); // This is the texture 
            SAMPLER(sampler_BaseTexture); // Texture Sampler to read the texture 

            struct Attributes
            {
                float4 positionOS : POSITION;
                float2 uv : TEXCOORD0;
            };
            struct v2f 
            {
                float4 positionCS : SV_POSITION;
                float2 uv : TEXCOORD0;
            };


            v2f vert(Attributes v)
            {
                v2f o = (v2f)0;

                o.positionCS = TransformObjectToHClip(v.positionOS.xyz);
                o.uv = TRANSFORM_TEX(v.uv, _BaseTexture);
                
                return o;
            }

            float4 frag(v2f i) : SV_TARGET
            {
                float4 textureColor = SAMPLE_TEXTURE2D(_BaseTexture, sampler_BaseTexture, i.uv);
                return textureColor * _BaseColor;
            }


            ENDHLSL
        }
    }
    
}
