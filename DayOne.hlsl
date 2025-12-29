Shader "Custom/UrpUnlit" {
    Properties{
        _BaseColor("Base Color", Color ) = (1, 1, 1, 1)
        _MainTex("Main Texture", 2D) = "white" {}
    }
    SubShader {
        Tags { "RenderPipeline" = "UniversalPipeline" 
        }
        Pass {
            Name "UnlitPass" 
            
            HLSLPROGRAM
            #pragma vertex vert 
            #pragma fragment frag
            
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            
            TEXTURE2D(_MainTex);
            SAMPLER(sampler_MainTex);

            CBUFFER_START(UnityPerMaterial)
            half4 _BaseColor;
            half4 _MainTex_ST;
            CBUFFER_END
            
            struct Attributes
            {
                float3 positionLS : POSITION;
                float2 uv : TEXCOORD0;
                float3 normalsLS : NORMAL; 
            };

            struct Varying
            {
                float4 positionCS : SV_POSITION;
                float2 uv : TEXCOORD0;
                float3 normalsWS : TEXCOORD1;
            };

            Varying vert(Attributes a) {
                Varying output;
                output.positionCS = TransformObjectToHClip(a.positionLS);
                output.uv = TRANSFORM_TEX(a.uv, _MainTex);
                output.normalsWS = TransformObjectToWorldNormal(a.normalsLS);
                return output;
            }

            half4 frag(Varying v) : SV_Target {
                half4 tex = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, v.uv);

                return _BaseColor * tex;
            }
            ENDHLSL
        }
    }
 
}




/*What i learn today
1. Basic Shader structure
2. How to apply uv, normal, and texture */
