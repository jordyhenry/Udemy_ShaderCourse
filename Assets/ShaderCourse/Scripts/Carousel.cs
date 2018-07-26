using UnityEngine;
using UnityEngine.UI;
using System.Collections;

public class Carousel : MonoBehaviour 
{
	public Camera m_cam;
	public ExampleData[] m_objects;
	public float transitionTime = 1f;
	public AnimationCurve transitionCurve;
	public float rotateSpeed = 10f;
	
	[Header ("ANCHORS")]
	public Transform leftAnchor;
	public Transform centerAnchor;
	public Transform rightAnchor;

	[Header ("UI")]
	public Text titleText;
	public Text descriptionText;

	private int index = 0;
	private Transform currentObject = null;
	private Color currentBgColor;
	private bool canChange = true;
	
	private void Start() 
	{
		ActivateObject(index, true);
	}

	private void Update() 
	{
		if(Input.GetKeyDown(KeyCode.RightArrow)){
			index++;

			if(index >= m_objects.Length)
				index = 0;
			
			ActivateObject(index, true);
		}else if(Input.GetKeyDown(KeyCode.LeftArrow)){
			index--;

			if(index < 0)
				index = m_objects.Length - 1;
			
			ActivateObject(index, false);
		}

		if(currentObject != null)
			currentObject.transform.Rotate(Vector3.up * rotateSpeed * Time.deltaTime);
	}

	public void ActivateObject(int i, bool next)
	{
		if(canChange){
			titleText.text = m_objects[i].lessonTitle;
			descriptionText.text = m_objects[i].description;
			StartCoroutine(IEActivateObject(i, next));
		}
	}

	IEnumerator IEActivateObject(int i, bool next)
	{
		canChange = false;
		Vector3 startPos, endPos;
		if(next){
			startPos = rightAnchor.position;
			endPos = leftAnchor.position;
		}else{
			startPos = leftAnchor.position;
			endPos = rightAnchor.position;
		}

		ExampleData current = m_objects[i];
		current.transform.position = startPos;

		if(!current.gameObject.activeInHierarchy)
			current.gameObject.SetActive(true);
		
		float t=0;
		bool changeBgColor = (current.backgroundColor != m_cam.backgroundColor) ? true : false;
		Color startColor = m_cam.backgroundColor;
		do{
			t += Time.deltaTime;
			float percent = transitionCurve.Evaluate(t / transitionTime);

			if(changeBgColor)
				m_cam.backgroundColor = Color.Lerp(startColor, current.backgroundColor, percent);
			
			if(currentObject != null)
				currentObject.position = Vector3.Lerp(centerAnchor.position, endPos, percent);
			
			current.transform.position = Vector3.Lerp(startPos, centerAnchor.position, percent);

			yield return null;
		}while(t <= transitionTime);

		if(currentObject != null)
			currentObject.gameObject.SetActive(false);

		currentObject = current.transform;
		canChange = true;
	}
}
