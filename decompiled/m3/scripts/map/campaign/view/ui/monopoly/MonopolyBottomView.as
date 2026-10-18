package map.campaign.view.ui.monopoly
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.MonopolyEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MonopolyManager;
   import managers.MonopolySocketOutManager;
   import mvc.module.monopoly.MonopolyModel;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class MonopolyBottomView extends Sprite implements Disposeable
   {
      
      private var _diceNormalBtn:BaseButton;
      
      private var _diceNormalCountBg:Image;
      
      private var _diceNormalCountTxt:FilterFrameText;
      
      private var _diceMagicBtn:BaseButton;
      
      private var _diceMagicCountBg:Image;
      
      private var _diceMagicCountTxt:FilterFrameText;
      
      private var _diceMagicAddBtn:BaseButton;
      
      private var _model:MonopolyModel;
      
      private var _cancel:Boolean = true;
      
      public function MonopolyBottomView()
      {
         super();
         _model = MonopolyManager.instance.model;
         initView();
         addEvent();
         refresh();
      }
      
      private function initView() : void
      {
         _diceNormalBtn = ComponentFactory.Instance.creatComponentByStylename("monopoly.DiceNormalBtn");
         _diceNormalCountBg = ComponentFactory.Instance.creatComponentByStylename("monopoly.DiceNormalCountBg");
         _diceNormalCountTxt = ComponentFactory.Instance.creatComponentByStylename("monopoly.DiceNormalCountTxt");
         _diceMagicBtn = ComponentFactory.Instance.creatComponentByStylename("monopoly.DiceMagicBtn");
         _diceMagicCountBg = ComponentFactory.Instance.creatComponentByStylename("monopoly.DiceMagicCountBg");
         _diceMagicCountTxt = ComponentFactory.Instance.creatComponentByStylename("monopoly.DiceMagicCountTxt");
         _diceMagicAddBtn = ComponentFactory.Instance.creatComponentByStylename("monopoly.DiceMagicAddBtn");
         addChild(_diceNormalBtn);
         addChild(_diceNormalCountBg);
         addChild(_diceNormalCountTxt);
         addChild(_diceMagicBtn);
         addChild(_diceMagicCountBg);
         addChild(_diceMagicCountTxt);
         addChild(_diceMagicAddBtn);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_diceNormalBtn);
         _diceNormalBtn = null;
         ObjectUtils.disposeObject(_diceMagicBtn);
         _diceMagicBtn = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         _diceNormalBtn.addEventListener("click",__diceNormalBtnClickHandler);
         _diceMagicBtn.addEventListener("click",__diceMagicBtnClickHandler);
         _diceMagicAddBtn.addEventListener("click",_diceMagicAddBtnClickHandler);
         _model.addEventListener("MONOPOLY_INFO_CHANGE",__infoChangeHandler);
      }
      
      private function removeEvent() : void
      {
         _diceNormalBtn.removeEventListener("click",__diceNormalBtnClickHandler);
         _diceMagicBtn.removeEventListener("click",__diceMagicBtnClickHandler);
         _diceMagicAddBtn.removeEventListener("click",_diceMagicAddBtnClickHandler);
         _model.removeEventListener("MONOPOLY_INFO_CHANGE",__infoChangeHandler);
      }
      
      private function __infoChangeHandler(param1:MonopolyEvent) : void
      {
         refresh();
      }
      
      private function _diceMagicAddBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc4_:String = null;
         var _loc6_:TodayNotAlertFrame = null;
         var _loc5_:String = null;
         var _loc3_:String = null;
         if(_model.lastBuySpecialPoint == 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("monopoly.view.MonopolyBottomView.CannotBuyTips");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(todayNeedAlertForMonopolyBuy)
         {
            _cancel = true;
            if(_model.normalPoint + _model.specialPoint > 0)
            {
               _loc4_ = "monopoly.view.MonopolyBottomView.BuyTips01";
            }
            else
            {
               _loc4_ = "monopoly.view.MonopolyBottomView.BuyTips02";
            }
            _loc6_ = ComponentFactory.Instance.creatComponentByStylename("monopoly.TodayNotAlertFrame");
            _loc5_ = LanguageMgr.GetTranslation(_loc4_,_model.magicDicePrice,_model.lastBuySpecialPoint);
            _loc3_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc6_.show(_loc5_,_loc3_,monopolyBuyAlertCallBack,monopolyBuyCloseCallBack,"center",1,true,_model.magicDicePrice,true);
         }
         else
         {
            sendMonopolyBuy();
         }
      }
      
      private function monopolyBuyCloseCallBack() : void
      {
         if(_cancel)
         {
         }
      }
      
      private function monopolyBuyAlertCallBack(param1:Boolean, param2:Boolean = false) : void
      {
         _cancel = false;
         if(param1)
         {
            SharedManager.instance.monopolyDiceMagicBuyAlertDate = new Date();
            SharedManager.instance.saveMonopolyDiceMagicBuyAlertDate();
         }
         SharedManager.instance.monopolyDiceMagicBuyUseBind = param2;
         SharedManager.instance.saveMonopolyDiceMagicBuyUseBind();
         sendMonopolyBuy();
      }
      
      private function sendMonopolyBuy() : void
      {
         var _loc2_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         var _loc1_:Boolean = Boolean(SharedManager.instance.monopolyDiceMagicBuyUseBind);
         if(_loc1_)
         {
            _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
         }
         if(_model.magicDicePrice > _loc2_)
         {
            RechargeAlertMannager.show();
            return;
         }
         MonopolySocketOutManager.sendMonopolyBuy(1,_loc1_);
      }
      
      private function get todayNeedAlertForMonopolyBuy() : Boolean
      {
         var _loc2_:Date = null;
         var _loc3_:Boolean = true;
         var _loc1_:Date = SharedManager.instance.monopolyDiceMagicBuyAlertDate;
         if(_loc1_)
         {
            _loc2_ = new Date();
            if(_loc2_.fullYear == _loc1_.fullYear && _loc2_.month == _loc1_.month && _loc2_.date == _loc1_.date)
            {
               _loc3_ = false;
            }
         }
         return _loc3_;
      }
      
      private function __diceNormalBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(_model.gameIsOver)
         {
            MonopolySocketOutManager.sendLeaveCampaign();
            return;
         }
         if(_model.normalPoint == 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("MonopolyBottomView.normalBtnClickTip");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         MonopolySocketOutManager.sendRollDice();
      }
      
      private function __diceMagicBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(_model.gameIsOver)
         {
            MonopolySocketOutManager.sendLeaveCampaign();
            return;
         }
         if(_model.specialPoint == 0)
         {
            if(_model.lastBuySpecialPoint > 0)
            {
               _loc2_ = LanguageMgr.GetTranslation("MonopolyBottomView.magicBtnClickTip2",_model.lastBuySpecialPoint);
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            _loc2_ = LanguageMgr.GetTranslation("MonopolyBottomView.magicBtnClickTip");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("monopoly",1);
      }
      
      public function refresh() : void
      {
         _diceMagicCountBg.visible = false;
         _diceMagicCountTxt.visible = false;
         _diceMagicAddBtn.visible = false;
         _diceNormalCountTxt.text = _model.normalPoint.toString();
         _diceMagicCountTxt.text = _model.specialPoint.toString();
         if(_model.specialPoint > 0)
         {
            _diceMagicCountBg.visible = true;
            _diceMagicCountTxt.visible = true;
         }
         else
         {
            _diceMagicAddBtn.visible = true;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

