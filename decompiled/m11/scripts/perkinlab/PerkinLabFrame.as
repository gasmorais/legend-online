package perkinlab
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.PerkinLabEvent;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import mainBar.effects.MainToolBtnGlowEffect;
   import manager.LanguageMgr;
   import managers.MagicSpringManager;
   import managers.PerkinLabManager;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import mvc.module.perkinlab.PerkinLabModel;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.view.base.ProgressCommon;
   import yishi.view.community.MagicSpringBufferAddView;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class PerkinLabFrame extends Frame
   {
      
      private var back:Bitmap;
      
      private var border:Scale9CornerImage;
      
      private var expContiner:Component;
      
      private var expBack:MutipleImage;
      
      private var progressBar:ProgressCommon;
      
      private var lvlText:FilterFrameText;
      
      private var buildView:PerkinLabBuildView;
      
      private var robView:PerkinLabRobView;
      
      private var logBtn:BaseButton;
      
      private var helpBtn:BaseButton;
      
      private var robBtn:IconButton;
      
      private var selfBtn:BaseButton;
      
      private var _effect:MainToolBtnGlowEffect;
      
      private var _currentIndex:int = -1;
      
      private var _bufferView:MagicSpringBufferAddView;
      
      public function PerkinLabFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
         initBufferView();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatBitmap("asset.PerkinLabFrame.back");
         border = ComponentFactory.Instance.creatComponentByStylename("PerkinLabFrame.border");
         expContiner = ComponentFactory.Instance.creatComponentByStylename("PerkinLabFrame.expContiner");
         expBack = ComponentFactory.Instance.creatComponentByStylename("PerkinLabFrame.expBack");
         progressBar = ComponentFactory.Instance.creatComponentByStylename("PerkinLabFrame.progressBar");
         lvlText = ComponentFactory.Instance.creatComponentByStylename("PerkinLabFrame.lvlText");
         logBtn = ComponentFactory.Instance.creatComponentByStylename("PerkinLabFrame.logBtn");
         helpBtn = ComponentFactory.Instance.creatComponentByStylename("PerkinLabFrame.helpBtn");
         robBtn = ComponentFactory.Instance.creatComponentByStylename("PerkinLabFrame.robBtn");
         selfBtn = ComponentFactory.Instance.creatComponentByStylename("PerkinLabFrame.selfBtn");
         _effect = new MainToolBtnGlowEffect(robBtn);
         _effect.stop();
         addToContent(border);
         addToContent(back);
         addToContent(expContiner);
         addToContent(logBtn);
         addToContent(helpBtn);
         addToContent(robBtn);
         addToContent(selfBtn);
         expContiner.addChild(expBack);
         expContiner.addChild(lvlText);
         expContiner.addChild(progressBar);
      }
      
      private function initBufferView() : void
      {
         var _loc1_:String = null;
         var _loc2_:MagicSpringSlotInfo = MagicSpringManager.instance.model.checkIsExistBuffer(20);
         if(_loc2_)
         {
            _bufferView = new MagicSpringBufferAddView(_loc2_);
            _bufferView.stopTimer();
            _loc1_ = LanguageMgr.GetTranslation("home.perkinLabFrame.bufferText",_loc2_.tempInfo.AddValue);
            _bufferView.setDescText(_loc1_);
            _bufferView.x = 48;
            _bufferView.y = 95;
            addToContent(_bufferView);
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         logBtn.addEventListener("click",__logBtnClickHandler);
         helpBtn.addEventListener("click",__helpBtnClickHandler);
         robBtn.addEventListener("click",__viewChangeHandler);
         selfBtn.addEventListener("click",__viewChangeHandler);
         PerkinLabManager.instance.addEventListener("UPDATE_SELF_LIST",__updateSelfInfoView);
         NotificationManager.instance.addEventListener("PLAYER_EXTRA_FIELD",__updateCurExpHandler);
      }
      
      private function __logBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:PerkinLabEventFrame = ComponentFactory.Instance.creatComponentByStylename("PerkinLabFrame.PerkinLabEventFrame");
         _loc2_.show();
      }
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("PerkinLabFrame.PerkinHelpFrame");
         _loc2_.show();
      }
      
      private function __viewChangeHandler(param1:MouseEvent) : void
      {
         if(param1.target is BaseButton && param1.target.stylename == "PerkinLabFrame.selfBtn")
         {
            currentIndex = 0;
         }
         else if(param1.target is IconButton && param1.target.stylename == "PerkinLabFrame.robBtn")
         {
            currentIndex = 1;
         }
      }
      
      public function get currentIndex() : int
      {
         return _currentIndex;
      }
      
      public function set currentIndex(param1:int) : void
      {
         if(currentIndex == param1)
         {
            return;
         }
         _currentIndex = param1;
         _effect.stop();
         if(buildView)
         {
            ObjectUtils.disposeObject(buildView);
         }
         buildView = null;
         if(robView)
         {
            ObjectUtils.disposeObject(robView);
         }
         robView = null;
         if(currentIndex == 0)
         {
            buildView = ComponentFactory.Instance.creatCustomObject("PerkinLabFrame.buildView");
            addToContent(buildView);
            robBtn.visible = true;
            selfBtn.visible = false;
            if(_bufferView && _bufferView.parent)
            {
               _bufferView.resetTimer();
               _bufferView.visible = true;
            }
         }
         else
         {
            robView = ComponentFactory.Instance.creatCustomObject("PerkinLabFrame.robView");
            addToContent(robView);
            robBtn.visible = false;
            selfBtn.visible = true;
            if(_bufferView && _bufferView.parent)
            {
               _bufferView.stopTimer();
               _bufferView.visible = false;
            }
         }
      }
      
      private function __updateCurExpHandler(param1:NotificationEvent) : void
      {
         refreshView();
      }
      
      private function __updateSelfInfoView(param1:PerkinLabEvent) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc5_:Array = TempleteManager.instance.getGradeByAdd(134,model.curExp);
         var _loc2_:Boolean = _loc5_[0] == 1;
         var _loc3_:int = int(_loc5_[1]);
         var _loc4_:int = int(_loc5_[2]);
         var _loc1_:int = int(_loc5_[3]);
         lvlText.text = LanguageMgr.GetTranslation("public.level2",_loc3_);
         if(_loc2_)
         {
            progressBar.value = 1;
            progressBar.text = "Max";
         }
         else
         {
            progressBar.value = _loc4_ / _loc1_;
            progressBar.text = _loc4_ + "/" + _loc1_;
         }
         expContiner.tipData = 1;
      }
      
      public function show(param1:int = 0) : void
      {
         titleText = LanguageMgr.GetTranslation("perkinlab.PerkinLabFrame.titleText");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         currentIndex = param1;
         KeyBoardRegister.instance.keyEnable = false;
         setTaskMovie();
      }
      
      private function setTaskMovie() : void
      {
         if(PerkinLabManager.instance.model.taskValue == 208)
         {
            _effect.play();
            PerkinLabManager.instance.model.taskValue = 0;
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         logBtn.removeEventListener("click",__logBtnClickHandler);
         helpBtn.removeEventListener("click",__helpBtnClickHandler);
         robBtn.removeEventListener("click",__logBtnClickHandler);
         selfBtn.removeEventListener("click",__helpBtnClickHandler);
         PerkinLabManager.instance.removeEventListener("UPDATE_SELF_LIST",__updateSelfInfoView);
         NotificationManager.instance.removeEventListener("PLAYER_EXTRA_FIELD",__updateCurExpHandler);
      }
      
      private function get model() : PerkinLabModel
      {
         return PerkinLabManager.instance.model;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         PerkinLabManager.instance.model.taskValue = 0;
         removeEvent();
         if(back)
         {
            ObjectUtils.disposeObject(back);
         }
         back = null;
         if(border)
         {
            ObjectUtils.disposeObject(border);
         }
         border = null;
         if(logBtn)
         {
            ObjectUtils.disposeObject(logBtn);
         }
         logBtn = null;
         if(helpBtn)
         {
            ObjectUtils.disposeObject(helpBtn);
         }
         helpBtn = null;
         if(robBtn)
         {
            ObjectUtils.disposeObject(robBtn);
         }
         robBtn = null;
         if(selfBtn)
         {
            ObjectUtils.disposeObject(selfBtn);
         }
         selfBtn = null;
         if(buildView)
         {
            ObjectUtils.disposeObject(buildView);
         }
         buildView = null;
         if(robView)
         {
            ObjectUtils.disposeObject(robView);
         }
         robView = null;
         if(progressBar)
         {
            ObjectUtils.disposeObject(progressBar);
         }
         progressBar = null;
         if(expBack)
         {
            ObjectUtils.disposeObject(expBack);
         }
         expBack = null;
         if(lvlText)
         {
            ObjectUtils.disposeObject(lvlText);
         }
         lvlText = null;
         if(expContiner)
         {
            ObjectUtils.disposeObject(expContiner);
         }
         expContiner = null;
         if(_effect)
         {
            _effect.dispose();
         }
         _effect = null;
         if(_bufferView)
         {
            ObjectUtils.disposeObject(_bufferView);
         }
         _bufferView = null;
         super.dispose();
      }
   }
}

