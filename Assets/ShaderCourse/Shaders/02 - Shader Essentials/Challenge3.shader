//Create a shader that has only one property which is a texture. 
//This texture should colour the albedo. 
//To this texture, before applying it to the albedo apply the colour green. 

Shader "Holistic/02 - Shader Essentials/Challenge3" 
{
	Properties
	{
		_MainTex("Main Texture", 2D) = "white" {}
	}

	SubShader
	{
		CGPROGRAM
			#pragma surface surf Lambert

			sampler2D _MainTex;

			struct Input
			{
				float2 uv_MainTex;
			};

			void surf(Input IN, inout SurfaceOutput o)
			{
				float3 newColor = (tex2D(_MainTex, IN.uv_MainTex) * float3(0,1,0)).rgb;
				o.Albedo = newColor;
			}
		ENDCG
	}

	Fallback "Diffuse"
}
