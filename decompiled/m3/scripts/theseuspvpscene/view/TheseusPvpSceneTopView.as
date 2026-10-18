package theseuspvpscene.view
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
   import managers.TheseusPvpManager;
   import mvc.module.theseuspvp.TheseusPvpModel;
   import mvc.module.theseuspvp.TheseusPvpSeasonInfo;
   import ui.maintoolbar.MainToolBar;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.TimerUtils;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class TheseusPvpSceneTopView extends Sprite
   {
      
      public var _sceneBg:Bitmap;
      
      public var _sceneTitle:Bitmap;
      
      public var _sceneLeftTimeTxt:FilterFrameText;
      
      private var _helpBtn:BaseButton;
      
      private var _currTimeDate:Date;
      
      public function TheseusPvpSceneTopView()
      {
         super();
         initView();
         refreshView();
         initEvent();
      }
      
      private function initView() : void
      {
         _sceneBg = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.sceneBg");
         _sceneTitle = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.sceneTitle");
         _sceneLeftTimeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.sceneLeftTimeTxt");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvpScene.helpBtn");
         addChild(_sceneBg);
         addChild(_sceneTitle);
         addChild(_sceneLeftTimeTxt);
         addChild(_helpBtn);
         TimerUtils.addSecendTimer("TIME",1,99999,setRemainTime);
      }
      
      private function refreshView() : void
      {
         var _loc1_:TheseusPvpSeasonInfo = model.seasonTimeInfo;
         _currTimeDate = DateFormatter.parse(_loc1_.closeDate,"YYYY-MM-DD hh:mm:ss");
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
            _sceneLeftTimeTxt.htmlText = LanguageMgr.GetTranslation("theseuspvp.timeEnd",DateFormatter.getFullTimeString(_loc1_));
         }
         else if(_loc1_ > 0)
         {
            _sceneLeftTimeTxt.htmlText = LanguageMgr.GetTranslation("theseuspvp.timeEnd",DateFormatter.getFullDateString(_loc1_));
         }
         else
         {
            _sceneLeftTimeTxt.text = LanguageMgr.GetTranslation("feedback.FeedBackItem.outDate");
            MainToolBar.instance.exitTheseusPvpGame(true,true);
         }
      }
      
      private function get model() : TheseusPvpModel
      {
         return TheseusPvpManager.Instance.model;
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
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.ScenehelpFrame");
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
      }
   }
}

