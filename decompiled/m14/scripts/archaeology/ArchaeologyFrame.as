package archaeology
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.archeology.ArchaeologyModel;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArchaeologyManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class ArchaeologyFrame extends Frame
   {
      
      private var expContiner:Component;
      
      private var expBar:MovieClip;
      
      private var expText:FilterFrameText;
      
      private var _helpBtn:BaseButton;
      
      private var makeView:ArchaeologyMakeView;
      
      public function ArchaeologyFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
         ArchaeologyManager.instance.sendArchaeologyRequest(2);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         expContiner = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyFrame.expContiner");
         expBar = ComponentFactory.Instance.creatCustomObject("ArchaeologyFrame.expBar");
         expText = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyFrame.expText");
         makeView = ComponentFactory.Instance.creatCustomObject("ArchaeologyFrame.makeView");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyFrame.HelpBtn");
         addToContent(_helpBtn);
         addToContent(expContiner);
         addToContent(makeView);
         expContiner.addChild(expBar);
         expContiner.addChild(expText);
         _helpBtn.tipData = LanguageMgr.GetTranslation("ArchaeologyFrame.helpBtn.TipData");
         expBar.gotoAndStop(1);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _helpBtn.addEventListener("click",__helpClick);
         NotificationManager.instance.addEventListener("PLAYER_EXTRA_FIELD",__updateExpHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _helpBtn.removeEventListener("click",__helpClick);
         NotificationManager.instance.removeEventListener("PLAYER_EXTRA_FIELD",__updateExpHandler);
      }
      
      private function __helpClick(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("ArchaeologyFrame.ArchaeologyHelpFrame");
         _loc2_.show();
      }
      
      private function __updateExpHandler(param1:NotificationEvent) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:String = null;
         var _loc5_:Array = TempleteManager.instance.getTemplatesByType(111);
         var _loc2_:int = int(model.getGradeByExp(model.exp));
         if(!_loc5_ || _loc5_.length <= 0)
         {
            return;
         }
         if(_loc2_ >= 5)
         {
            expText.text = LanguageMgr.GetTranslation("ArchaeologyFrame.levelText.text5");
            expBar.gotoAndStop(60);
         }
         else
         {
            _loc1_ = int(_loc5_[_loc2_].Data);
            _loc6_ = int(model.exp);
            _loc4_ = 1;
            while(_loc4_ < _loc2_)
            {
               _loc6_ -= _loc5_[_loc4_].Data;
               _loc4_++;
            }
            _loc3_ = LanguageMgr.GetTranslation("ArchaeologyFrame.levelText.text" + _loc2_);
            expText.text = LanguageMgr.GetTranslation("ArchaeologyFrame.expText.text",_loc3_,_loc6_,_loc1_);
            expBar.gotoAndStop(int(60 * _loc6_ / _loc1_));
         }
         if(model.getGradeRewardByLevel(_loc2_ + 1))
         {
            expContiner.tipStyle = "yishi.view.tips.ArchaeologyUpgradeRewardTips";
            expContiner.tipData = model.getGradeRewardByLevel(_loc2_ + 1);
         }
         else
         {
            expContiner.tipStyle = "yishi.view.tips.OneLineTip";
            expContiner.tipData = LanguageMgr.GetTranslation("ArchaeologyUpgradeRewardTips.maxLevel.alert");
         }
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
         titleText = LanguageMgr.GetTranslation("ArchaeologyFrame.titleText.text");
      }
      
      private function get model() : ArchaeologyModel
      {
         return ArchaeologyManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(makeView)
         {
            ObjectUtils.disposeObject(makeView);
         }
         makeView = null;
         if(expBar)
         {
            ObjectUtils.disposeViolentMc(expBar);
         }
         expBar = null;
         if(expText)
         {
            ObjectUtils.disposeObject(expText);
         }
         expText = null;
         if(expContiner)
         {
            ObjectUtils.disposeObject(expContiner);
         }
         expContiner = null;
         if(_helpBtn)
         {
            ObjectUtils.disposeObject(_helpBtn);
         }
         _helpBtn = null;
         super.dispose();
      }
   }
}

