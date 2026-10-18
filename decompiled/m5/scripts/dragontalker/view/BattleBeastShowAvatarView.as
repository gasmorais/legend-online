package dragontalker.view
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import yishi.utils.MountAvatarPathHelper;
   
   public class BattleBeastShowAvatarView extends Component
   {
      
      private var _battleMountSkin:MovieClip;
      
      private var _isLoading:Boolean = false;
      
      public function BattleBeastShowAvatarView()
      {
         super();
         this.mouseChildren = this.mouseEnabled = false;
      }
      
      public function updateAvatarPath(param1:String) : void
      {
         clearLoading();
         var _loc2_:String = MountAvatarPathHelper.getBattleBesatPath(param1);
         LoaderManagerII.instance.load(_loc2_,2,4,onLoadCompleteHandler);
         _isLoading = true;
      }
      
      private function clearMC() : void
      {
         if(_battleMountSkin != null)
         {
            if(_battleMountSkin.parent != null)
            {
               _battleMountSkin.parent.removeChild(_battleMountSkin);
            }
            _battleMountSkin.stop();
            _battleMountSkin = null;
         }
      }
      
      private function clearLoading() : void
      {
         if(_isLoading)
         {
            LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(onLoadCompleteHandler);
            _isLoading = false;
         }
      }
      
      private function onLoadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         _isLoading = false;
         clearMC();
         if(param2)
         {
            _battleMountSkin = param2 as MovieClip;
            _battleMountSkin.play();
            addChild(_battleMountSkin);
         }
      }
      
      override public function dispose() : void
      {
         clearMC();
         clearLoading();
         ObjectUtils.disposeViolentMc(_battleMountSkin);
         _battleMountSkin = null;
         super.dispose();
      }
   }
}

