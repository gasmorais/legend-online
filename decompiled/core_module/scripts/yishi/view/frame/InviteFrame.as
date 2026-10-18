package yishi.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import farm.FarmManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.RapidThroughPassManager;
   import managers.RoomSocketOutManager;
   import mvc.module.groupfb.GroupfbSender;
   import mvc.module.marry.MarrySender;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.BaseManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RoomListSocketOutManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.TimeDownView;
   
   public class InviteFrame extends Frame
   {
      
      private var _frameBack1:Scale9CornerImage;
      
      private var _frameBack2:Scale9CornerImage;
      
      private var _titleImg:Bitmap;
      
      private var _titleTxt:FilterFrameText;
      
      private var _time:TimeDownView;
      
      private var _content:FilterFrameText;
      
      private var _confirmBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      private var _closeBtn:BaseButton;
      
      public var roomType:int;
      
      private var _roomId:int;
      
      public var roomPwd:String;
      
      public var tempId:int;
      
      public var position:int;
      
      public var userKey:String;
      
      public var invidePlayerId:int;
      
      public var isCross:Boolean;
      
      private var _incomeBtn:SelectedCheckButton;
      
      public function InviteFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function set roomId(param1:int) : void
      {
         _roomId = param1;
      }
      
      private function initView() : void
      {
         _frameBack1 = ComponentFactory.Instance.creatComponentByStylename("core.InviteFrameBack1");
         _frameBack2 = ComponentFactory.Instance.creatComponentByStylename("core.InviteFrameBack2");
         _titleImg = ComponentFactory.Instance.creatBitmap("asset.core.invite.TitleBg");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("core.RoomInviteTitleText");
         _time = ComponentFactory.Instance.creatComponentByStylename("core.RoomInviteTime");
         _content = ComponentFactory.Instance.creatComponentByStylename("core.RoomInviteContent");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("core.RoomInviteConfirm");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("core.RoomInviteCancel");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("core.RoomInviteClose");
         _incomeBtn = ComponentFactory.Instance.creatComponentByStylename("core.useBindPointBtn");
         addToContent(_frameBack1);
         addToContent(_frameBack2);
         addToContent(_titleImg);
         addToContent(_titleTxt);
         addToContent(_time);
         addToContent(_content);
         addToContent(_confirmBtn);
         addToContent(_cancelBtn);
         addToContent(_closeBtn);
         addToContent(_incomeBtn);
         _incomeBtn.text = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.alertConent");
         _incomeBtn.visible = false;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _time.addEventListener("timerDown_complete",_timeCompleteHandler);
         _confirmBtn.addEventListener("click",__confirmHandler);
         _cancelBtn.addEventListener("click",__cancelHandler);
         _closeBtn.addEventListener("click",__cancelHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _time.removeEventListener("timerDown_complete",_timeCompleteHandler);
         _confirmBtn.removeEventListener("click",__confirmHandler);
         _cancelBtn.removeEventListener("click",__cancelHandler);
         _closeBtn.removeEventListener("click",__cancelHandler);
      }
      
      private function _timeCompleteHandler(param1:Event) : void
      {
         if(roomType == 100)
         {
            FarmManager.instance.respondInvide(invidePlayerId,false);
         }
         if(roomType == 3)
         {
            enterRapidThrough();
         }
         dispose();
      }
      
      private function confirmBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(isCross)
            {
               RoomSocketOutManager.sendInviteOther(roomId,!param2);
            }
            else
            {
               RoomListSocketOutManager.addRoomById(roomType,roomId,roomPwd,true,!param2);
            }
         }
      }
      
      private function enterRapidThrough() : void
      {
         var _loc2_:int = getRapidPassNum();
         var _loc1_:Boolean = _incomeBtn.selected;
         if(_loc2_ < 0)
         {
            _loc1_ = false;
         }
         RapidThroughPassManager.instance.createMolongCampaign(true,_loc1_);
      }
      
      private function __confirmHandler(param1:MouseEvent) : void
      {
         var _loc7_:String = null;
         var _loc5_:CampaignTemplate = null;
         var _loc4_:Boolean = false;
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc6_:String = LanguageMgr.GetTranslation("public.prompt");
         if(roomType == 4)
         {
            MarrySender.enterWeddingRoom(userKey,roomPwd);
            dispose();
            return;
         }
         if(roomType == 100)
         {
            FarmManager.instance.respondInvide(invidePlayerId,true);
            dispose();
            return;
         }
         if(roomType == 3)
         {
            enterRapidThrough();
            return;
         }
         if(roomType == 7)
         {
            GroupfbSender.enterGroup(roomId,"",true,!_incomeBtn.selected);
            dispose();
            return;
         }
         if(position == 1)
         {
            SimpleAlertHelper.instance.data = [confirmBack];
            _loc5_ = TempleteManager.instance.getCampaignTemplateById(tempId);
            if(_loc5_.isMolongCampaign)
            {
               _loc7_ = LanguageMgr.GetTranslation("chat.view.ChatView.EnterMolongCampaignTips");
            }
            else
            {
               _loc7_ = LanguageMgr.GetTranslation("chat.view.ChatView.EnterCampaignTips");
            }
            if(getIsOver())
            {
               SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc2_,_loc3_,true,true,false);
            }
            else
            {
               _loc4_ = _incomeBtn.selected;
               SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc2_,_loc3_,true,true,false,2,"CHATINVIE_ALERT",199,"",null,"SimpleAlert",{"income":_loc4_});
            }
            return;
         }
         if(roomType != 0 || !showThewAlert(send))
         {
            if(_incomeBtn.visible)
            {
               if(isCross)
               {
                  RoomSocketOutManager.sendInviteOther(roomId,!_incomeBtn.selected);
               }
               else
               {
                  RoomListSocketOutManager.addRoomById(roomType,roomId,roomPwd,true,!_incomeBtn.selected);
               }
            }
            else if(isCross)
            {
               RoomSocketOutManager.sendInviteOther(roomId,false);
            }
            else
            {
               RoomListSocketOutManager.addRoomById(roomType,roomId,roomPwd,true);
            }
         }
         dispose();
      }
      
      private function send(param1:Boolean) : void
      {
         SharedManager.instance.thewCheck = param1;
         SharedManager.instance.thewCheckDate = new Date();
         SharedManager.instance.saveThewCheck();
         if(isCross)
         {
            RoomSocketOutManager.sendInviteOther(roomId,false);
         }
         else
         {
            RoomListSocketOutManager.addRoomById(roomType,roomId,roomPwd,true);
         }
      }
      
      private function showThewAlert(param1:Function = null) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:String = null;
         if(roomType == 4)
         {
            return false;
         }
         var _loc2_:CampaignTemplate = TempleteManager.instance.getCampaignTemplateById(tempId);
         if(_loc2_ && _loc2_.isTrailTower)
         {
            _loc3_ = playerInfo.isTrailOverMaxCount;
            _loc4_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist09");
         }
         else if(_loc2_ && _loc2_.isBloodyPandemoniue)
         {
            _loc3_ = playerInfo.randomBossCount <= 0 ? true : false;
            _loc4_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist10");
         }
         else if(_loc2_ && _loc2_.isMolongCampaign)
         {
            _loc3_ = playerInfo.molongRestNum <= 0 ? true : false;
            _loc4_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist11");
         }
         else if(_loc2_ && _loc2_.isNaLan)
         {
            _loc3_ = playerInfo.teamCount <= 0 ? true : false;
            _loc4_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist12");
         }
         else if(_loc2_ && _loc2_.isTaila)
         {
            _loc3_ = playerInfo.tailaCount <= 0 ? true : false;
            _loc4_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist13");
         }
         else if(_loc2_ && _loc2_.isWasteCampaign)
         {
            _loc3_ = playerInfo.wasteCount <= 0 ? true : false;
            _loc4_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist14");
         }
         else if(_loc2_ && _loc2_.isFantasyMatrix)
         {
            _loc3_ = playerInfo.fantasyMatrixRestNum <= 0 ? true : false;
            _loc4_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist15");
         }
         else if(_loc2_ && _loc2_.isChildWarCampaign)
         {
            _loc3_ = playerInfo.childWarCount <= 0 ? true : false;
            _loc4_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist16");
         }
         else if(_loc2_ && _loc2_.isDeepPrison)
         {
            _loc3_ = playerInfo.deepPrisonCount <= 0 ? true : false;
            _loc4_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist20");
         }
         else if(_loc2_ && _loc2_.isDarkKing)
         {
            _loc3_ = playerInfo.darkKIngLeftCount <= 0 ? true : false;
            _loc4_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist21");
         }
         else if(_loc2_ && _loc2_.isRaceAgainstTime)
         {
            _loc3_ = playerInfo.raceAgainstTimeLeftCount <= 0 ? true : false;
            _loc4_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist22");
         }
         else if(_loc2_ && _loc2_.isForest)
         {
            _loc3_ = playerInfo.elementSilvaLeftCount <= 0 ? true : false;
            _loc4_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist23");
         }
         else if(_loc2_ && _loc2_.isSkyStepCampaign)
         {
            _loc3_ = playerInfo.skyStepCount <= 0 ? true : false;
            _loc4_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist24");
         }
         else
         {
            _loc3_ = playerInfo.multiCopyCount <= 0 ? true : false;
            _loc4_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist01");
         }
         return isAlert(_loc3_,param1,_loc4_);
      }
      
      private function isAlert(param1:Boolean, param2:Function, param3:String) : Boolean
      {
         var _loc10_:TodayNotAlertFrame = null;
         var _loc5_:String = null;
         var _loc6_:Boolean = param1;
         var _loc7_:Date = SharedManager.instance.thewCheckDate;
         var _loc8_:Date = new Date();
         var _loc4_:Boolean = false;
         var _loc9_:Boolean = SharedManager.instance.thewCheck;
         if(!_loc9_ || _loc7_.month <= _loc7_.month && _loc7_.date < _loc8_.date)
         {
            _loc4_ = true;
         }
         if(_loc6_ && _loc4_)
         {
            _loc10_ = ComponentFactory.Instance.creatComponentByStylename("core.TodayNotAlertFrame");
            _loc10_.containerY = 18;
            _loc5_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc10_.show(param3,_loc5_,param2);
         }
         return _loc6_ && _loc4_;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
               __confirmHandler(null);
         }
      }
      
      private function __cancelHandler(param1:MouseEvent) : void
      {
         if(roomType == 100)
         {
            FarmManager.instance.respondInvide(invidePlayerId,false);
         }
         dispose();
      }
      
      override public function set titleText(param1:String) : void
      {
         _titleTxt.text = param1;
      }
      
      public function set content(param1:String) : void
      {
         _content.htmlText = param1;
      }
      
      public function set time(param1:Number) : void
      {
         _time.timeCount = param1;
      }
      
      public function setPos(param1:int) : void
      {
         switch(param1)
         {
            case 0:
               _content.y = 35;
               if(getIsOver())
               {
                  hideIncomeBtn();
               }
               else
               {
                  showIncomeBtn();
               }
               break;
            case 3:
               _content.y = 35;
               _closeBtn.enable = false;
               _cancelBtn.enable = false;
               showIncomeBtn();
               _incomeBtn.selected = getRapidPassNum() > 0 ? true : false;
               _incomeBtn.enable = getRapidPassNum() > 0 ? true : false;
               break;
            case 4:
               _content.y = 39;
               hideIncomeBtn();
               break;
            case 5:
               _content.y = 35;
               break;
            case 7:
               _content.y = 35;
               showIncomeBtn();
         }
      }
      
      private function getRapidPassNum() : int
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo.rapidPassNum;
      }
      
      private function getIsOver() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:CampaignTemplate = TempleteManager.instance.getCampaignTemplateById(tempId);
         if(_loc2_ && _loc2_.isTrailTower)
         {
            _loc1_ = playerInfo.isTrailOverMaxCount;
         }
         else if(_loc2_ && _loc2_.isBloodyPandemoniue)
         {
            _loc1_ = playerInfo.randomBossCount <= 0 ? true : false;
         }
         else if(_loc2_ && _loc2_.isMolongCampaign)
         {
            _loc1_ = playerInfo.molongRestNum <= 0 ? true : false;
         }
         else if(_loc2_ && _loc2_.isNaLan)
         {
            _loc1_ = playerInfo.teamCount <= 0 ? true : false;
         }
         else if(_loc2_ && _loc2_.isTaila)
         {
            _loc1_ = playerInfo.tailaCount <= 0 ? true : false;
         }
         else if(_loc2_ && _loc2_.isWasteCampaign)
         {
            _loc1_ = playerInfo.wasteCount <= 0 ? true : false;
         }
         else if(_loc2_ && _loc2_.isFantasyMatrix)
         {
            _loc1_ = playerInfo.fantasyMatrixRestNum <= 0 ? true : false;
         }
         else if(_loc2_ && _loc2_.isChildWarCampaign)
         {
            _loc1_ = playerInfo.childWarCount <= 0 ? true : false;
         }
         else if(_loc2_ && _loc2_.isDeepPrison)
         {
            _loc1_ = playerInfo.deepPrisonCount <= 0 ? true : false;
         }
         else if(_loc2_ && _loc2_.isDarkKing)
         {
            _loc1_ = playerInfo.darkKIngLeftCount <= 0 ? true : false;
         }
         else if(_loc2_ && _loc2_.isRaceAgainstTime)
         {
            _loc1_ = playerInfo.raceAgainstTimeLeftCount <= 0 ? true : false;
         }
         else if(_loc2_ && _loc2_.isForest)
         {
            _loc1_ = playerInfo.elementSilvaLeftCount <= 0 ? true : false;
         }
         else if(_loc2_ && _loc2_.isSkyStepCampaign)
         {
            _loc1_ = playerInfo.skyStepCount <= 0 ? true : false;
         }
         else
         {
            _loc1_ = playerInfo.multiCopyCount <= 0 ? true : false;
         }
         return _loc1_;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function showIncomeBtn() : void
      {
         _incomeBtn.visible = true;
         _incomeBtn.x = 46;
         _incomeBtn.y = 78;
         _frameBack1.height = 150;
         _frameBack2.height = 144;
         _confirmBtn.y = 110;
         _cancelBtn.y = 110;
         _incomeBtn.selected = true;
      }
      
      private function hideIncomeBtn() : void
      {
         _incomeBtn.visible = false;
         _frameBack1.height = 130;
         _frameBack2.height = 124;
         _confirmBtn.y = 90;
         _cancelBtn.y = 90;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         BaseManager.instance.existRoomInvate = false;
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(_frameBack1)
         {
            _frameBack1.dispose();
         }
         _frameBack1 = null;
         if(_frameBack2)
         {
            _frameBack2.dispose();
         }
         _frameBack2 = null;
         _titleImg = null;
         if(_incomeBtn)
         {
            _incomeBtn.dispose();
         }
         _incomeBtn = null;
         if(_titleTxt)
         {
            _titleTxt.dispose();
         }
         _titleTxt = null;
         if(_closeBtn)
         {
            _closeBtn.dispose();
         }
         _closeBtn = null;
         if(_time)
         {
            ObjectUtils.disposeObject(_time);
         }
         _time = null;
         if(_content)
         {
            ObjectUtils.disposeObject(_content);
         }
         _content = null;
         if(_confirmBtn)
         {
            ObjectUtils.disposeObject(_confirmBtn);
         }
         _confirmBtn = null;
         if(_cancelBtn)
         {
            ObjectUtils.disposeObject(_cancelBtn);
         }
         _cancelBtn = null;
         super.dispose();
      }
   }
}

