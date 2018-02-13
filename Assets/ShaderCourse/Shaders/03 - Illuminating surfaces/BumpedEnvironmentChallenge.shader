//Create a shader that takes a normal map and a cube map. 
//The normal map is to be unwrapped onto the surface normals 
//and then multiplied by 0.3. 
//The cube map should be used to set the Albedo. 
//This will give a metallic reflective bump mapped surface.

Shader "Holistic/03 - Illuminating Surfaces/BumpedEnvironmentChallenge" 
{
	Properties {
		_myNormal("Normal Map", 2D) = "bump" {}
		_myCube("CubeMap", CUBE) = "white" {}
	}
	SubShader {
		CGPROGRAM
			#pragma surface surf Lambert

			sampler2D _myNormal;
			samplerCUBE _myCube;

			struct Input
			{
				float2 uv_myNormal;
				float3 worldRefl; INTERNAL_DATA
			};

			void surf(Input IN, inout SurfaceOutput o)
			{
				o.Normal = UnpackNormal(tex2D(_myNormal, IN.uv_myNormal)) * 0.3;
				o.Albedo = texCUBE(_myCube, WorldReflectionVector(IN, o.Normal)).rgb;
			}
		ENDCG
	}
	FallBack "Diffuse"
}
