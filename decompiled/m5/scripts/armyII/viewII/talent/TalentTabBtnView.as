package armyII.viewII.talent
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class TalentTabBtnView extends Sprite implements Disposeable
   {
      
      public static var SELECTEDINDEX:int = 0;
      
      private var _ordinaryBtn:SelectedIconButton;
      
      private var _advancedBtn:SelectedIconButton;
      
      private var _tabGroup:SelectedButtonGroup;
      
      private var _ordinaryBtnTipsView:MovieClip;
      
      private var _advancedBtnTipsView:MovieClip;
      
      public function TalentTabBtnView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _tabGroup = new SelectedButtonGroup();
         _ordinaryBtn = ComponentFactory.Instance.creatComponentByStylename("army.talentTabBtnView.ordinaryBtn");
         _advancedBtn = ComponentFactory.Instance.creatComponentByStylename("army.talentTabBtnView.advancedBtn");
         _tabGroup.addSelectItem(_ordinaryBtn);
         _tabGroup.addSelectItem(_advancedBtn);
         addChild(_ordinaryBtn);
         addChild(_advancedBtn);
         _tabGroup.selectIndex = 0;
         _ordinaryBtnTipsView = getBtnTipView();
         _ordinaryBtn.addChild(_ordinaryBtnTipsView);
         _advancedBtnTipsView = getBtnTipView();
         _advancedBtn.addChild(_advancedBtnTipsView);
         updateBtnTipsView();
      }
      
      private function getBtnTipView() : MovieClip
      {
         var _loc1_:MovieClip = ComponentFactory.Instance.creatCustomObject("core.InfoTipsMc");
         _loc1_.mouseChildren = _loc1_.mouseEnabled = false;
         _loc1_.y = -10;
         return _loc1_;
      }
      
      private function updateBtnTipsView(param1:Event = null) : void
      {
         _ordinaryBtnTipsView.visible = false;
         _advancedBtnTipsView.visible = false;
         if(thane.talentData.talentPoint > 0)
         {
            _ordinaryBtnTipsView.visible = true;
            _ordinaryBtnTipsView.txt.text = thane.talentData.talentPoint > 99 ? "99+" : thane.talentData.talentPoint.toString();
         }
         if(thane.talentData.advTalentPoint > 0)
         {
            _advancedBtnTipsView.visible = true;
            _advancedBtnTipsView.txt.text = thane.talentData.advTalentPoint > 99 ? "99+" : thane.talentData.advTalentPoint.toString();
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function __tabGroupChangeHandler(param1:Event) : void
      {
         var _loc2_:ISelectable = _tabGroup.getSelectedItem();
         switch(_loc2_)
         {
            case _ordinaryBtn:
               TalentTabBtnView.SELECTEDINDEX = 0;
               break;
            case _advancedBtn:
               if(PlayerManager.instance.currentPlayerModel.playerInfo.vocationGrades <= 0)
               {
                  TalentTabBtnView.SELECTEDINDEX = 1;
                  _tabGroup.selectIndex = 0;
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.viewII.talent.TalentTabBtnView.alert"));
                  return;
               }
               TalentTabBtnView.SELECTEDINDEX = 1;
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("CHANGETALENTVIEW"));
      }
      
      private function initEvent() : void
      {
         _tabGroup.addEventListener("change",__tabGroupChangeHandler);
         NotificationManager.instance.addEventListener("INFO_TIPS_DATA_UPDATE",updateBtnTipsView);
      }
      
      private function removeEvent() : void
      {
         _tabGroup.removeEventListener("change",__tabGroupChangeHandler);
         NotificationManager.instance.removeEventListener("INFO_TIPS_DATA_UPDATE",updateBtnTipsView);
      }
      
      public function dispose() : void
      {
         TalentTabBtnView.SELECTEDINDEX = 0;
         removeEvent();
         _tabGroup = null;
         ObjectUtils.disposeObject(_ordinaryBtn);
         _ordinaryBtn = null;
         ObjectUtils.disposeObject(_advancedBtn);
         _advancedBtn = null;
         ObjectUtils.disposeObject(_ordinaryBtnTipsView);
         _ordinaryBtnTipsView = null;
         ObjectUtils.disposeObject(_advancedBtnTipsView);
         _advancedBtnTipsView = null;
      }
   }
}

