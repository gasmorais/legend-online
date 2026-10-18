package apex
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.ApexEvent;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import mvc.module.apex.ApexModel;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.ApexManager;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ApexHallFrame extends Frame
   {
      
      private var _btnHallFight:IconButton;
      
      private var _btnHallGuess:IconButton;
      
      private var _txtHallTimeStart:FilterFrameText;
      
      private var _txtHallTimeGuess:FilterFrameText;
      
      private var _mainView2:MutipleImage;
      
      private var _mainView1:MutipleImage;
      
      private var _txtTime:FilterFrameText;
      
      private var _txtCondition:FilterFrameText;
      
      private var _txtCost:FilterFrameText;
      
      private var _btnShop:BaseButton;
      
      private var _btnTeamIn:IconButton;
      
      private var _bit0:Bitmap;
      
      private var imgState:ScaleFrameImage;
      
      private var txtLinkAward:TextButton;
      
      private var txtLinkRank:TextButton;
      
      private var stateArr1:Array;
      
      private var stateArr2:Array;
      
      private var topListView:ApexHallPlayerList;
      
      private var _helpBtn:BaseButton;
      
      public function ApexHallFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _btnHallFight = ComponentFactory.Instance.creatComponentByStylename("ui.apex.btnHallFight");
         _btnHallGuess = ComponentFactory.Instance.creatComponentByStylename("ui.apex.btnHallGuess");
         _txtHallTimeStart = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtHallTimeStart");
         _txtHallTimeGuess = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtHallTimeGuess");
         _mainView2 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.mainView2");
         _mainView1 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.mainView1");
         _txtTime = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtTime");
         _txtCondition = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtCondition");
         _txtCost = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtCost");
         _btnShop = ComponentFactory.Instance.creatComponentByStylename("ui.apex.btnShop");
         _btnTeamIn = ComponentFactory.Instance.creatComponentByStylename("ui.apex.btnTeamIn");
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.apex.bg0");
         imgState = ComponentFactory.Instance.creatComponentByStylename("ui.apex.signstate");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("apex.hall.HelpBtn");
         _helpBtn.tipData = LanguageMgr.GetTranslation("apex.help.hall2");
         txtLinkAward = ComponentFactory.Instance.creatComponentByStylename("apex.hall.linkAward");
         txtLinkRank = ComponentFactory.Instance.creatComponentByStylename("apex.hall.linkRank");
         txtLinkAward.text = LanguageMgr.GetTranslation("apex.hall.str4");
         txtLinkRank.text = LanguageMgr.GetTranslation("apex.hall.str5");
         _txtTime.text = LanguageMgr.GetTranslation("apex.hall.str1",model.apexState.signTimeStr);
         _txtHallTimeStart.text = model.apexState.fightTimeStr;
         if(model.apexState.isGuessTime)
         {
            _txtHallTimeGuess.text = model.apexState.betTimeStr;
         }
         else
         {
            _txtHallTimeGuess.text = LanguageMgr.GetTranslation("apex.hall.cannotGuess2");
         }
         _txtCondition.text = LanguageMgr.GetTranslation("apex.hall.str2",model.signMinFP);
         _txtCost.text = LanguageMgr.GetTranslation("apex.hall.str3",model.signCost);
         addToContent(_bit0);
         addToContent(_btnHallFight);
         addToContent(_btnHallGuess);
         addToContent(_txtHallTimeStart);
         addToContent(_txtHallTimeGuess);
         addToContent(_mainView2);
         addToContent(_mainView1);
         addToContent(_txtTime);
         addToContent(_txtCondition);
         addToContent(_txtCost);
         addToContent(_btnShop);
         addToContent(_btnTeamIn);
         addToContent(imgState);
         _btnTeamIn.iconFrameChange = false;
         addToContent(txtLinkAward);
         addToContent(txtLinkRank);
         stateArr1 = [_mainView1,_btnTeamIn,_txtTime,_txtCondition,_txtCost,imgState];
         stateArr2 = [_mainView2,_btnHallFight,_btnHallGuess,_txtHallTimeStart,_txtHallTimeGuess];
         refreshState();
         topListView = new ApexHallPlayerList();
         addToContent(topListView);
         topListView.refresh();
         addToContent(_helpBtn);
      }
      
      private function refreshState() : void
      {
         if(model.apexState.state == 2 || model.apexState.state == 3 || model.apexState.state == 4 || model.apexState.state == 5 || model.apexState.state == 6)
         {
            showStatue(2);
         }
         else if(model.isSign)
         {
            showStatue(2);
            imgState.visible = false;
         }
         else
         {
            showStatue(1);
            imgState.visible = true;
            imgState.setFrame(1);
            updateTeam(null);
         }
      }
      
      private function showStatue(param1:int) : void
      {
         var _loc2_:* = null;
         if(param1 == 1)
         {
            for each(_loc2_ in stateArr1)
            {
               _loc2_.visible = true;
            }
            for each(_loc2_ in stateArr2)
            {
               _loc2_.visible = false;
            }
         }
         else if(param1 == 2)
         {
            for each(_loc2_ in stateArr1)
            {
               _loc2_.visible = false;
            }
            for each(_loc2_ in stateArr2)
            {
               _loc2_.visible = true;
            }
            if(model.apexState.state == 2)
            {
               _btnTeamIn.x = 568;
               if(!model.isSign)
               {
                  _btnTeamIn.visible = true;
                  _btnHallFight.visible = false;
                  _btnTeamIn.x = 292;
               }
            }
         }
         else if(param1 == 3)
         {
            for each(_loc2_ in stateArr1)
            {
               _loc2_.visible = false;
            }
            for each(_loc2_ in stateArr2)
            {
               _loc2_.visible = true;
            }
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         txtLinkRank.addEventListener("click",onClickRank);
         txtLinkAward.addEventListener("click",onClickAward);
         _btnHallGuess.addEventListener("click",onClickGuess);
         _btnTeamIn.addEventListener("click",onClickSign);
         _btnHallFight.addEventListener("click",onClickFight);
         _btnShop.addEventListener("click",onClickShop);
         ApexManager.instance.addEventListener("REFRESH_MAIN_VIEW",refreshMainView);
         ApexManager.instance.addEventListener("REFRESH_APEX_STATE",refreshMainView);
         ApexManager.instance.addEventListener("REFRESH_APEX_TERM_DATA",updateTeam);
         _helpBtn.addEventListener("click",__helpClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         txtLinkRank.removeEventListener("click",onClickRank);
         txtLinkAward.removeEventListener("click",onClickAward);
         _btnHallGuess.removeEventListener("click",onClickGuess);
         _btnTeamIn.removeEventListener("click",onClickSign);
         _btnHallFight.removeEventListener("click",onClickFight);
         _btnShop.removeEventListener("click",onClickShop);
         ApexManager.instance.removeEventListener("REFRESH_MAIN_VIEW",refreshMainView);
         ApexManager.instance.removeEventListener("REFRESH_APEX_STATE",refreshMainView);
         ApexManager.instance.removeEventListener("REFRESH_APEX_TERM_DATA",updateTeam);
         _helpBtn.removeEventListener("click",__helpClick);
      }
      
      private function updateTeam(param1:ApexEvent = null) : void
      {
         if(model.curTeamMemNum || model.myTeam)
         {
            (_btnTeamIn.icon as ScaleFrameImage).setFrame(2);
         }
         else
         {
            (_btnTeamIn.icon as ScaleFrameImage).setFrame(1);
         }
      }
      
      private function __helpClick(param1:MouseEvent) : void
      {
         var _loc2_:ApexHelpFrame = ComponentFactory.Instance.creatComponentByStylename("apex.hall.helpFrame");
         _loc2_.show();
      }
      
      private function onClickShop(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("shop",1015);
      }
      
      private function refreshMainView(param1:ApexEvent) : void
      {
         refreshState();
         topListView.refresh();
      }
      
      private function onClickFight(param1:MouseEvent) : void
      {
         ApexManager.instance.sendInRoom();
      }
      
      protected function onClickAward(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("apex",4);
      }
      
      protected function onClickGuess(param1:MouseEvent) : void
      {
         if(model.canGuess)
         {
            ApexManager.instance.sendOpenGuess();
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("apex.hall.cannotGuess1"));
         }
      }
      
      protected function onClickSign(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("apex",8);
      }
      
      private function signConfirm(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            ApexManager.instance.sendSign();
         }
      }
      
      protected function onClickRank(param1:MouseEvent) : void
      {
         ApexManager.instance.sendGetRank();
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
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      public function get model() : ApexModel
      {
         return ApexManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_btnHallFight);
         _btnHallFight = null;
         ObjectUtils.disposeObject(_btnHallGuess);
         _btnHallGuess = null;
         ObjectUtils.disposeObject(_txtHallTimeStart);
         _txtHallTimeStart = null;
         ObjectUtils.disposeObject(_txtHallTimeGuess);
         _txtHallTimeGuess = null;
         ObjectUtils.disposeObject(_mainView2);
         _mainView2 = null;
         ObjectUtils.disposeObject(_mainView1);
         _mainView1 = null;
         ObjectUtils.disposeObject(_txtTime);
         _txtTime = null;
         ObjectUtils.disposeObject(_txtCondition);
         _txtCondition = null;
         ObjectUtils.disposeObject(_txtCost);
         _txtCost = null;
         ObjectUtils.disposeObject(_btnShop);
         _btnShop = null;
         ObjectUtils.disposeObject(_btnTeamIn);
         _btnTeamIn = null;
         ObjectUtils.disposeObject(_bit0);
         _bit0 = null;
         ObjectUtils.disposeObject(txtLinkAward);
         txtLinkAward = null;
         ObjectUtils.disposeObject(txtLinkRank);
         txtLinkRank = null;
         ObjectUtils.disposeObject(topListView);
         topListView = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(imgState);
         imgState = null;
         LogicUtils.disposeDisplayCollection(stateArr1);
         stateArr1 = null;
         LogicUtils.disposeDisplayCollection(stateArr2);
         stateArr2 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

