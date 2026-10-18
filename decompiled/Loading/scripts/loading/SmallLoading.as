package loading
{
   import asset.loading.LogoAsset;
   import asset.loading.LogoBgAsset;
   import asset.loading.SmallLoadingAsset;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   
   public class SmallLoading extends Sprite
   {
      
      private static var _instance:SmallLoading;
      
      private const LOADING_MIX_X:int = 205;
      
      private const LOADING_MIX_Y:int = 105;
      
      private var _loadingMc:MovieClip;
      
      private var _logoMc:MovieClip;
      
      private var _logoBgMc:MovieClip;
      
      private var _isShowLogo:Boolean = false;
      
      private var _hasInit:Boolean = false;
      
      private var _progressTimeId:int;
      
      private var _logoTimeId:uint;
      
      public function SmallLoading()
      {
         super();
      }
      
      public static function get Instance() : SmallLoading
      {
         if(_instance == null)
         {
            _instance = new SmallLoading();
         }
         return _instance;
      }
      
      private function init() : void
      {
         _hasInit = true;
         _loadingMc = new SmallLoadingAsset();
         _loadingMc.x = (StageReferance.stageWidth - _loadingMc.width) / 2 + 205;
         _loadingMc.y = (StageReferance.stageHeight - _loadingMc.height) / 2 + 105;
         _loadingMc["PercentageMc"]["txtPercent"].text = "1";
         if(_isShowLogo)
         {
            _logoBgMc = new LogoBgAsset() as MovieClip;
            _logoBgMc.mouseEnabled = _logoBgMc.mouseChildren = false;
            _logoBgMc.width = StageReferance.stageWidth;
            _logoBgMc.height = StageReferance.stageHeight;
            addChild(_logoBgMc);
            _logoMc = new LogoAsset() as MovieClip;
            _logoMc.mouseEnabled = _logoMc.mouseChildren = false;
            _logoMc.x = StageReferance.stageWidth * 0.5;
            _logoMc.y = StageReferance.stageHeight * 0.5;
            addChild(_logoMc);
            _logoMc.gotoAndPlay(1);
            showProressDealy = 7000;
         }
         else
         {
            addChild(_loadingMc);
         }
      }
      
      public function set showProressDealy(param1:Number) : void
      {
         _loadingMc["PercentageMc"].visible = false;
         if(_progressTimeId > 0)
         {
            clearInterval(_progressTimeId);
         }
         _progressTimeId = 0;
         if(param1 > 0)
         {
            _progressTimeId = setInterval(showProgress,param1);
         }
      }
      
      private function showProgress() : void
      {
         clearInterval(_progressTimeId);
         _loadingMc["PercentageMc"].visible = true;
         if(_isShowLogo)
         {
            addChild(_loadingMc);
         }
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         if(_loadingMc)
         {
            _loadingMc.x = (StageReferance.stageWidth - _loadingMc.width) / 2 + 205;
            _loadingMc.y = (StageReferance.stageHeight - _loadingMc.height) / 2 + 105;
         }
         if(_isShowLogo && _logoMc)
         {
            _logoMc.x = StageReferance.stageWidth * 0.5;
            _logoMc.y = StageReferance.stageHeight * 0.5;
         }
         if(_isShowLogo && _logoBgMc)
         {
            _logoBgMc.width = StageReferance.stageWidth;
            _logoBgMc.height = StageReferance.stageHeight;
         }
      }
      
      public function show(param1:Boolean = false) : void
      {
         _isShowLogo = param1;
         this.addEventListener("addedToStage",__addToStageHandler);
         StageReferance.stage.addChild(this);
      }
      
      private function __addToStageHandler(param1:Event) : void
      {
         this.removeEventListener("addedToStage",__addToStageHandler);
         if(!_hasInit)
         {
            init();
         }
         StageReferance.stage.addEventListener("resize",__resizeHandler);
      }
      
      public function set progress(param1:int) : void
      {
         if(!_loadingMc)
         {
            return;
         }
         _loadingMc["PercentageMc"]["txtPercent"].text = param1;
      }
      
      public function exit(param1:Function, param2:Object = null) : void
      {
         if(_isShowLogo && _logoMc)
         {
            callOnPlayOver(exitCall,param1,param2);
         }
         else
         {
            exitCall(param1,param2);
         }
      }
      
      private function callOnPlayOver(param1:Function, param2:Object = null, param3:Object = null) : void
      {
         if(!_logoMc)
         {
            param1(param2,param3);
            return;
         }
         var _loc4_:Number = (_logoMc.totalFrames - _logoMc.currentFrame) / StageReferance.stage.frameRate * 1000;
         clearInterval(_logoTimeId);
         _logoTimeId = setInterval(param1,_loc4_,param2,param3);
      }
      
      private function exitCall(param1:Function = null, param2:Object = null) : void
      {
         dispose();
         if(param1 != null)
         {
            param1(param2);
            param1 = null;
         }
      }
      
      public function dispose() : void
      {
         clearInterval(_progressTimeId);
         _progressTimeId = 0;
         clearInterval(_logoTimeId);
         _logoTimeId = 0;
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
         ObjectUtils.disposeObject(_logoMc);
         _logoMc = null;
         ObjectUtils.disposeObject(_logoBgMc);
         _logoBgMc = null;
         ObjectUtils.disposeObject(_loadingMc);
         _loadingMc = null;
         ObjectUtils.disposeObject(_logoBgMc);
         _logoBgMc = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

