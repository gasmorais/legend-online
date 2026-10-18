package com.speedEngine.speedBones.display
{
   import com.speedEngine.speedBones.manager.RenderManager;
   import com.speedEngine.speedBones.model.QuadData;
   import com.speedEngine.speedBones.utils.speedBones_internal;
   
   use namespace speedBones_internal;
   
   public class Quad extends DisplayObject
   {
      
      private var _data:QuadData;
      
      public function Quad(param1:int, param2:int, param3:uint)
      {
         super();
         setUnScaleWidth(param1);
         setUnScaleWidth(param2);
         _data = RenderManager.instance.createQuadData();
         _displayData = _data;
         _data.setVertexData(param1,param2,param3);
         setSrcRect(_data.boundRect);
         setSrcTriangles(_data.triangles);
      }
      
      override public function render(param1:Number) : void
      {
         if(_data)
         {
            _data.writeController(_attributeBytes,_colorFilterBytes,_blurFilterBytes,_renderMode);
         }
      }
      
      public function get data() : QuadData
      {
         return _data;
      }
      
      public function set data(param1:QuadData) : void
      {
         _data = param1;
      }
   }
}

