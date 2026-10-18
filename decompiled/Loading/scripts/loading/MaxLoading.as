package loading
{
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class MaxLoading extends Sprite
   {
      
      public static var loadingSusliks:Boolean;
      
      public static var showNetTips:Boolean;
      
      private static var _instance:MaxLoading;
      
      private const LABEL_CLEAR:int = 76;
      
      private const LABEL_OUT:int = 44;
      
      private var _loadingMc:MovieClip;
      
      private var _doctorFrame:DisplayObject;
      
      private var _noticeFrame:DisplayObject;
      
      private var _bgMovie:MovieClip;
      
      private var _backShape:Shape;
      
      private var _contentSp:Sprite;
      
      private var _loadingBg:Bitmap;
      
      private var _stage:Stage;
      
      private var _effectDoctor:IEffect;
      
      private var _effectDoctorTimeId:int;
      
      private var _effectNotice:IEffect;
      
      private var _effectNoticeTimeId:int;
      
      private var _currProgress:int;
      
      private var _preProgress:int = -1;
      
      private var _count:int;
      
      private var _pro:int;
      
      private var _logoMove:Bitmap;
      
      public function MaxLoading()
      {
         super();
         init();
      }
      
      public static function get Instance() : MaxLoading
      {
         if(_instance == null)
         {
            _instance = new MaxLoading();
         }
         return _instance;
      }
      
      private function init() : void
      {
         var _loc1_:String = null;
         _backShape = new Shape();
         _contentSp = new Sprite();
         _backShape.graphics.beginFill(0,1);
         _backShape.graphics.drawRect(-200,-200,1900,1300);
         _backShape.graphics.endFill();
         addChild(_backShape);
         addChild(_contentSp);
         if(!ModuleLoader.hasDefinition("asset.loading.MainLoadingAsset"))
         {
            _loc1_ = ComponentSetting.getUISourcePath("mainloading");
            LoaderManagerII.instance.load(_loc1_,3,8,__loadingCompleteHandler);
         }
         else
         {
            createLoadingMc();
         }
      }
      
      private function __loadingCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         createLoadingMc();
         show(_stage);
      }
      
      public function addBgToMc(param1:Object) : void
      {
         var _loc2_:Bitmap = null;
         if(_loadingMc && param1)
         {
            if(param1.bg)
            {
               _loc2_ = param1.bg as Bitmap;
               if(_loc2_.width > 1000 || _loc2_.width < 900 || _loc2_.height > 600 || _loc2_.height < 500)
               {
                  _loc2_ = ComponentFactory.Instance.creatBitmap(param1.url);
               }
               _loadingMc.maxLoadingBg.addChild(_loc2_);
            }
            else
            {
               _loc2_ = ComponentFactory.Instance.creatBitmap(param1.url);
               _loadingMc.maxLoadingBg.addChild(_loc2_);
            }
         }
      }
      
      private function createLoadingMc() : void
      {
         var _loc2_:Class = ModuleLoader.getDefinition("asset.loading.MainLoadingAsset") as Class;
         _loadingMc = new _loc2_() as MovieClip;
         _loadingMc.loadPro.selectable = false;
         _loadingMc.loadPro.mouseEnabled = false;
         _loadingMc.loadPro.mouseWheelEnabled = false;
         _loadingMc.childLoadPro.selectable = false;
         _loadingMc.childLoadPro.mouseEnabled = false;
         _loadingMc.childLoadPro.mouseWheelEnabled = false;
         _loadingMc.doctor.addEventListener("click",__doctorHandler);
         _loadingMc.notice.addEventListener("click",__noticeHandler);
         _loadingMc.notice.visible = false;
         setProgress(1);
         setItemLoaderInfo(0,"");
         if(!showNetTips && _loadingMc.netTips)
         {
            _loadingMc.netTips.visible = false;
         }
         var _loc1_:Class = ModuleLoader.getDefinition("asset.loading.bgMovie") as Class;
         _bgMovie = new _loc1_();
         _bgMovie.gotoAndPlay(1);
      }
      
      public function show(param1:Stage) : void
      {
         _stage = param1;
         if(!ModuleLoader.hasDefinition("asset.loading.MainLoadingAsset"))
         {
            return;
         }
         if(loadingSusliks)
         {
            _stage.addEventListener("mouseDown",__mouseDown);
            _stage.addEventListener("mouseUp",__mouseUp);
         }
         _contentSp.addChild(_loadingMc);
         _contentSp.x = (_stage.stageWidth - 1000) / 2;
         _contentSp.y = (_stage.stageHeight - 600) / 2;
         if(_logoMove)
         {
            _logoMove.x = _contentSp.x + 418;
            _logoMove.y = _contentSp.y + 14;
         }
         _bgMovie.x = _loadingMc.loadPro.x - 215;
         _bgMovie.y = _loadingMc.loadPro.y - 378;
         this.addEventListener("enterFrame",__enterFrameHandler);
         _stage.addChild(this);
      }
      
      private function __noticeHandler(param1:MouseEvent) : void
      {
         var _loc3_:Class = null;
         var _loc2_:String = null;
         __disposeDoctorHandler(null);
         if(_noticeFrame)
         {
            _noticeFrame.visible = true;
         }
         else if(ModuleLoader.hasDefinition("notice.NoticeStyle"))
         {
            _loc3_ = ModuleLoader.getDefinition("notice.NoticeStyle");
            if(_loc3_)
            {
               new _loc3_();
            }
            _noticeFrame = ComponentFactory.Instance.creatComponentByStylename("notice.NoticeFrame");
            _noticeFrame["load"]();
            _noticeFrame.addEventListener("dispose",__disposeNoticeHandler);
            _noticeFrame.addEventListener("min",__minNoticeHandler);
            addChild(_noticeFrame);
         }
         else
         {
            _loc2_ = ComponentSetting.getProjectSourcePath("18.png");
            LoaderManagerII.instance.load(_loc2_,3,8,__noticeLoadCompleteHandler);
         }
      }
      
      private function __noticeLoadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:Class = null;
         __disposeDoctorHandler(null);
         __disposeNoticeHandler(null);
         if(ModuleLoader.hasDefinition("notice.NoticeStyle"))
         {
            _loc3_ = ModuleLoader.getDefinition("notice.NoticeStyle");
            if(_loc3_)
            {
               new _loc3_();
            }
         }
         _noticeFrame = ComponentFactory.Instance.creatComponentByStylename("notice.NoticeFrame");
         _noticeFrame["load"]();
         _noticeFrame.addEventListener("dispose",__disposeNoticeHandler);
         _noticeFrame.addEventListener("min",__minNoticeHandler);
         addChild(_noticeFrame);
      }
      
      private function __doctorHandler(param1:MouseEvent) : void
      {
         var _loc3_:Class = null;
         var _loc2_:String = null;
         __disposeNoticeHandler(null);
         if(_doctorFrame)
         {
            _doctorFrame.visible = true;
         }
         else if(ModuleLoader.hasDefinition("doctor.DoctorStyle"))
         {
            _loc3_ = ModuleLoader.getDefinition("doctor.DoctorStyle");
            if(_loc3_)
            {
               new _loc3_();
            }
            _doctorFrame = ComponentFactory.Instance.creatComponentByStylename("doctor.DoctorFrame");
            _doctorFrame.addEventListener("dispose",__disposeDoctorHandler);
            _doctorFrame.addEventListener("min",__minDoctorHandler);
            addChild(_doctorFrame);
         }
         else
         {
            _loc2_ = ComponentSetting.getProjectSourcePath("18.png");
            LoaderManagerII.instance.load(_loc2_,3,8,__doctorLoadCompleteHandler);
         }
      }
      
      private function __doctorLoadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:Class = null;
         __disposeNoticeHandler(null);
         if(ModuleLoader.hasDefinition("doctor.DoctorStyle"))
         {
            _loc3_ = ModuleLoader.getDefinition("doctor.DoctorStyle");
            if(_loc3_)
            {
               new _loc3_();
            }
         }
         _doctorFrame = ComponentFactory.Instance.creatComponentByStylename("doctor.DoctorFrame");
         _doctorFrame.addEventListener("dispose",__disposeDoctorHandler);
         _doctorFrame.addEventListener("min",__minDoctorHandler);
         addChild(_doctorFrame);
      }
      
      private function __minDoctorHandler(param1:Event) : void
      {
         _doctorFrame.visible = false;
         _effectDoctor = EffectManager.Instance.creatEffect(3,_loadingMc.doctor,{
            "color":"gold",
            "speed":0.4,
            "blurWidth":10,
            "intensity":40,
            "strength":0.6
         });
         _effectDoctor.play();
         _effectDoctorTimeId = setTimeout(stopDoctorEffect,3000);
      }
      
      private function __minNoticeHandler(param1:Event) : void
      {
         _noticeFrame.visible = false;
         _effectNotice = EffectManager.Instance.creatEffect(3,_loadingMc.notice,{
            "color":"gold",
            "speed":0.4,
            "blurWidth":10,
            "intensity":40,
            "strength":0.6
         });
         _effectNotice.play();
         _effectNoticeTimeId = setTimeout(stopNoticeEffect,3000);
      }
      
      private function stopNoticeEffect() : void
      {
         clearTimeout(_effectNoticeTimeId);
         _effectNoticeTimeId = 0;
         _effectNotice.stop();
         _effectNotice.dispose();
         _effectNotice = null;
      }
      
      private function stopDoctorEffect() : void
      {
         clearTimeout(_effectDoctorTimeId);
         _effectDoctorTimeId = 0;
         _effectDoctor.stop();
         _effectDoctor.dispose();
         _effectDoctor = null;
      }
      
      private function __disposeNoticeHandler(param1:Event) : void
      {
         if(_noticeFrame)
         {
            _noticeFrame.removeEventListener("min",__minNoticeHandler);
            _noticeFrame.removeEventListener("dispose",__disposeNoticeHandler);
            ObjectUtils.disposeObject(_noticeFrame);
            _noticeFrame = null;
         }
      }
      
      private function __disposeDoctorHandler(param1:Event) : void
      {
         if(_doctorFrame)
         {
            _doctorFrame.removeEventListener("min",__minDoctorHandler);
            _doctorFrame.removeEventListener("dispose",__disposeDoctorHandler);
            ObjectUtils.disposeObject(_doctorFrame);
            _doctorFrame = null;
         }
      }
      
      private function __enterFrameHandler(param1:Event) : void
      {
         _contentSp.x = (_stage.stageWidth - 1000) / 2;
         _contentSp.y = (_stage.stageHeight - 600) / 2;
         if(_logoMove)
         {
            _logoMove.x = _contentSp.x + 418;
            _logoMove.y = _contentSp.y + 14;
         }
         _bgMovie.x = _loadingMc.loadPro.x - 215;
         _bgMovie.y = _loadingMc.loadPro.y - 378;
         if(_doctorFrame)
         {
            _doctorFrame.x = (_stage.stageWidth - 546) / 2 + 20;
            _doctorFrame.y = (_stage.stageHeight - 410) / 2;
         }
         if(_noticeFrame)
         {
            _noticeFrame.x = (_stage.stageWidth - 635) / 2 + 20;
            _noticeFrame.y = (_stage.stageHeight - 427) / 2;
         }
      }
      
      public function setProgress(param1:int) : void
      {
         if(!_loadingMc)
         {
            return;
         }
         _pro = param1;
         _loadingMc.progressBarMc.pro.gotoAndStop(_pro);
         _loadingMc.loadPro.text = "Progresso Total   " + _pro + "%";
      }
      
      public function setItemLoaderInfo(param1:Number, param2:String) : void
      {
         if(!_loadingMc)
         {
            return;
         }
         var _loc3_:int = param1 * 100;
         _loadingMc.childProgressBarMc.pro.gotoAndStop(_loc3_);
         if(param2)
         {
            _loadingMc.childLoadPro.text = param2 + "     Progresso" + _loc3_ + "%";
         }
         else
         {
            _loadingMc.childLoadPro.text = "     Progresso" + _loc3_ + "%";
         }
      }
      
      public function hide() : void
      {
         _currProgress = 1;
         this.removeEventListener("enterFrame",__enterFrameHandler);
         hideSusliksl();
         ObjectUtils.disposeObject(_backShape);
         _backShape = null;
         ObjectUtils.disposeObject(_contentSp);
         _contentSp = null;
         if(_loadingMc)
         {
            _loadingMc.doctor.removeEventListener("click",__doctorHandler);
            _loadingMc.notice.removeEventListener("click",__noticeHandler);
            _loadingMc.stop();
         }
         ObjectUtils.disposeViolentMc(_loadingMc);
         _loadingMc = null;
         ObjectUtils.disposeObject(_logoMove);
         _logoMove = null;
         ObjectUtils.disposeViolentMc(_bgMovie);
         _bgMovie = null;
         if(_doctorFrame)
         {
            ObjectUtils.disposeObject(_doctorFrame);
         }
         _doctorFrame = null;
         _stage = null;
         _instance = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function hideSusliksl() : void
      {
         if(loadingSusliks)
         {
            resetCursor();
         }
         if(_stage)
         {
            _stage.removeEventListener("mouseDown",__mouseDown);
         }
         if(_stage)
         {
            _stage.removeEventListener("mouseUp",__mouseUp);
         }
      }
      
      private function initStick() : void
      {
         if(ComponentSetting.isZhanQu)
         {
            _logoMove = ComponentFactory.Instance.creatBitmap("asset.loading.SlogoOld");
         }
         else if(ComponentSetting.is7road)
         {
            _logoMove = ComponentFactory.Instance.creatBitmap("asset.loading.SlogoOld");
         }
         else
         {
            _logoMove = ComponentFactory.Instance.creatBitmap("asset.loading.SlogoOld");
         }
      }
      
      private function frameUpdateView() : void
      {
      }
      
      private function growSusliks(param1:MovieClip, param2:int) : void
      {
         if(param1)
         {
            param1.x = Math.random() * _stage.stageWidth / 2 + _stage.stageWidth / 4;
            param1.y = Math.random() * _stage.stageHeight / 2 + _stage.stageHeight / 4;
            addChild(param1);
            param1.gotoAndPlay(1);
         }
         clearTimeout(param2);
      }
      
      private function __mouseDown(param1:MouseEvent) : void
      {
      }
      
      private function __mouseUp(param1:MouseEvent) : void
      {
      }
      
      public function resetCursor() : void
      {
      }
      
      private function showCursorByType() : void
      {
      }
   }
}

