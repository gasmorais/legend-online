package yishi.view.community
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.utils.MaskUtils;
   
   [Event(name="close",type="flash.events.Event")]
   public class LoadingSceneView extends Component
   {
      
      private static var _instance:LoadingSceneView;
      
      public var switchSceneFlag:Boolean;
      
      private var _loadingMc:MovieClip;
      
      private var _closeBtn:BaseButton;
      
      private var _closeCall:Function;
      
      private var _num:int;
      
      private var _showing:Boolean;
      
      public function LoadingSceneView()
      {
         super();
         initView();
         initEvent();
      }
      
      public static function get instance() : LoadingSceneView
      {
         if(!_instance)
         {
            _instance = new LoadingSceneView();
         }
         return _instance;
      }
      
      private function initView() : void
      {
         if(ComponentSetting.isZhanQu)
         {
            _loadingMc = ComponentFactory.Instance.creatCustomObject("core.loading.LoadingMapAsset.zhanqu");
            _loadingMc["bg1"].gotoAndStop(2);
            _loadingMc["bg2"].gotoAndStop(2);
         }
         else if(ComponentSetting.is7road)
         {
            _loadingMc = ComponentFactory.Instance.creatCustomObject("core.loading.LoadingMapAsset.zhanqu");
            _loadingMc["bg1"].gotoAndStop(1);
            _loadingMc["bg2"].gotoAndStop(1);
         }
         else
         {
            _loadingMc = ComponentFactory.Instance.creatCustomObject("core.loading.LoadingMapAsset.shenqu");
            _loadingMc["bg1"].gotoAndStop(1);
            _loadingMc["bg2"].gotoAndStop(1);
         }
         addChild(_loadingMc);
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("core.loadingCloseBtn");
      }
      
      private function initEvent() : void
      {
         _closeBtn.addEventListener("click",__closeViewHandler);
      }
      
      private function __closeViewHandler(param1:MouseEvent) : void
      {
         if(_closeCall != null)
         {
            _closeCall();
         }
         hide();
      }
      
      public function hide() : void
      {
         _showing = false;
         if(parent)
         {
            KeyBoardRegister.instance.keyEnable = true;
            _num = 0;
            parent.removeChild(this);
            dispatchEvent(new Event("close"));
         }
      }
      
      public function isShowing() : Boolean
      {
         return _showing;
      }
      
      public function show(param1:Boolean = false, param2:Function = null) : void
      {
         _showing = true;
         _closeCall = param2;
         if(!parent)
         {
            KeyBoardRegister.instance.keyEnable = false;
            MaskUtils.instance.battleDispose();
            if(_showing)
            {
               LayerManager.Instance.addToLayer(this,0,true,true,2);
            }
            update(1);
            if(param1)
            {
               addChild(_closeBtn);
            }
            else if(_closeBtn.parent)
            {
               _closeBtn.parent.removeChild(_closeBtn);
            }
         }
      }
      
      private function removeEvent() : void
      {
         if(_closeBtn)
         {
            _closeBtn.removeEventListener("click",__closeViewHandler);
         }
      }
      
      public function update(param1:Number) : void
      {
         var _loc2_:int = _num - param1;
         if(_loc2_ > 0 && _loc2_ < 8)
         {
            return;
         }
         _num = param1;
         param1 = param1 >= 100 ? 99 : param1;
         if(stage && _loadingMc)
         {
            _loadingMc.gotoAndStop(int(param1));
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         removeEvent();
         if(_loadingMc)
         {
            if(_loadingMc.loaderInfo)
            {
               _loadingMc.loaderInfo.loader.unload();
               _loadingMc.loaderInfo.loader.unloadAndStop(true);
            }
         }
         ObjectUtils.disposeViolentMc(_loadingMc);
         ObjectUtils.disposeObject(_closeBtn);
         if(_loadingMc)
         {
            _loadingMc.stop();
         }
         _loadingMc = null;
         _instance = null;
         _closeBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

