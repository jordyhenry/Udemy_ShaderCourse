using System.Collections;
using UnityEngine;

public class Rotate : MonoBehaviour 
{

	public float rotVel=10;

	void Update () 
	{
		transform.Rotate(Vector3.up * Time.deltaTime * rotVel);
	}
}
