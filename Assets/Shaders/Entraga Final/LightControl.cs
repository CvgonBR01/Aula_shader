using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LightControl : MonoBehaviour
{
   public float speed = 1;
    private float angle = 0;
    public GameObject luz;
    // Start is called before the first frame update

    void MudarAngulo()
    {
        angle += speed;
        Quaternion rot = Quaternion.Euler(angle, 0, 100);
        luz.transform.rotation = rot;
    }

    void FixedUpdate()
    {
        MudarAngulo();
    }
    

}
