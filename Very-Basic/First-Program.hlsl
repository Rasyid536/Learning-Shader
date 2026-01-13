Shader "BasicLearn/First" // First part of ShaderLab that define shader name
{
    Properties
    {
        _BaseColor("BaseColor", Color) = (1, 1, 1, 1) // Properties could be edited in the material inspector
    }
    SubShader
    {
        Tags 
        {
            "RenderPipeline" = "UniversalPipeline" // Mean that we're using Universal Render Pipeline
            "RenderType" = "Opaque" // Mean that our objects is opaque not transparent
            "Queue" = "Geometry" 
        }

        pass 
        {
            // HLSL Started here, outside this is ShaderLab
            HLSLPROGRAM

            #pragma vertex vert // Preprocessor directive to define vertex shader
            #pragma fragment frag // Preprocessor directive to define Fragment shader
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            float4 _BaseColor;
            struct Attributes
            {
                float4 positionOS : POSITION;
            };
            struct v2f 
            {
                float4 positionCS : SV_POSITION;
            };


            v2f vert(Attributes v) // Vertex Shader here
            {
                v2f o = (v2f)0;

                o.positionCS = TransformObjectToHClip(v.positionOS.xyz);

                return o;
            }

            float frag(v2f i) : SV_TARGET // Fragment Shader here
            {
                return _BaseColor;
            }
            ENDHLSL
            //HLSL ended here
        }
    }
    
}

