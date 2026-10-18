package loading
{
   import asset.smallloading.RegisterLoadingMc;
   import asset.smallloading.RegisterLoadingMc2;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class RegisterLoading extends Sprite
   {
      
      private static var _instance:RegisterLoading;
      
      private var _loadingMc:MovieClip;
      
      public function RegisterLoading()
      {
         super();
         initView();
      }
      
      public static function get instance() : RegisterLoading
      {
         if(!_instance)
         {
            _instance = new RegisterLoading();
         }
         return _instance;
      }
      
      private function initView() : void
      {
         if(ComponentSetting.isZhanQu)
         {
            _loadingMc = new RegisterLoadingMc2();
            _loadingMc["bg1"].gotoAndStop(2);
            _loadingMc["bg2"].gotoAndStop(2);
         }
         else if(ComponentSetting.is7road)
         {
            _loadingMc = new RegisterLoadingMc2();
            _loadingMc["bg1"].gotoAndStop(1);
            _loadingMc["bg2"].gotoAndStop(1);
         }
         else
         {
            _loadingMc = new RegisterLoadingMc();
            _loadingMc["bg1"].gotoAndStop(1);
            _loadingMc["bg2"].gotoAndStop(1);
         }
         _loadingMc.mouseEnabled = false;
         _loadingMc.mouseChildren = false;
         progress = 1;
         addChild(_loadingMc);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,0,true,true,2);
      }
      
      public function hide() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function set progress(param1:int) : void
      {
         if(_loadingMc)
         {
            _loadingMc.gotoAndStop(param1);
         }
      }
      
      public function exit(param1:Function = null) : void
      {
         dispose();
         if(param1 != null)
         {
            param1();
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeViolentMc(_loadingMc);
         _loadingMc = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         _instance = null;
      }
   }
}

