package consortia.view.myConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import consortia.net.ConsortiaSocektSendManager;
   import consortia.view.myConsortia.chairmanPath.ConsortiaRenameFrame;
   import consortia.view.myConsortia.chairmanPath.ConsortiaTransferFrame;
   import consortia.view.myConsortia.chairmanPath.RecruitMemberFrame;
   import consortia.view.myConsortia.chairmanPath.consortiaEmail.ConsortiaEmailGroupSendView;
   import consortia.view.myConsortia.event.ConsortiaEventFrame;
   import consortia.view.myConsortia.recruit.ConsortiaAuditingFrame;
   import events.ConsortiaEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.ConsortiaControler;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.CursorManagerII;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaStaffPage extends Sprite implements Disposeable
   {
      
      private var _recruitbtn:SelectedButton;
      
      private var _recruitLinkBtn:SelectedButton;
      
      private var _consortEventBtn:SelectedButton;
      
      private var _changeNameBtn:SelectedButton;
      
      private var _consortTransferBtn:SelectedButton;
      
      private var _consortEmailBtn:SelectedButton;
      
      private var _settingBtn:SelectedButton;
      
      private var _inquireBtn:SelectedButton;
      
      private var _extiConsortiaBtn:SelectedButton;
      
      private var _contorller:ConsortiaControler;
      
      private var _hbox:HBox;
      
      private var _data:ConsortiaModel;
      
      private var _memberView:ConsortiaMemberView;
      
      private var _recruitNumBg:Bitmap;
      
      private var _recruitNumTxt:FilterFrameText;
      
      private var _btnPosX:int;
      
      public function ConsortiaStaffPage()
      {
         super();
         initView();
         initData();
         addEvent();
      }
      
      private function initView() : void
      {
         _contorller = FrameControllerManager.instance.consortiaController;
         _data = _contorller.model;
         _hbox = ComponentFactory.Instance.creatComponentByStylename("consortia.staffPageBtn.hbox");
         _extiConsortiaBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.exitConsortiaBtn");
         _memberView = ComponentFactory.Instance.creatCustomObject("consortia.ConsortiaMemberView");
         addChild(_memberView);
         addChild(_hbox);
         addChild(_extiConsortiaBtn);
         _recruitNumBg = ComponentFactory.Instance.creatBitmap("asset.consortiaboxNumBg");
         _recruitNumTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.boxNumTxt");
         _recruitNumBg.x = 90;
         _recruitNumBg.y = 447;
         _recruitNumTxt.x = 93;
         _recruitNumTxt.y = 452;
         _recruitbtn = ComponentFactory.Instance.creatComponentByStylename("consortia.consortiaRecruitbtn");
         _recruitLinkBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.RecruitLinkbtn");
         _consortEventBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.consortEventbtn");
         _changeNameBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.changeNameBtn");
         _consortTransferBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.consortTransferBtn");
         _consortEmailBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.consortEmailBtn");
         _settingBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.settingBtn");
         _inquireBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.inquireBtn");
      }
      
      private function initData() : void
      {
         _hbox.removeAllChild();
         _hbox.beginChanges();
         if(_contorller.getRightsByIndex(9))
         {
            if(_recruitbtn)
            {
               _hbox.addChild(_recruitbtn);
               if(_data.recruitNum > 0)
               {
                  _recruitNumBg.visible = true;
                  _recruitNumTxt.visible = true;
                  _recruitNumTxt.text = _data.recruitNum + "";
                  addChild(_recruitNumBg);
                  addChild(_recruitNumTxt);
               }
            }
         }
         if(_contorller.getRightsByIndex(1))
         {
            if(_recruitLinkBtn)
            {
               _hbox.addChild(_recruitLinkBtn);
            }
         }
         if(_consortEventBtn)
         {
            _hbox.addChild(_consortEventBtn);
         }
         if(_contorller.getRightsByIndex(18))
         {
            if(_changeNameBtn)
            {
               _hbox.addChild(_changeNameBtn);
            }
         }
         if(_contorller.getRightsByIndex(1))
         {
            if(_consortTransferBtn)
            {
               _hbox.addChild(_consortTransferBtn);
            }
         }
         if(_contorller.getRightsByIndex(1))
         {
            if(_consortEmailBtn)
            {
               _hbox.addChild(_consortEmailBtn);
            }
         }
         if(_data)
         {
            if(_data.consortiaInfo.chairmanID == playerInfo.userId)
            {
               _hbox.addChild(_settingBtn);
            }
            else
            {
               _hbox.addChild(_inquireBtn);
            }
         }
         _hbox.commitChanges();
      }
      
      private function addEvent() : void
      {
         hboxaddEvent();
         _extiConsortiaBtn.addEventListener("click",_extiConsortiaBtnHandler);
         _data.addEventListener("UPDA_CONSORTIA_RIGHTS",__onConsortiaDutyInfoUpdata);
         _data.addEventListener("recruitnum_changed",__onConsortiaDutyInfoUpdata);
         _data.addEventListener("recruitnum_changed",__recruitNumHandler);
      }
      
      private function hboxaddEvent() : void
      {
         if(_recruitbtn)
         {
            _recruitbtn.addEventListener("click",__recruitBtnHandler);
         }
         if(_recruitLinkBtn)
         {
            _recruitLinkBtn.addEventListener("click",_recruitLinkBtnHandler);
         }
         if(_consortEventBtn)
         {
            _consortEventBtn.addEventListener("click",__consortEventBtnHandler);
         }
         if(_changeNameBtn)
         {
            _changeNameBtn.addEventListener("click",_changeNameBtnHandler);
         }
         if(_consortTransferBtn)
         {
            _consortTransferBtn.addEventListener("click",_consortTransferBtnHandler);
         }
         if(_consortEmailBtn)
         {
            _consortEmailBtn.addEventListener("click",_consortEmailBtnHandler);
         }
         if(_settingBtn)
         {
            _settingBtn.addEventListener("click",_settingBtnHandler);
         }
         if(_inquireBtn)
         {
            _inquireBtn.addEventListener("click",_settingBtnHandler);
         }
      }
      
      private function removeEvent() : void
      {
         hboxBtnRemoveEvent();
         if(_extiConsortiaBtn)
         {
            _extiConsortiaBtn.removeEventListener("click",_extiConsortiaBtnHandler);
         }
         _data.removeEventListener("UPDA_CONSORTIA_RIGHTS",__onConsortiaDutyInfoUpdata);
         _data.removeEventListener("recruitnum_changed",__onConsortiaDutyInfoUpdata);
         _data.removeEventListener("recruitnum_changed",__recruitNumHandler);
      }
      
      private function hboxBtnRemoveEvent() : void
      {
         if(_recruitbtn)
         {
            _recruitbtn.removeEventListener("click",__recruitBtnHandler);
         }
         if(_recruitLinkBtn)
         {
            _recruitLinkBtn.removeEventListener("click",_recruitLinkBtnHandler);
         }
         if(_consortEventBtn)
         {
            _consortEventBtn.removeEventListener("click",__consortEventBtnHandler);
         }
         if(_changeNameBtn)
         {
            _changeNameBtn.removeEventListener("click",_changeNameBtnHandler);
         }
         if(_consortTransferBtn)
         {
            _consortTransferBtn.removeEventListener("click",_consortTransferBtnHandler);
         }
         if(_consortEmailBtn)
         {
            _consortEmailBtn.removeEventListener("click",_consortEmailBtnHandler);
         }
         if(_settingBtn)
         {
            _settingBtn.removeEventListener("click",_settingBtnHandler);
         }
         if(_inquireBtn)
         {
            _inquireBtn.removeEventListener("click",_settingBtnHandler);
         }
      }
      
      private function _settingBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:ConsortiaSettingFrame = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaSettingFrame");
         _loc2_.show();
         mouseOut(param1.currentTarget as SelectedButton);
      }
      
      private function __onConsortiaDutyInfoUpdata(param1:ConsortiaEvent) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         initData();
      }
      
      private function __recruitNumHandler(param1:ConsortiaEvent) : void
      {
         _recruitNumBg.visible = false;
         _recruitNumTxt.visible = false;
         if(_contorller.getRightsByIndex(9))
         {
            if(_recruitbtn)
            {
               _hbox.addChild(_recruitbtn);
               if(_data.recruitNum > 0)
               {
                  _recruitNumBg.visible = true;
                  _recruitNumTxt.visible = true;
                  _recruitNumTxt.text = _data.recruitNum + "";
                  addChild(_recruitNumBg);
                  addChild(_recruitNumTxt);
               }
            }
         }
      }
      
      private function __recruitBtnHandler(param1:MouseEvent) : void
      {
         _recruitNumBg.visible = false;
         _recruitNumTxt.visible = false;
         SoundManager.instance.play("022");
         var _loc2_:ConsortiaAuditingFrame = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaAuditingFrame");
         _loc2_.show();
         mouseOut(param1.currentTarget as SelectedButton);
      }
      
      private function _recruitLinkBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         if(ConsortiaManager.instance.model.consortiaInfo.speakTimes <= 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaChairmanPath.command05");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc3_:RecruitMemberFrame = ComponentFactory.Instance.creatComponentByStylename("consortia.RecruitMemberFrame");
         _loc3_.show();
         mouseOut(param1.currentTarget as SelectedButton);
      }
      
      private function __consortEventBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:ConsortiaEventFrame = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaEventFrame");
         _loc2_.show();
         mouseOut(param1.currentTarget as SelectedButton);
      }
      
      private function _changeNameBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:ConsortiaRenameFrame = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaRenameFrame");
         _loc2_.show();
         mouseOut(param1.currentTarget as SelectedButton);
      }
      
      private function _consortTransferBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:ConsortiaTransferFrame = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaTransferFrame");
         _loc2_.show();
         mouseOut(param1.currentTarget as SelectedButton);
      }
      
      private function _consortEmailBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         CheckUIModuleUtil.instance.tryCall("writeemail",writeEmailUIcallback);
         mouseOut(param1.currentTarget as SelectedButton);
      }
      
      private function mouseOut(param1:SelectedButton) : void
      {
         if(!param1)
         {
            return;
         }
         param1.dispatchEvent(new MouseEvent("rollOut"));
         CursorManagerII.instance.resetCursor();
      }
      
      private function writeEmailUIcallback() : void
      {
         var _loc1_:ConsortiaEmailGroupSendView = ComponentFactory.Instance.creatComponentByStylename("writeemail.ConsortiaEmailGroupSendView");
         _loc1_.show(FrameControllerManager.instance.consortiaController);
      }
      
      private function _extiConsortiaBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc3_:String = TempleteManager.instance.getConfigInfoByConfigName("Consortia_ClearCD_Point").ConfigValue;
         var _loc5_:TodayNotAlertFrame = ComponentFactory.Instance.creatComponentByStylename("consortia.TodayNotAlertFrame");
         var _loc4_:String = LanguageMgr.GetTranslation("consortia.view.myConsortia.ConsortiaFrame.content");
         var _loc2_:String = LanguageMgr.GetTranslation("consortia.view.myConsortia.ConsortiaFrame.checkTxt",_loc3_);
         _loc5_.show(_loc4_,_loc2_,exitCallback);
         mouseOut(param1.currentTarget as SelectedButton);
      }
      
      private function exitCallback(param1:Boolean) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(_data)
         {
            if(_data.consortiaInfo.chairmanID == playerInfo.userId && _data.consortiaInfo.currentCount > 1)
            {
               _loc2_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.ConsortiaFrame.command02");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            if(param1)
            {
               _loc3_ = int(GoodsManager.instance.getGoodsNumByTempId(208013));
               _loc4_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
               if(_loc3_ <= 0 && _loc4_ <= 50)
               {
                  RechargeAlertMannager.show();
                  return;
               }
               ConsortiaSocektSendManager.exitConsortia(1,true);
            }
            else
            {
               ConsortiaSocektSendManager.exitConsortia(0,true);
            }
            _contorller.mainFrame.dispose();
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_memberView)
         {
            _memberView.dispose();
         }
         if(_recruitbtn)
         {
            _recruitbtn.dispose();
         }
         _recruitbtn = null;
         if(_recruitLinkBtn)
         {
            _recruitLinkBtn.dispose();
         }
         _recruitLinkBtn = null;
         if(_consortEventBtn)
         {
            _consortEventBtn.dispose();
         }
         _consortEventBtn = null;
         if(_changeNameBtn)
         {
            _changeNameBtn.dispose();
         }
         _changeNameBtn = null;
         if(_consortTransferBtn)
         {
            _consortTransferBtn.dispose();
         }
         _consortTransferBtn = null;
         if(_consortEmailBtn)
         {
            _consortEmailBtn.dispose();
         }
         _consortEmailBtn = null;
         if(_settingBtn)
         {
            _settingBtn.dispose();
         }
         _settingBtn = null;
         if(_inquireBtn)
         {
            _inquireBtn.dispose();
         }
         _inquireBtn = null;
         if(_extiConsortiaBtn)
         {
            _extiConsortiaBtn.dispose();
         }
         _extiConsortiaBtn = null;
         _contorller = null;
         _data = null;
         _memberView = null;
         if(_recruitNumBg && _recruitNumBg.bitmapData)
         {
            _recruitNumBg.bitmapData.dispose();
            if(_recruitNumBg.parent)
            {
               _recruitNumBg.parent.removeChild(_recruitNumBg);
            }
            _recruitNumBg = null;
         }
         if(_recruitNumTxt)
         {
            _recruitNumTxt.dispose();
         }
         _recruitNumTxt = null;
         ObjectUtils.disposeAllChildren(_hbox);
         if(_hbox)
         {
            _hbox.disposeAllChildren();
            _hbox.dispose();
            _hbox = null;
         }
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

