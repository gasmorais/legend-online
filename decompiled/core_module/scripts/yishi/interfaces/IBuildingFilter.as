package yishi.interfaces
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.DisplayObject;
   
   public interface IBuildingFilter extends IFilterFormat, Disposeable
   {
      
      function setBuildingOverFilter(param1:DisplayObject) : void;
      
      function setBuildingOutFilter(param1:DisplayObject) : void;
      
      function setBuildingBuildingFilter(param1:DisplayObject) : void;
      
      function setBuildingFinishFilter(param1:DisplayObject) : void;
      
      function setLightFilter(param1:DisplayObject) : void;
      
      function setGlowFilter(param1:DisplayObject) : void;
   }
}

