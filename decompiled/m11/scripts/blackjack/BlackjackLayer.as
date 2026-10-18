package blackjack
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.blackjack.BlackjackTempInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.BlackjackManager;
   import yishi.manager.ConfigManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManagerHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class BlackjackLayer extends Component
   {
      
      private var _startCardBg:DisplayObject;
      
      private var _startCardTxt:DisplayObject;
      
      private var _blackGound:Sprite;
      
      private var _betBtn1:BlackjackChip;
      
      private var _betBtn2:BlackjackChip;
      
      private var _betBtn3:BlackjackChip;
      
      public function BlackjackLayer()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _blackGound = new Sprite();
         _blackGound.graphics.clear();
         _blackGound.graphics.beginFill(0,0.8);
         _blackGound.graphics.drawRect(0,0,618,511);
         _blackGound.graphics.endFill();
         _startCardBg = ComponentFactory.Instance.creatBitmap("asset.blackjack.startCardBg");
         _startCardTxt = ComponentFactory.Instance.creatBitmap("asset.blackjack.startCardTxt");
         _betBtn1 = new BlackjackChip(1);
         _betBtn1.x = -1;
         _betBtn1.y = 45;
         _betBtn2 = new BlackjackChip(2);
         _betBtn2.x = 202;
         _betBtn2.y = 45;
         _betBtn3 = new BlackjackChip(3);
         _betBtn3.x = 402;
         _betBtn3.y = 45;
         var _loc2_:int = 1;
         var _loc3_:Dictionary = BlackjackManager.instance.blackTempDic;
         for each(var _loc1_:BlackjackTempInfo in _loc3_)
         {
            this["_betBtn" + _loc2_].data = _loc1_;
            _loc2_++;
         }
         addChild(_blackGound);
         addChild(_startCardBg);
         addChild(_startCardTxt);
         addChild(_betBtn1);
         addChild(_betBtn2);
         addChild(_betBtn3);
      }
      
      private function addEvent() : void
      {
         _betBtn1.addEventListener("click",__betBtnHandler);
         _betBtn2.addEventListener("click",__betBtnHandler);
         _betBtn3.addEventListener("click",__betBtnHandler);
      }
      
      private function removeEvent() : void
      {
         if(_betBtn1)
         {
            _betBtn1.removeEventListener("click",__betBtnHandler);
         }
         if(_betBtn2)
         {
            _betBtn2.removeEventListener("click",__betBtnHandler);
         }
         if(_betBtn3)
         {
            _betBtn3.removeEventListener("click",__betBtnHandler);
         }
      }
      
      private function __betBtnHandler(param1:MouseEvent) : void
      {
         var current:BlackjackChip;
         var hasMoney:int;
         var checkTxt:String;
         var content:String;
         var refreshResultHandler:*;
         var e:MouseEvent = param1;
         SoundManager.instance.play("022");
         if(!ConfigManager.info.BLACKJACK || playerModel.nowDate && ConfigManager.info.BLACKJACK_BEGIN_DATE && ConfigManager.info.BLACKJACK_END_DATE && (ConfigManager.info.BLACKJACK_BEGIN_DATE.time > playerModel.nowDate || playerModel.nowDate > ConfigManager.info.BLACKJACK_END_DATE.time))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.ActivityManager.command02"));
            return;
         }
         current = e.currentTarget as BlackjackChip;
         hasMoney = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         if(hasMoney >= int(current.data.cost))
         {
            refreshResultHandler = function():void
            {
               BlackjackManager.instance.OperateBlackjack(1,current.data.id);
               dispose();
            };
            checkTxt = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            content = LanguageMgr.GetTranslation("view.blackjack.BlackjackFrame.startCard",current.data.cost);
            SharedManagerHelper.ins.needAlert("mounts.MountKingTrainView.refreshAlert",refreshResultHandler,checkTxt,content);
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_blackGound);
         _blackGound = null;
         ObjectUtils.disposeObject(_startCardBg);
         _startCardBg = null;
         ObjectUtils.disposeObject(_startCardTxt);
         _startCardTxt = null;
         ObjectUtils.disposeObject(_betBtn1);
         _betBtn1 = null;
         ObjectUtils.disposeObject(_betBtn2);
         _betBtn2 = null;
         ObjectUtils.disposeObject(_betBtn3);
         _betBtn3 = null;
         super.dispose();
      }
   }
}

