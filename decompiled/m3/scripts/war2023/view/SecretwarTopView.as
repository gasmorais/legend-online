package war2023.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.Event;
   import mvc.module.war2023.info.SecretWarInfo;
   import mvc.module.war2023.info.SecretwarPlayInfo;
   import war2023.ui.SecretwarTopUI;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SecretWarManager;
   import yishi.utils.DateFormatter;
   
   public class SecretwarTopView extends SecretwarTopUI implements IEnterFrame
   {
      
      private var _selfPlayer:SecretwarPlayInfo;
      
      private var _info:SecretWarInfo;
      
      private var _currCd:int = -1;
      
      private var _lastBScore:int = 0;
      
      private var _lastRScore:int = 0;
      
      private var _txtList:Array = [];
      
      public function SecretwarTopView()
      {
         super();
         init();
         initEvent();
         resizeHandler();
      }
      
      private function init() : void
      {
         mouseEnabled = false;
         mouseChildren = false;
         _reiverFt.visible = false;
         _topriverTxt.visible = false;
         _selfPlayer = SecretWarManager.Instance.model.selfPlay;
         _info = SecretWarManager.Instance.model.warInfo;
         updateWarInfoHandler();
         updateTimeOverHandler();
         LayerManager.Instance.addToLayer(this,4);
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function enterFrame() : void
      {
         if(!_selfPlayer)
         {
            return;
         }
         if(_selfPlayer.state == 2)
         {
            _reiverFt.visible = true;
            _topriverTxt.visible = true;
            if(_currCd != _selfPlayer.cdTime)
            {
               _topriverTxt.text = DateFormatter.getCountDate(_selfPlayer.cdTime,2,2);
               _currCd = _selfPlayer.cdTime;
            }
         }
         else
         {
            _reiverFt.visible = false;
            _topriverTxt.visible = false;
         }
      }
      
      private function initEvent() : void
      {
         StageReferance.stage.addEventListener("resize",resizeHandler);
         NotificationManager.instance.addEventListener("secretwarUpdateWarEvent",updateWarInfoHandler);
         EnterFrameManager.instance.registeEnterFrame(this);
         playerModel.addEventListener("SYSTIME_UPGRADE_SECOND",updateTimeOverHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("secretwarUpdateWarEvent",updateWarInfoHandler);
         StageReferance.stage.removeEventListener("resize",resizeHandler);
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         playerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",updateTimeOverHandler);
      }
      
      private function updateTimeOverHandler(param1:Event = null) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Number = Number(playerModel.nowDate);
         if(_loc2_ < _info.preDate.time)
         {
            _timeCdTxt.text = DateFormatter.getCountDate(0,2,2);
         }
         else
         {
            _loc3_ = (_info.stopDate.time - _loc2_) / 1000;
            _timeCdTxt.text = DateFormatter.getCountDate(_loc3_,2,2);
         }
      }
      
      private function updateWarInfoHandler(param1:Event = null) : void
      {
         var _loc2_:SecretWarInfo = SecretWarManager.Instance.model.warInfo;
         _topLScoreTxt.text = "" + _loc2_.blueScore;
         if(_lastBScore > 0 && _lastBScore != _loc2_.blueScore)
         {
            playBtxt(_loc2_.blueScore - _lastBScore);
         }
         _lastBScore = _loc2_.blueScore;
         _topRScoreTxt.text = "" + _loc2_.redScore;
         if(_lastRScore > 0 && _lastRScore != _loc2_.redScore)
         {
            playRtxt(_loc2_.redScore - _lastRScore);
         }
         _lastRScore = _loc2_.redScore;
         _topLjdTxt.text = "" + _loc2_.blueNodeCount;
         _topRjdTxt.text = "" + _loc2_.redNodeCount;
         _topLpnTxt.text = "" + _loc2_.bluePlayerCount;
         _topRpnTxt.text = "" + _loc2_.redPlayerCount;
      }
      
      private function getEmptyTxtMc() : MovieClip
      {
         for each(var _loc2_:MovieClip in _txtList)
         {
            if(!_loc2_.parent)
            {
               return _loc2_;
            }
         }
         var _loc1_:MovieClip = ComponentFactory.Instance.creatCustomObject("asset.secretwar.flyTxt");
         _loc1_.gotoAndStop(1);
         _txtList.push(_loc1_);
         return _loc1_;
      }
      
      private function playBtxt(param1:int) : void
      {
         var _loc2_:MovieClip = getEmptyTxtMc();
         addChild(_loc2_);
         _loc2_.txtMc.txt.text = "+" + param1;
         _loc2_.gotoAndPlay(1);
         _loc2_.x = 117;
      }
      
      private function playRtxt(param1:int) : void
      {
         var _loc2_:MovieClip = getEmptyTxtMc();
         addChild(_loc2_);
         _loc2_.txtMc.txt.text = "+" + param1;
         _loc2_.gotoAndPlay(1);
         _loc2_.x = 305;
      }
      
      private function resizeHandler(param1:Event = null) : void
      {
         this.x = (StageReferance.stage.stageWidth - this.width) * 0.5;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:MovieClip in _txtList)
         {
            ObjectUtils.disposeViolentMc(_loc1_);
         }
         _txtList = null;
         super.dispose();
         _selfPlayer = null;
         _info = null;
      }
   }
}

