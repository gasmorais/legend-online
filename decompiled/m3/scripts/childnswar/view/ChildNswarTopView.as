package childnswar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildNswarManager;
   import mvc.module.childnswar.ChildNswarModel;
   import mvc.module.childnswar.ChildNswarSeasonInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.TimerUtils;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class ChildNswarTopView extends Sprite
   {
      
      public var _sceneBg:Bitmap;
      
      public var _sceneTitle:Bitmap;
      
      public var _sceneLeftTimeTxt:FilterFrameText;
      
      private var _helpBtn:BaseButton;
      
      private var _currTimeDate:Date;
      
      private var _lanKey:String;
      
      private const StartKey:String = "childnswar.start.cd";
      
      private const EndKey:String = "theseuspvp.timeEnd";
      
      public function ChildNswarTopView()
      {
         super();
         initView();
         refreshView();
         initEvent();
      }
      
      private function initView() : void
      {
         _sceneBg = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.sceneBg");
         _sceneTitle = ComponentFactory.Instance.creatBitmap("asset.childnswar.topViewTitle");
         _sceneLeftTimeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.sceneLeftTimeTxt");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvpScene.helpBtn");
         _helpBtn.x = 445;
         addChild(_sceneBg);
         addChild(_sceneTitle);
         addChild(_sceneLeftTimeTxt);
         addChild(_helpBtn);
      }
      
      private function refreshView() : void
      {
         refreshCD();
         TimerUtils.addSecendTimer("TIME",1,99999,setRemainTime);
         setRemainTime();
      }
      
      private function refreshCD() : void
      {
         var _loc3_:ChildNswarSeasonInfo = model.seasonTimeInfo;
         _currTimeDate = DateFormatter.parse(_loc3_.seasonStartDate,"YYYY-MM-DD hh:mm:ss");
         var _loc1_:Number = Number(playerModel.sysCurTimeBySecond);
         var _loc2_:Number = _currTimeDate.time / 1000 - _loc1_;
         _lanKey = "childnswar.start.cd";
         if(_loc2_ < 0)
         {
            _lanKey = "theseuspvp.timeEnd";
            _currTimeDate = DateFormatter.parse(_loc3_.seasonStopDate,"YYYY-MM-DD hh:mm:ss");
         }
      }
      
      public function sesonChange() : void
      {
         refreshCD();
         setRemainTime();
      }
      
      public function setRemainTime() : void
      {
         if(_currTimeDate == null)
         {
            return;
         }
         var _loc1_:Number = _currTimeDate.time / 1000 - playerModel.sysCurTimeBySecond;
         if(_loc1_ >= 60)
         {
            _sceneLeftTimeTxt.htmlText = LanguageMgr.GetTranslation(_lanKey,DateFormatter.getFullTimeString(_loc1_));
         }
         else if(_loc1_ > 0)
         {
            _sceneLeftTimeTxt.htmlText = LanguageMgr.GetTranslation(_lanKey,DateFormatter.getFullDateString(_loc1_));
         }
         else if(_lanKey == "childnswar.start.cd")
         {
            refreshCD();
         }
         else
         {
            _sceneLeftTimeTxt.text = LanguageMgr.GetTranslation("childnswar.top.over");
         }
      }
      
      private function get model() : ChildNswarModel
      {
         return ChildNswarManager.Instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function initEvent() : void
      {
         _helpBtn.addEventListener("click",_helpCilckHandler);
      }
      
      private function removeEvent() : void
      {
         _helpBtn.removeEventListener("click",_helpCilckHandler);
         TimerUtils.removeSecendTimer("TIME");
      }
      
      private function _helpCilckHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("childnswar.ScenehelpFrame");
         _loc2_.show();
      }
      
      public function resize(param1:int, param2:int) : void
      {
         this.x = (param1 - this.width) * 0.5;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_sceneBg);
         _sceneBg = null;
         ObjectUtils.disposeObject(_sceneTitle);
         _sceneTitle = null;
         ObjectUtils.disposeObject(_sceneLeftTimeTxt);
         _sceneLeftTimeTxt = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _currTimeDate = null;
      }
   }
}

