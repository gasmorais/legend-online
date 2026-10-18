package theseusDoublepvpscene.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleUpDownImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.RoomEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.RoomManager;
   import managers.TheseusPvpManager;
   import map.campaign.data.CampaignArmy;
   import mvc.module.room.RoomInfo;
   import mvc.module.theseusdoublepvp.TheseusDoublePvpModel;
   import mvc.module.theseusdoublepvp.TheseusDoublePvpRewardInfo;
   import mvc.module.theseusdoublepvp.TheseusDoublePvpSeasonInfo;
   import mvc.module.theseusdoublepvp.TheseusDoublePvpUserInfo;
   import ui.maintoolbar.MainToolBar;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.TheseusMultiPvpTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.TimerUtils;
   import yishi.view.base.ProgressPanel;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class TheseusRoomReadyTopView extends Sprite implements Disposeable
   {
      
      public var _sceneBg:Bitmap;
      
      public var _sceneTitle:Bitmap;
      
      public var _sceneLeftTimeTxt:FilterFrameText;
      
      private var _helpBtn:BaseButton;
      
      private var _currTimeDate:Date;
      
      private var back:ScaleUpDownImage;
      
      private var readyNumText:GradientText;
      
      private var _progress:Bitmap;
      
      private var _progressBg:Bitmap;
      
      private var _progressSp:Sprite;
      
      private var _itemArr:Array = [];
      
      public var _bottomTagright:Image;
      
      public var _bottomTagLeft:Image;
      
      public var _bottomNextStepTxt:FilterFrameText;
      
      public var _bottomProTxt:FilterFrameText;
      
      private var _progress1:ProgressPanel;
      
      private var _stepTxt:GradientText;
      
      private var _nowpro:int;
      
      private var _maxpro:int;
      
      public function TheseusRoomReadyTopView()
      {
         super();
         initView();
         refreshView1();
         addEvent();
         refreshView();
         TheseusPvpManager.Instance.doSomething1(13);
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("RoomReadyTopView.back1");
         readyNumText = ComponentFactory.Instance.creatComponentByStylename("RoomReadyTopView.readyNumText1");
         addChild(back);
         back.x = 115;
         back.height = 120;
         back.y = 140;
         addChild(readyNumText);
         _sceneBg = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.sceneBg");
         _sceneTitle = ComponentFactory.Instance.creatBitmap("asset.theseuspve.double.titleBg");
         _sceneLeftTimeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.sceneLeftTimeTxt");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvpScene.helpBtn");
         addChild(_sceneBg);
         addChild(_sceneTitle);
         addChild(_sceneLeftTimeTxt);
         addChild(_helpBtn);
         TimerUtils.addSecendTimer("TIME",1,99999,setRemainTime);
         _progressBg = ComponentFactory.Instance.creatBitmap("asset.ChristmasAnswerFrame.Progressbg");
         _progress = ComponentFactory.Instance.creatBitmap("asset.ChristmasAnswerFrame.Progress1");
         addChild(_progressBg);
         addChild(_progress);
         _progressBg.width = 450;
         _progress.width = 0;
         _progress.x = 491;
         _progressBg.x = 490;
         _progress.y = 81;
         _progressBg.y = 80;
         initItem();
         _bottomTagright = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.bottomTagright");
         _bottomTagLeft = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.bottomTagLeft");
         _bottomNextStepTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.bottomNextStepTxt");
         _bottomProTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.bottomProTxt");
         _stepTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.sceneBottomStepTxt");
         _progress1 = new ProgressPanel();
         _progress1.initView("asset.theseuspvp.bottomBarBg","asset.theseuspvp.bottomBar","ui.theseuspvp.bottomProTxt");
         _progress1.x = 109;
         _progress1.y = 212;
         _stepTxt.x = 174;
         _bottomNextStepTxt.x = 98;
         _bottomTagLeft.x = 127;
         _bottomTagright.x = 355;
         _progress1.x = 145;
         _stepTxt.y = 155;
         _bottomNextStepTxt.y = 192;
         _bottomTagLeft.y = _bottomTagright.y = 160;
         addChild(_bottomTagright);
         addChild(_bottomTagLeft);
         addChild(_bottomNextStepTxt);
         addChild(_bottomProTxt);
         addChild(_stepTxt);
         addChild(_progress1);
      }
      
      private function initItem() : void
      {
         var _loc4_:int = 0;
         var _loc1_:TheseusBoxItem = null;
         var _loc6_:Array = TempleteManager.instance.theseusMultiPvpTaskCate.getListByArea(1);
         var _loc7_:Number = 450;
         var _loc5_:Number = 455;
         var _loc3_:int = int(_loc6_[3].TaskNum);
         var _loc2_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < 4)
         {
            _loc1_ = new TheseusBoxItem(_loc4_ + 1);
            _loc2_ = int(_loc6_[_loc4_].TaskNum);
            _loc1_.x = _loc5_ + _loc7_ * (_loc2_ / _loc3_);
            _loc1_.y = 12;
            addChild(_loc1_);
            _loc1_.refreshView(_loc6_[_loc4_]);
            _itemArr.push(_loc1_);
            _loc4_++;
         }
         _maxpro = _loc6_[3].TaskNum;
      }
      
      private function get model() : TheseusDoublePvpModel
      {
         return TheseusPvpManager.Instance.model1;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
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
      
      private function refreshView1() : void
      {
         var _loc1_:TheseusMultiPvpTempInfo = null;
         var _loc4_:TheseusDoublePvpSeasonInfo = model.seasonTimeInfo;
         _currTimeDate = DateFormatter.parse(_loc4_.closeDate,"YYYY-MM-DD hh:mm:ss");
         setRemainTime();
         var _loc2_:TheseusDoublePvpUserInfo = model.selfUserInfo;
         var _loc3_:TheseusMultiPvpTempInfo = TempleteManager.instance.theseusMultiPvpTempCate.getTempById(_loc2_.pvpId);
         if(_loc3_)
         {
            _stepTxt.text = _loc3_.Name;
            _loc1_ = TempleteManager.instance.theseusMultiPvpTempCate.getTempByType(_loc3_.MainType,_loc3_.SonType + 1);
            if(_loc1_ == null)
            {
               _loc1_ = TempleteManager.instance.theseusMultiPvpTempCate.getTempByType(_loc3_.MainType + 1,1);
            }
            if(_loc1_)
            {
               _progress1.progressValue(_loc2_.integral,_loc1_.NeedIntegral);
               _bottomNextStepTxt.text = LanguageMgr.GetTranslation("theseuspvp.nextStep",_loc1_.Name);
            }
            else
            {
               _bottomNextStepTxt.text = "";
               _progress1.showMax();
               _progress1.setValueText(_loc2_.integral + "/" + _loc3_.NeedIntegral);
            }
         }
      }
      
      private function addEvent() : void
      {
         if(roomInfo)
         {
            roomInfo.addEventListener("UPDATE_ROOM_BASE_DATA",__updateRoomPlayerStateHandler);
            roomInfo.addEventListener("UPDATE_ROOM_PLAYER_DATA",__updateRoomPlayerStateHandler);
         }
         NotificationManager.instance.addEventListener("theseusDoublepvpRewardEvent",refreshBox);
         _helpBtn.addEventListener("click",_helpCilckHandler);
      }
      
      private function refreshBox(param1:NotificationEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Array = param1.data as Array;
         for each(var _loc5_:TheseusDoublePvpRewardInfo in _loc4_)
         {
            for each(var _loc2_:TheseusBoxItem in _itemArr)
            {
               if(_loc2_.data && _loc2_.data.templateId == _loc5_.templateId)
               {
                  _loc2_.data = _loc5_;
               }
               if(_loc5_.templateId == 1004)
               {
                  _nowpro = _loc5_.data;
                  _loc3_ = Math.floor(_nowpro / _maxpro * 448);
                  _progress.width = _loc3_;
               }
            }
         }
      }
      
      private function __updateRoomPlayerStateHandler(param1:RoomEvent) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         if(!roomInfo)
         {
            return;
         }
         var _loc2_:int = getReadyCount();
         var _loc1_:int = int(roomInfo.playerCount);
         readyNumText.text = "";
      }
      
      private function getReadyCount() : int
      {
         var _loc2_:int = 0;
         for each(var _loc1_:CampaignArmy in roomInfo.playerList)
         {
            if(_loc1_.userId != roomInfo.houseOwnerId)
            {
               if(_loc1_.roomState == 1)
               {
                  _loc2_++;
               }
            }
            else if(roomInfo.roomState == 2)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      private function removeEvent() : void
      {
         if(roomInfo)
         {
            roomInfo.removeEventListener("UPDATE_ROOM_BASE_DATA",__updateRoomPlayerStateHandler);
            roomInfo.removeEventListener("UPDATE_ROOM_PLAYER_DATA",__updateRoomPlayerStateHandler);
         }
         _helpBtn.removeEventListener("click",_helpCilckHandler);
         NotificationManager.instance.removeEventListener("theseusDoublepvpRewardEvent",refreshBox);
         TimerUtils.removeSecendTimer("TIME");
      }
      
      private function _helpCilckHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvpdouble.ScenehelpFrame");
         _loc2_.show();
      }
      
      private function get roomInfo() : RoomInfo
      {
         return RoomManager.instance.roomInfo;
      }
      
      public function resize(param1:int, param2:int) : void
      {
         this.x = (param1 - this.width) * 0.5 + 300 - 60;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(back)
         {
            ObjectUtils.disposeObject(back);
         }
         back = null;
         if(readyNumText)
         {
            ObjectUtils.disposeObject(readyNumText);
         }
         readyNumText = null;
         ObjectUtils.disposeObject(_sceneBg);
         _sceneBg = null;
         ObjectUtils.disposeObject(_sceneTitle);
         _sceneTitle = null;
         ObjectUtils.disposeObject(_sceneLeftTimeTxt);
         _sceneLeftTimeTxt = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_bottomTagLeft);
         _bottomTagLeft = null;
         ObjectUtils.disposeObject(_bottomNextStepTxt);
         _bottomNextStepTxt = null;
         ObjectUtils.disposeObject(_bottomProTxt);
         _bottomProTxt = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_progressBg);
         _progressBg = null;
         ObjectUtils.disposeObject(_progressSp);
         _progressSp = null;
         ObjectUtils.disposeObject(_bottomTagright);
         _bottomTagright = null;
         ObjectUtils.disposeObject(_progress1);
         _progress1 = null;
         ObjectUtils.disposeObject(_stepTxt);
         _stepTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

