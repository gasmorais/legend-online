package consortia.view.myConsortia.contribution
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import consortia.net.ConsortiaSocektSendManager;
   import events.ConsortiaEvent;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.resource.ResourceData;
   import yishi.events.PlayerEvent;
   import yishi.events.ResourceEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaContributeFrame extends Frame
   {
      
      private var _bg:MutipleImage;
      
      private var _rightBg:ScaleBitmapImage;
      
      private var _leftBg:ScaleBitmapImage;
      
      private var _rankingTxt:FilterFrameText;
      
      private var _memberNameTxt:FilterFrameText;
      
      private var _resourceTxt:FilterFrameText;
      
      private var _selfSoulTxt:FilterFrameText;
      
      private var _selfContributeTxt:FilterFrameText;
      
      private var _selfAddTxt:FilterFrameText;
      
      private var _wealthTxt:FilterFrameText;
      
      private var _wealthAddTxt:FilterFrameText;
      
      private var _soulTxt:FilterFrameText;
      
      private var _soulAddTxt:FilterFrameText;
      
      private var _contributeBtn:SelectedButton;
      
      private var _currentGoldTxt:FilterFrameText;
      
      private var _inputGoldTxt:FilterFrameText;
      
      private var _contributeSoulBtn:SelectedButton;
      
      private var _currentSoulTxt:FilterFrameText;
      
      private var _inputSoulTxt:FilterFrameText;
      
      private var _contributePointBtn:SelectedButton;
      
      private var _currentPointTxt:FilterFrameText;
      
      private var _inputPointTxt:FilterFrameText;
      
      private var _selfInfoRan:FilterFrameText;
      
      private var _selfInfoName:FilterFrameText;
      
      private var _selfInfoCount:FilterFrameText;
      
      private var _selfInfoSoul:FilterFrameText;
      
      private var _contributeList:ContributeItemList;
      
      private var _data:ConsortiaModel;
      
      private var _focusInt:int;
      
      private var pointToOffer:int = 1;
      
      private var _isShow:Boolean = false;
      
      public function ConsortiaContributeFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _data = FrameControllerManager.instance.consortiaController.model;
         titleText = LanguageMgr.GetTranslation("consortia.view.myConsortia.contribution.ConsortiaContributeFrame.command01");
         _rightBg = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeFrameRightDescribeBackground");
         _leftBg = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeFrameLeftDescribeBackground");
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaContributeFrameBg");
         _rankingTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeFrameRankingTextStyle");
         _memberNameTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeFrameMemberNameTextStyle");
         _resourceTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeFrameResourceTextStyle");
         _selfSoulTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeFrameSelfSoulTextStyle");
         _selfContributeTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeFrameSelfGainTextStyle");
         _selfAddTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeFrameSelfAddTextStyle");
         _wealthTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeFrameContrubuteTextStyle");
         _wealthAddTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeFrameConsortiaAddTextStyle");
         _soulTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeFrameSoulTextStyle");
         _soulAddTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeFrameSoulAddTextStyle");
         _contributeSoulBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeFrameSoulContributeBtn");
         _currentSoulTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeFrameCurrentSoulTxt");
         _inputSoulTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeFrameContributeSoulTxt");
         _contributeBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeFrameContributeBtn");
         _currentGoldTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeFrameCurrentGoldTextStyle");
         _inputGoldTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeFrameGoldTextStyle");
         _contributePointBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeFramePointContributeBtn");
         _currentPointTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeFrameCurrentPointTextStyle");
         _inputPointTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeFramePointTextStyle");
         _contributeList = ComponentFactory.Instance.creatCustomObject("consortia.ContributeItemList");
         _selfInfoRan = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeSelfInfoRanTextStyle");
         _selfInfoName = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeSelfInfoNameTextStyle");
         _selfInfoCount = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeSelfInfoCountTextStyle");
         _selfInfoSoul = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeSelfInfoSoulTextStyle");
         addToContent(_rightBg);
         addToContent(_leftBg);
         addToContent(_bg);
         addToContent(_rankingTxt);
         addToContent(_memberNameTxt);
         addToContent(_resourceTxt);
         addToContent(_selfSoulTxt);
         addToContent(_selfContributeTxt);
         addToContent(_selfAddTxt);
         addToContent(_wealthTxt);
         addToContent(_wealthAddTxt);
         addToContent(_soulTxt);
         addToContent(_soulAddTxt);
         addToContent(_contributeBtn);
         addToContent(_currentGoldTxt);
         addToContent(_inputGoldTxt);
         addToContent(_contributeSoulBtn);
         addToContent(_currentSoulTxt);
         addToContent(_inputSoulTxt);
         addToContent(_contributePointBtn);
         addToContent(_currentPointTxt);
         addToContent(_inputPointTxt);
         addToContent(_contributeList);
         addToContent(_selfInfoRan);
         addToContent(_selfInfoName);
         addToContent(_selfInfoCount);
         addToContent(_selfInfoSoul);
         pointToOffer = int(TempleteManager.instance.getConfigInfoByConfigName("Point_ToOffer").ConfigValue);
         _rankingTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.contribution.ConsortiaContributeFrame.rankingTxtText");
         _memberNameTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.contribution.ConsortiaContributeFrame.memberNameTxtText");
         _resourceTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.contribution.ConsortiaContributeFrame.resourceTxtText");
         _selfSoulTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.contribution.ConsortiaContributeFrame.selfSoulText");
         _inputGoldTxt.text = "0";
         _inputSoulTxt.text = "0";
         _inputPointTxt.text = "0";
         _contributeBtn.tipData = LanguageMgr.GetTranslation("consortia.view.myConsortia.contribution.ConsortiaContributeFrame.contributePromptText1");
         _contributeSoulBtn.tipData = LanguageMgr.GetTranslation("consortia.view.myConsortia.contribution.ConsortiaContributeFrame.contributePromptText2");
         _contributePointBtn.tipData = LanguageMgr.GetTranslation("consortia.view.myConsortia.contribution.ConsortiaContributeFrame.contributePromptText3",pointToOffer) + "\n" + LanguageMgr.GetTranslation("consortia.view.myConsortia.contribution.ConsortiaContributeFrame.useBindPoint");
         _wealthTxt.text = _data.consortiaInfo.offer + "";
         _selfContributeTxt.text = playerInfo.consortiaOffer + "";
         _soulTxt.text = _data.emeDreamInfo.spirit + "";
         _selfContributeTxt.width = _selfContributeTxt.textWidth + 10;
         _wealthTxt.width = _wealthTxt.textWidth + 10;
         _soulTxt.width = _soulTxt.textWidth + 10;
         _currentGoldTxt.text = consortiaTxtStyle(gold.count + "");
         _currentSoulTxt.text = consortiaTxtStyle(playerInfo.strategy + "");
         _currentPointTxt.text = consortiaTxtStyle(playerInfo.point + playerInfo.giftToken + "");
         refreshPosition();
      }
      
      private function uninit() : void
      {
         _contributeBtn = null;
         _data = null;
         _inputGoldTxt = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function addEvent() : void
      {
         addEventListener("addedToStage",__onAddedToStage);
         addEventListener("response",__frameResponse);
         _contributeSoulBtn.addEventListener("click",__onSoulBtnHnadler);
         _contributeSoulBtn.addEventListener("rollOver",__onSoulBtnOver);
         _contributeSoulBtn.addEventListener("rollOut",__onSoulBtnOut);
         _inputSoulTxt.addEventListener("change",__onSoulTxtChangHandler);
         _inputSoulTxt.addEventListener("keyFocusChange",__onSoulFocusHandler);
         _inputSoulTxt.addEventListener("mouseFocusChange",__onSoulFocusHandler);
         _inputSoulTxt.addEventListener("mouseDown",__onContributeSoulDown);
         _contributeBtn.addEventListener("click",__onContributeHnadler);
         _contributeBtn.addEventListener("rollOver",__onContributeOver);
         _contributeBtn.addEventListener("rollOut",__onContributeOut);
         _inputGoldTxt.addEventListener("change",__onContributeTxtChangHandler);
         _inputGoldTxt.addEventListener("keyFocusChange",__onContributeGoldFocus);
         _inputGoldTxt.addEventListener("mouseFocusChange",__onContributeGoldFocus);
         _inputGoldTxt.addEventListener("mouseDown",__onContributeGoldDown);
         _contributePointBtn.addEventListener("click",__onPointContributeHnadler);
         _contributePointBtn.addEventListener("rollOver",__onPointContributeOver);
         _contributePointBtn.addEventListener("rollOut",__onPointContributeOut);
         _inputPointTxt.addEventListener("keyDown",__onPointKeydownHandler);
         _inputPointTxt.addEventListener("change",__onContributeTxtPointChangHandler);
         _inputPointTxt.addEventListener("keyFocusChange",__onContributePointFocus);
         _inputPointTxt.addEventListener("mouseFocusChange",__onContributePointFocus);
         _inputPointTxt.addEventListener("mouseDown",__onContributePointDown);
         gold.addEventListener(ResourceEvent.RESOURCE_UPDATE,__refreshGold);
         _data.addEventListener("UPDA_CONSORTIA_INFO",__onConsortiaInfoUpdata);
         _data.addEventListener("UPDA_CONSORTIA_CONTRIBUTE_INFO",__onContributeInfoUpdata);
         playerInfo.addEventListener("PLAYER_INFO_UPDATE",__playerInfoUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("addedToStage",__onAddedToStage);
         removeEventListener("response",__frameResponse);
         _contributeSoulBtn.removeEventListener("click",__onSoulBtnHnadler);
         _contributeSoulBtn.removeEventListener("rollOver",__onSoulBtnOver);
         _contributeSoulBtn.removeEventListener("rollOut",__onSoulBtnOut);
         _inputSoulTxt.removeEventListener("change",__onSoulTxtChangHandler);
         _inputSoulTxt.removeEventListener("keyFocusChange",__onSoulFocusHandler);
         _inputSoulTxt.removeEventListener("mouseFocusChange",__onSoulFocusHandler);
         _inputSoulTxt.removeEventListener("mouseDown",__onContributeSoulDown);
         _contributeBtn.removeEventListener("click",__onContributeHnadler);
         _contributeBtn.removeEventListener("rollOver",__onContributeOver);
         _contributeBtn.removeEventListener("rollOut",__onContributeOut);
         _inputGoldTxt.removeEventListener("change",__onContributeTxtChangHandler);
         _inputGoldTxt.removeEventListener("keyFocusChange",__onContributeGoldFocus);
         _inputGoldTxt.removeEventListener("mouseFocusChange",__onContributeGoldFocus);
         _inputGoldTxt.removeEventListener("mouseDown",__onContributeGoldDown);
         _contributePointBtn.removeEventListener("click",__onPointContributeHnadler);
         _contributePointBtn.removeEventListener("rollOver",__onPointContributeOver);
         _contributePointBtn.removeEventListener("rollOut",__onPointContributeOut);
         _inputPointTxt.removeEventListener("keyDown",__onPointKeydownHandler);
         _inputPointTxt.removeEventListener("change",__onContributeTxtPointChangHandler);
         _inputPointTxt.removeEventListener("keyFocusChange",__onContributePointFocus);
         _inputPointTxt.removeEventListener("mouseFocusChange",__onContributePointFocus);
         _inputPointTxt.removeEventListener("mouseDown",__onContributePointDown);
         gold.removeEventListener(ResourceEvent.RESOURCE_UPDATE,__refreshGold);
         if(_data)
         {
            _data.removeEventListener("UPDA_CONSORTIA_INFO",__onConsortiaInfoUpdata);
         }
         if(_data)
         {
            _data.removeEventListener("UPDA_CONSORTIA_CONTRIBUTE_INFO",__onContributeInfoUpdata);
         }
         playerInfo.removeEventListener("PLAYER_INFO_UPDATE",__playerInfoUpdateHandler);
      }
      
      private function __playerInfoUpdateHandler(param1:PlayerEvent) : void
      {
         if(playerInfo.consortiaID == 0)
         {
            dispose();
            return;
         }
         _selfContributeTxt.text = playerInfo.consortiaOffer + "";
         _selfContributeTxt.width = _selfContributeTxt.textWidth + 10;
         _currentSoulTxt.text = consortiaTxtStyle(playerInfo.strategy + "");
         _currentPointTxt.text = consortiaTxtStyle(playerInfo.point + playerInfo.giftToken + "");
         refreshPosition();
      }
      
      private function __onPointKeydownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            __onContributeTxtPointChangHandler(null);
         }
         param1.stopPropagation();
      }
      
      private function __onContributePointFocus(param1:FocusEvent) : void
      {
         _selfAddTxt.text = _wealthAddTxt.text = "";
         _focusInt = 0;
      }
      
      private function __onContributeTxtPointChangHandler(param1:Event) : void
      {
         var _loc2_:RegExp = /,/g;
         var _loc3_:int = parseInt(_inputPointTxt.text.replace(_loc2_,""));
         if(_loc3_ > playerInfo.point + playerInfo.giftToken)
         {
            _loc3_ = playerInfo.point + playerInfo.giftToken;
         }
         if(_loc3_ <= 0)
         {
            _loc3_ = 0;
         }
         _soulAddTxt.text = "";
         _selfAddTxt.text = _wealthAddTxt.text = "+" + int(_loc3_ / pointToOffer);
         _inputPointTxt.text = consortiaTxtStyle(_loc3_ + "");
         _inputPointTxt.setSelection(_inputPointTxt.text.length,_inputPointTxt.text.length);
         refreshPosition();
      }
      
      private function __onPointContributeHnadler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc5_:RegExp = /,/g;
         var _loc4_:String = _inputPointTxt.text.replace(_loc5_,"");
         var _loc2_:String = "";
         if(playerInfo.point + playerInfo.giftToken <= 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.contribution.ConsortiaContributeFrame.command02");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(int(_loc4_) == 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.contribution.ConsortiaContributeFrame.command03");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(int(_loc4_) < pointToOffer)
         {
            _loc2_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.contribution.ConsortiaContributeFrame.command08",pointToOffer);
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc3_:String = _inputGoldTxt.text.replace(_loc5_,"");
         ConsortiaSocektSendManager.consortiaContribute(int(_loc3_),int(_loc4_));
         _inputGoldTxt.text = consortiaTxtStyle(_loc3_ + "");
         _inputPointTxt.text = consortiaTxtStyle(_loc4_ + "");
         _selfAddTxt.text = _wealthAddTxt.text = _inputPointTxt.text = "";
         stage.focus = _inputPointTxt;
         _focusInt = 3;
      }
      
      private function __onContributeGoldDown(param1:MouseEvent) : void
      {
         var _loc2_:RegExp = /,/g;
         var _loc3_:String = _inputGoldTxt.text.replace(_loc2_,"");
         _selfAddTxt.text = _wealthAddTxt.text = "+" + int(int(_loc3_) / 1000);
         _soulAddTxt.text = "";
         _inputSoulTxt.text = "0";
         _inputPointTxt.text = "0";
         if(_focusInt != 1)
         {
            _inputGoldTxt.setSelection(0,_inputGoldTxt.text.length);
         }
         _focusInt = 1;
      }
      
      private function __onContributeSoulDown(param1:MouseEvent) : void
      {
         var _loc2_:RegExp = /,/g;
         var _loc3_:String = _inputSoulTxt.text.replace(_loc2_,"");
         _selfAddTxt.text = _wealthAddTxt.text = "";
         _soulAddTxt.text = "+" + int(int(_loc3_) / 1000);
         _inputGoldTxt.text = "0";
         _inputPointTxt.text = "0";
         if(_focusInt != 2)
         {
            _inputSoulTxt.setSelection(0,_inputSoulTxt.text.length);
         }
         _focusInt = 2;
      }
      
      private function __onContributePointDown(param1:MouseEvent) : void
      {
         var _loc2_:RegExp = /,/g;
         var _loc3_:int = parseInt(_inputPointTxt.text.replace(_loc2_,""));
         _selfAddTxt.text = _wealthAddTxt.text = "+" + (_inputPointTxt.text == "" ? "0" : int(_loc3_ / pointToOffer));
         _soulAddTxt.text = "";
         _inputSoulTxt.text = "0";
         _inputGoldTxt.text = "0";
         if(_focusInt != 3)
         {
            _inputPointTxt.setSelection(0,_inputPointTxt.text.length);
         }
         _focusInt = 3;
      }
      
      private function __onContributeGoldFocus(param1:FocusEvent) : void
      {
         _selfAddTxt.text = _wealthAddTxt.text = "";
         _focusInt = 0;
      }
      
      private function __onSoulFocusHandler(param1:FocusEvent) : void
      {
         _soulAddTxt.text = "";
         _focusInt = 0;
      }
      
      private function __onContributeOver(param1:MouseEvent) : void
      {
         if(parseInt(_inputGoldTxt.text))
         {
            __onContributeTxtChangHandler(null);
         }
      }
      
      private function __onSoulBtnOver(param1:MouseEvent) : void
      {
         if(parseInt(_inputSoulTxt.text))
         {
            __onSoulTxtChangHandler(null);
         }
      }
      
      private function __onPointContributeOver(param1:MouseEvent) : void
      {
         if(parseInt(_inputPointTxt.text))
         {
            __onContributeTxtPointChangHandler(null);
         }
      }
      
      private function __onContributeOut(param1:MouseEvent) : void
      {
         if(!parseInt(_inputGoldTxt.text) && !parseInt(_inputPointTxt.text))
         {
            _selfAddTxt.text = _wealthAddTxt.text = "";
         }
      }
      
      private function __onSoulBtnOut(param1:MouseEvent) : void
      {
         if(!parseInt(_inputSoulTxt.text))
         {
            _soulAddTxt.text = "";
         }
      }
      
      private function __onPointContributeOut(param1:MouseEvent) : void
      {
         if(!parseInt(_inputGoldTxt.text) && !parseInt(_inputPointTxt.text))
         {
            _selfAddTxt.text = _wealthAddTxt.text = "";
         }
      }
      
      private function __onAddedToStage(param1:Event) : void
      {
         removeEventListener("addedToStage",__onAddedToStage);
         _inputGoldTxt.text = "0";
         _wealthAddTxt.text = "";
         _selfAddTxt.text = "";
         _inputGoldTxt.setSelection(_inputGoldTxt.text.length,_inputGoldTxt.text.length);
         stage.focus = _inputGoldTxt;
         _focusInt = 1;
      }
      
      private function get gold() : ResourceData
      {
         return ResourceManager.instance.gold;
      }
      
      private function __refreshGold(param1:Event) : void
      {
         _currentGoldTxt.text = consortiaTxtStyle(gold.count + "");
      }
      
      private function __onConsortiaInfoUpdata(param1:ConsortiaEvent) : void
      {
         _wealthTxt.text = _data.consortiaInfo.offer + "";
         _soulTxt.text = _data.emeDreamInfo.spirit + "";
         _wealthTxt.width = _wealthTxt.textWidth + 10;
         _soulTxt.width = _soulTxt.textWidth + 10;
         refreshPosition();
      }
      
      private function __onContributeInfoUpdata(param1:ConsortiaEvent) : void
      {
         if(_data.selfOrder <= 0)
         {
            _selfInfoRan.text = "";
         }
         else
         {
            _selfInfoRan.text = _data.selfOrder + "";
         }
         _selfInfoName.text = _data.nickName;
         if(_data.isHistory)
         {
            _selfInfoCount.text = _data.totalOffer + "";
            _selfInfoSoul.text = _data.totalSpirit + "";
         }
         else
         {
            _selfInfoCount.text = _data.todayOffer + "";
            _selfInfoSoul.text = _data.todaySpirit + "";
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               _isShow = true;
               dispose();
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __onSoulBtnHnadler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc4_:RegExp = /,/g;
         var _loc2_:String = _inputSoulTxt.text.replace(_loc4_,"");
         var _loc3_:String = "";
         if(playerInfo.strategy <= 0)
         {
            _loc3_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.contribution.ConsortiaContributeFrame.command06");
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         if(int(_loc2_) < 1000)
         {
            _loc3_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.contribution.ConsortiaContributeFrame.command07");
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         if(int(_loc2_) == 0)
         {
            _loc3_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.contribution.ConsortiaContributeFrame.command03");
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         ConsortiaSocektSendManager.consortiaContributeSoul(int(_loc2_));
         _inputSoulTxt.text = consortiaTxtStyle(_loc2_ + "");
         _soulAddTxt.text = _inputSoulTxt.text = "";
         stage.focus = _inputSoulTxt;
         _focusInt = 2;
      }
      
      private function __onContributeHnadler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc5_:RegExp = /,/g;
         var _loc2_:String = _inputGoldTxt.text.replace(_loc5_,"");
         var _loc3_:String = "";
         if(gold.count <= 0)
         {
            _loc3_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.contribution.ConsortiaContributeFrame.command04");
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         if(int(_loc2_) < 1000)
         {
            _loc3_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.contribution.ConsortiaContributeFrame.command05");
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         if(int(_loc2_) == 0)
         {
            _loc3_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.contribution.ConsortiaContributeFrame.command03");
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         var _loc4_:String = _inputPointTxt.text.replace(_loc5_,"");
         ConsortiaSocektSendManager.consortiaContribute(int(_loc2_),int(_loc4_));
         _inputGoldTxt.text = consortiaTxtStyle(_loc2_ + "");
         _inputPointTxt.text = consortiaTxtStyle(_loc4_ + "");
         _selfAddTxt.text = _wealthAddTxt.text = _inputGoldTxt.text = "";
         stage.focus = _inputGoldTxt;
         _focusInt = 1;
      }
      
      private function __onSoulTxtChangHandler(param1:Event) : void
      {
         var _loc2_:RegExp = /,/g;
         var _loc3_:int = int(_inputSoulTxt.text.replace(_loc2_,""));
         if(_loc3_ > playerInfo.strategy)
         {
            _loc3_ = int(playerInfo.strategy);
         }
         if(_loc3_ <= 0)
         {
            _loc3_ = 0;
         }
         _selfAddTxt.text = _wealthAddTxt.text = "";
         _soulAddTxt.text = "+" + int(_loc3_ / 1000);
         _inputSoulTxt.text = consortiaTxtStyle(_loc3_ + "");
         _inputSoulTxt.setSelection(_inputSoulTxt.text.length,_inputSoulTxt.text.length);
         refreshPosition();
      }
      
      private function __onContributeTxtChangHandler(param1:Event) : void
      {
         var _loc2_:RegExp = /,/g;
         var _loc3_:String = _inputGoldTxt.text.replace(_loc2_,"");
         var _loc4_:int = int(_loc3_);
         if(_loc4_ > gold.count)
         {
            _loc4_ = int(gold.count);
         }
         if(_loc4_ <= 0)
         {
            _loc4_ = 0;
         }
         _soulAddTxt.text = "";
         _selfAddTxt.text = _wealthAddTxt.text = "+" + int(_loc4_ / 1000);
         _inputGoldTxt.text = consortiaTxtStyle(_loc4_ + "");
         _inputGoldTxt.setSelection(_inputGoldTxt.text.length,_inputGoldTxt.text.length);
         refreshPosition();
      }
      
      private function refreshPosition() : void
      {
         _selfAddTxt.x = _selfContributeTxt.x + _selfContributeTxt.textWidth + 9;
         _wealthAddTxt.x = _wealthTxt.x + _wealthTxt.textWidth + 9;
         _soulAddTxt.x = _soulTxt.x + _soulTxt.textWidth + 9;
      }
      
      private function consortiaTxtStyle(param1:String) : String
      {
         var _loc4_:String = null;
         var _loc3_:RegExp = /,/g;
         param1 = param1.replace(_loc3_,"");
         var _loc2_:int = param1.length;
         if(param1.length >= 16)
         {
            _loc4_ = param1;
         }
         else if(param1.length >= 10)
         {
            _loc4_ = param1.substring(0,_loc2_ - 9) + "," + param1.substring(_loc2_ - 9,_loc2_ - 6) + "," + param1.substring(_loc2_ - 6,_loc2_ - 3) + "," + param1.substring(_loc2_ - 3,_loc2_);
         }
         else if(param1.length >= 7)
         {
            _loc4_ = param1.substring(0,_loc2_ - 6) + "," + param1.substring(_loc2_ - 6,_loc2_ - 3) + "," + param1.substring(_loc2_ - 3,_loc2_);
         }
         else if(param1.length >= 4)
         {
            _loc4_ = param1.substring(0,_loc2_ - 3) + "," + param1.substring(_loc2_ - 3,_loc2_);
         }
         else
         {
            _loc4_ = param1;
         }
         return _loc4_;
      }
      
      public function show(param1:Object = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninit();
         super.dispose();
         FrameControllerManager.instance.consortiaController.closeContributeFrame(_isShow);
      }
   }
}

