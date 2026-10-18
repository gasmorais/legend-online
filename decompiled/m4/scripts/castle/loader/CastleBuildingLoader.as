package castle.loader
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentSetting;
   import flash.display.DisplayObject;
   import mvc.module.buildings.BuildInfo;
   
   public class CastleBuildingLoader
   {
      
      private var _info:BuildInfo;
      
      private var _callback:Function;
      
      private var _pathArray:Array;
      
      public function CastleBuildingLoader(param1:BuildInfo, param2:Function)
      {
         super();
         _info = param1;
         _callback = param2;
         _pathArray = _info.templeteInfo.PicPath.split("|");
         var _loc3_:String = ComponentSetting.RESOURCE_PATH + _pathArray[0];
         LoaderManagerII.instance.load(_loc3_,3,8,__onComplete);
      }
      
      private function __onComplete(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:Class = null;
         if(!_info)
         {
            return;
         }
         if(_pathArray.length > 1 && _pathArray[1] && ModuleLoader.hasDefinition(_pathArray[1]))
         {
            _loc3_ = ModuleLoader.getDefinition(_pathArray[1]);
            _info.templeteInfo.view = new _loc3_() as DisplayObject;
         }
         if(_pathArray.length > 2 && _pathArray[2] && ModuleLoader.hasDefinition(_pathArray[2]))
         {
            _loc3_ = ModuleLoader.getDefinition(_pathArray[2]);
            _info.templeteInfo.effect = new _loc3_() as DisplayObject;
         }
         _callback(_info.templateId);
         _callback = null;
         _info = null;
      }
   }
}

