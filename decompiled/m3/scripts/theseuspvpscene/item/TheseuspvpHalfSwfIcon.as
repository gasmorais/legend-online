package theseuspvpscene.item
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import yishi.manager.PathManager;
   
   public class TheseuspvpHalfSwfIcon extends Sprite
   {
      
      public function TheseuspvpHalfSwfIcon()
      {
         super();
      }
      
      public function set job(param1:int) : void
      {
         var _loc2_:String = PathManager.solveHeadPath(param1);
         LoaderManagerII.instance.load(_loc2_,2,8,onLoadComplete);
      }
      
      protected function onLoadComplete(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:DisplayObject = null;
         if(param2 is MovieClip)
         {
            _loc3_ = (param2 as MovieClip).getChildAt(0);
            (param2 as MovieClip).loaderInfo.loader.unloadAndStop(true);
            addChild(_loc3_);
            LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(onLoadComplete);
         }
      }
      
      public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(onLoadComplete);
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

