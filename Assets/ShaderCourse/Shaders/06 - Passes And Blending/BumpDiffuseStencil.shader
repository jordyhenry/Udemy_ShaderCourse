Shader "Holistic/07 - Passes and Blending/BumpDiffuseStencil" 
{
	Properties {
		_Color("Color", Color) = (1,1,1,1)
		_myDiffuse("Diffuse", 2D) = "white" {}
		_myBump("Bump", 2D) = "bump" {}
		_mySlider("Bump Amount", Range(0,10)) = 1

		_SRef("Stencil Ref", Float) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)] _SComp("Stencil Comp", Float) = 8
		[Enum(UnityEngine.Rendering.StencilOp)] _SOp("Stencil Op", Float) = 2
  }
  SubShader {

  	Stencil
		{
			Ref[_SRef]
			Comp[_SComp]
			Pass[_SOp]
		}

    CGPROGRAM
      #pragma surface surf Lambert
      
      fixed4 _Color;
      sampler2D _myDiffuse;
      sampler2D _myBump;
      half _mySlider;

      struct Input {
        float2 uv_myDiffuse;
        float2 uv_myBump;
      };
      
      void surf (Input IN, inout SurfaceOutput o) {
        o.Albedo = (tex2D(_myDiffuse, IN.uv_myDiffuse)).rgb * _Color;
        o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump));
        o.Normal *= float3(_mySlider, _mySlider, 1);
      }
    ENDCG
  }
  Fallback "Diffuse"
}
