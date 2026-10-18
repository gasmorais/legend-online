package sevenyear.view.gloryGame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import managers.GloryGameManager;
   import mvc.module.gloryGame.GloryGameModel;
   import mvc.module.gloryGame.event.GloryGameEvent;
   import utils.LogicUtils;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class SevenYearGloryGameSignView extends Component
   {
      
      private var _bit0:Bitmap;
      
      private var _bit1:Bitmap;
      
      private var _bit2:Bitmap;
      
      private var _bit3:Bitmap;
      
      private var _bit4:Bitmap;
      
      private var _bit5:Bitmap;
      
      private var _txtGloryGameSignTurn:FilterFrameText;
      
      private var _gloryGameSignPic2:MutipleImage;
      
      private var _bit6:Bitmap;
      
      private var _txtGloryGameSignNextTime:FilterFrameText;
      
      private var _bit7:Bitmap;
      
      private var _txtGloryGameSignRule:FilterFrameText;
      
      private var _txtGloryGameSignCondition:FilterFrameText;
      
      private var _txtGloryGameSignTime:FilterFrameText;
      
      private var _btnGloryGameSign:BaseButton;
      
      private var _btnGloryGameLookAward:BaseButton;
      
      private var _gloryGameSignPic1:MutipleImage;
      
      private var _btnGloryGameStart:IconButton;
      
      private var _bit8:Bitmap;
      
      private var _bit9:Bitmap;
      
      private var _panel:ScrollPanel;
      
      private var playerViewList:SevenYearGloryGameHallPlayerList;
      
      private var state1:Array;
      
      private var state2:Array;
      
      private var state3:Array;
      
      private var state4:Array;
      
      public function SevenYearGloryGameSignView()
      {
         super();
         initView();
         initEvent();
         GloryGameManager.instance.sendOpenView();
      }
      
      private function initView() : void
      {
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.SevenYearGloryGame.str26");
         _bit1 = ComponentFactory.Instance.creatBitmap("asset.SevenYearGloryGame.str28");
         _bit2 = ComponentFactory.Instance.creatBitmap("asset.SevenYearGloryGame.str8");
         _bit3 = ComponentFactory.Instance.creatBitmap("asset.SevenYearGloryGame.str30");
         _bit4 = ComponentFactory.Instance.creatBitmap("asset.SevenYearGloryGame.sign2");
         _bit5 = ComponentFactory.Instance.creatBitmap("asset.SevenYearGloryGame.sign1");
         _txtGloryGameSignTurn = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameSignTurn");
         _gloryGameSignPic2 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.gloryGameSignPic2");
         _bit6 = ComponentFactory.Instance.creatBitmap("asset.SevenYearGloryGame.str17");
         _txtGloryGameSignNextTime = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameSignNextTime");
         _bit7 = ComponentFactory.Instance.creatBitmap("asset.SevenYearGloryGame.line2");
         _txtGloryGameSignRule = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameSignRule");
         _txtGloryGameSignCondition = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameSignCondition");
         _txtGloryGameSignTime = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameSignTime");
         _btnGloryGameSign = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.btnGloryGameSign");
         _btnGloryGameLookAward = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.btnGloryGameLookAward");
         _gloryGameSignPic1 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.gloryGameSignPic1");
         _btnGloryGameStart = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.btnGloryGameStart");
         _bit8 = ComponentFactory.Instance.creatBitmap("asset.SevenYearGloryGame.bg5");
         _bit9 = ComponentFactory.Instance.creatBitmap("asset.SevenYearGloryGame.bg6");
         _panel = ComponentFactory.Instance.creatComponentByStylename("ui.SevenYearGloryGame.scrollPanel");
         addChild(_bit9);
         addChild(_bit8);
         addChild(_bit0);
         addChild(_bit1);
         addChild(_bit2);
         addChild(_bit3);
         addChild(_bit4);
         addChild(_bit5);
         addChild(_txtGloryGameSignTurn);
         addChild(_gloryGameSignPic2);
         addChild(_bit6);
         addChild(_txtGloryGameSignNextTime);
         addChild(_bit7);
         addChild(_panel);
         addChild(_txtGloryGameSignCondition);
         addChild(_txtGloryGameSignTime);
         addChild(_btnGloryGameSign);
         addChild(_btnGloryGameLookAward);
         addChild(_gloryGameSignPic1);
         addChild(_btnGloryGameStart);
         state1 = [_gloryGameSignPic2,_txtGloryGameSignTurn];
         state2 = [_bit3,_bit0,_bit1,_bit2];
         state3 = [_bit6,_txtGloryGameSignNextTime];
         state4 = [_bit4,_bit5];
         _txtGloryGameSignTime.text = DateFormatter.timeFormat1(GloryGameManager.instance.getNextSaturday(1,true));
         _txtGloryGameSignRule.text = LanguageMgr.GetTranslation("SevenYearGloryGame.sign.rule");
         _txtGloryGameSignCondition.text = LanguageMgr.GetTranslation("SevenYearGloryGame.sign.condition");
         _panel.setView(_txtGloryGameSignRule);
         _panel.invalidateViewport();
         _btnGloryGameLookAward.tipData = LanguageMgr.GetTranslation("SevenYearGloryGame.award.str",TempleteManager.instance.gloryRewardDropCate.getTemplatesByIndex(1).count,TempleteManager.instance.gloryRewardDropCate.getTemplatesByIndex(2).count,TempleteManager.instance.gloryRewardDropCate.getTemplatesByIndex(3).count,TempleteManager.instance.gloryRewardDropCate.getTemplatesByIndex(4).count,TempleteManager.instance.gloryRewardDropCate.getTemplatesByIndex(5).count,TempleteManager.instance.gloryRewardDropCate.getTemplatesByIndex(6).count);
      }
      
      private function initEvent() : void
      {
         _btnGloryGameStart.addEventListener("click",onClickStart);
         _btnGloryGameSign.addEventListener("click",onClickSign);
         GloryGameManager.instance.addEventListener("VIEW_OPENED",onViewOpened);
         NotificationManager.instance.addEventListener("HIDE_OTHERS",teamChange);
      }
      
      private function removeEvent() : void
      {
         if(_btnGloryGameStart)
         {
            _btnGloryGameStart.removeEventListener("click",onClickStart);
         }
         if(_btnGloryGameSign)
         {
            _btnGloryGameSign.removeEventListener("click",onClickSign);
         }
         GloryGameManager.instance.removeEventListener("VIEW_OPENED",onViewOpened);
         NotificationManager.instance.removeEventListener("HIDE_OTHERS",teamChange);
      }
      
      private function teamChange(param1:NotificationEvent) : void
      {
         GloryGameManager.instance.sendOpenView();
      }
      
      private function onViewOpened(param1:GloryGameEvent = null) : void
      {
         if(playerViewList)
         {
            playerViewList.dispose();
            playerViewList = null;
         }
         playerViewList = new SevenYearGloryGameHallPlayerList();
         addChild(playerViewList);
         playerViewList.refresh();
         updateState();
      }
      
      private function updateState() : void
      {
         if(model.isSelfSigned)
         {
            _btnGloryGameSign.enable = false;
         }
         handleArr(state1,false);
         handleArr(state2,false);
         handleArr(state3,false);
         handleArr(state4,false);
         var _loc1_:int = int(GloryGameManager.instance.model.currentRound);
         if(_loc1_ != 5 && model.currentState >= 5)
         {
            _loc1_++;
         }
         var _loc2_:Date = GloryGameManager.instance.getBattleTimeByRoundAndGroup(_loc1_);
         if(model.currentState >= 5 || model.currentState == 2)
         {
            if(model.currentState >= 5 && model.currentRound == 5)
            {
               _bit8.visible = false;
            }
            else if(model.currentRound == 6)
            {
               _bit8.visible = false;
            }
            else
            {
               handleArr(state3,true);
               _txtGloryGameSignNextTime.text = DateFormatter.timeFormat1(_loc2_);
            }
         }
         else if(model.currentRound == 1)
         {
            if(model.currentState > 1)
            {
               handleArr(state1,true);
               _txtGloryGameSignTurn.text = model.currentTurn + "/" + 15;
            }
            else if(model.isSelfSigned)
            {
               _bit4.visible = true;
            }
            else
            {
               _bit5.visible = true;
            }
         }
         else if(state2[model.currentRound - 2])
         {
            state2[model.currentRound - 2].visible = true;
         }
      }
      
      private function handleArr(param1:Array, param2:Boolean) : void
      {
         for each(var _loc3_:DisplayObject in param1)
         {
            _loc3_.visible = param2;
         }
      }
      
      protected function onClickSign(param1:MouseEvent) : void
      {
         if(!FreedomTeamManager.instance.hasTeam)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("SevenYearGloryGame.noTeam"));
            return;
         }
         if(!FreedomTeamManager.instance.isCaptain)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("SevenYearGloryGame.notCaptain"));
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("SevenYearGloryGame.sign.hint");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         SimpleAlertHelper.instance.data = [signConfirm];
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc2_,_loc3_,_loc4_,false,false,false,1);
      }
      
      private function signConfirm(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            GloryGameManager.instance.sendSign();
         }
      }
      
      public function get model() : GloryGameModel
      {
         return GloryGameManager.instance.model;
      }
      
      protected function onClickStart(param1:MouseEvent) : void
      {
         GloryGameManager.instance.sendEnterRoom();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bit0);
         _bit0 = null;
         ObjectUtils.disposeObject(_bit1);
         _bit1 = null;
         ObjectUtils.disposeObject(_bit2);
         _bit2 = null;
         ObjectUtils.disposeObject(_bit3);
         _bit3 = null;
         ObjectUtils.disposeObject(_bit4);
         _bit4 = null;
         ObjectUtils.disposeObject(_bit5);
         _bit5 = null;
         ObjectUtils.disposeObject(_txtGloryGameSignTurn);
         _txtGloryGameSignTurn = null;
         ObjectUtils.disposeObject(_gloryGameSignPic2);
         _gloryGameSignPic2 = null;
         ObjectUtils.disposeObject(_bit6);
         _bit6 = null;
         ObjectUtils.disposeObject(_txtGloryGameSignNextTime);
         _txtGloryGameSignNextTime = null;
         ObjectUtils.disposeObject(_bit7);
         _bit7 = null;
         ObjectUtils.disposeObject(_txtGloryGameSignRule);
         _txtGloryGameSignRule = null;
         ObjectUtils.disposeObject(_txtGloryGameSignCondition);
         _txtGloryGameSignCondition = null;
         ObjectUtils.disposeObject(_txtGloryGameSignTime);
         _txtGloryGameSignTime = null;
         ObjectUtils.disposeObject(_btnGloryGameSign);
         _btnGloryGameSign = null;
         ObjectUtils.disposeObject(_btnGloryGameLookAward);
         _btnGloryGameLookAward = null;
         ObjectUtils.disposeObject(_gloryGameSignPic1);
         _gloryGameSignPic1 = null;
         ObjectUtils.disposeObject(_btnGloryGameStart);
         _btnGloryGameStart = null;
         ObjectUtils.disposeObject(_bit8);
         _bit8 = null;
         ObjectUtils.disposeObject(_bit9);
         _bit9 = null;
         ObjectUtils.disposeObject(playerViewList);
         playerViewList = null;
         LogicUtils.disposeDisplayCollection(state1);
         state1 = null;
         LogicUtils.disposeDisplayCollection(state2);
         state2 = null;
         LogicUtils.disposeDisplayCollection(state3);
         state3 = null;
         LogicUtils.disposeDisplayCollection(state4);
         state4 = null;
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         super.dispose();
      }
   }
}

