using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public  class ChangeLighting : Editor {
    #region 常量
    #endregion
    #region  属性
    #endregion
    #region 字段
    #endregion
    #region 事件
    #endregion
    #region 方法
    #endregion
    #region Unity回调
    [MenuItem("自己的插件/关掉天空盒")]
    static void CloseSkyBox(){
        RenderSettings.skybox = null;
    }
    #endregion
    #region  事件回调
    #endregion
    #region 帮助方法
    #endregion
	
}
