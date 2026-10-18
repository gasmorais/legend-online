package map.campaign.view.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.WorldBossSocketOutManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.ConsortiaSkillHelper;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class RiverView extends Sprite implements Disposeable
   {
      
      public static const WORLD_BOSS:int = 1;
      
      public static const DEMON:int = 2;
      
      private var _bg:Scale9CornerImage;
      
      private var _riverBtn:IconButton;
      
      private var _battleBtn:IconButton;
      
      private var _txt:FilterFrameText;
      
      private var _downTime:DownTimeView;
      
      private var _tipRiver:Boolean;
      
      private var _riverPay:int;
      
      private var _battlePoint:int = 3;
      
      private var _type:int;
      
      public function RiverView(param1:int = 1)
      {
         _type = param1;
         super();
         init();
      }
      
      private function init() : void
      {
         var _loc1_:ConfigInfosTempInfo = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("worldboss.river.RiverViewBg");
         addChild(_bg);
         _txt = ComponentFactory.Instance.creatComponentByStylename("worldboss.river.riverTxt");
         addChild(_txt);
         _txt.text = LanguageMgr.GetTranslation("map.campaign.view.ui.RiverView.txt");
         _downTime = new DownTimeView();
         _downTime.x = 80;
         _downTime.y = -17;
         addChild(_downTime);
         _tipRiver = false;
         switch(_type - 1)
         {
            case 0:
               _loc1_ = TempleteManager.instance.getConfigInfoByConfigName("Live_Pay");
               _battleBtn = ComponentFactory.Instance.creatComponentByStylename("worldboss.woundinfo.BattleBtn");
               _battleBtn.addEventListener("click",__battlehandler);
               addChild(_battleBtn);
               _battleBtn.x = (this.width - _battleBtn.width) / 2;
               break;
            case 1:
               _loc1_ = TempleteManager.instance.getConfigInfoByConfigName("AltarLive_Offer");
               _riverBtn = ComponentFactory.Instance.creatComponentByStylename("worldboss.woundinfo.RiverBtn");
               _riverBtn.addEventListener("click",__riverHandler);
               addChild(_riverBtn);
               _riverBtn.x = (this.width - _riverBtn.width) / 2;
               break;
            default:
               _txt.y = 37;
               _downTime.y = 5;
         }
         if(_loc1_)
         {
            _riverPay = parseInt(_loc1_.ConfigValue);
         }
         _loc1_ = TempleteManager.instance.getConfigInfoByConfigName("Live_Fight_Pay");
         if(_loc1_)
         {
            _battlePoint = parseInt(_loc1_.ConfigValue);
         }
      }
      
      public function set count(param1:int) : void
      {
         if(param1 <= 0)
         {
            hide();
            return;
         }
         _downTime.addEventListener("complete",__timeCompleteHandler);
         _downTime.count = param1;
      }
      
      private function __timeCompleteHandler(param1:Event) : void
      {
         hide();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __riverHandler(param1:MouseEvent) : void
      {
         var _loc4_:Date = null;
         var _loc6_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc10_:String = null;
         var _loc8_:Date = null;
         var _loc12_:TodayNotAlertFrame = null;
         var _loc7_:String = null;
         var _loc11_:String = null;
         var _loc5_:String = null;
         if(_tipRiver)
         {
            return;
         }
         var _loc9_:Boolean = true;
         switch(_type - 1)
         {
            case 0:
               _loc4_ = SharedManager.instance.worldBossRiverTodayNeedAlertCheckDate;
               break;
            case 1:
               _loc4_ = SharedManager.instance.demonReviveTipCheckDate;
         }
         if(_type == 2)
         {
            SimpleAlertHelper.instance.data = [riverHandler];
            _loc6_ = LanguageMgr.GetTranslation("map.campaign.view.ui.RiverView.content_river",_riverPay + LanguageMgr.GetTranslation("public.contribution"));
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc10_ = LanguageMgr.GetTranslation("public.prompt");
            SimpleAlertHelper.instance.popAlerFrame(_loc10_,_loc6_,_loc2_,_loc3_,true,true);
         }
         else
         {
            if(_loc4_)
            {
               _loc8_ = new Date();
               if(_loc8_.fullYear == _loc4_.fullYear && _loc8_.month == _loc4_.month && _loc8_.date == _loc4_.date)
               {
                  _loc9_ = false;
               }
            }
            if(_loc9_)
            {
               _loc12_ = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert");
               _loc7_ = _riverPay + LanguageMgr.GetTranslation("mainBar.WorldBossBuyBuffBar.point");
               _loc11_ = LanguageMgr.GetTranslation("map.campaign.view.ui.RiverView.content_river",_loc7_);
               _loc5_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
               _loc12_.show(_loc11_,_loc5_,__todayNotAlert,__closeHandler,"center",2,false,_riverPay);
            }
            else
            {
               sendRiver(true);
            }
         }
      }
      
      private function __todayNotAlert(param1:Boolean) : void
      {
         if(param1)
         {
            switch(_type - 1)
            {
               case 0:
                  SharedManager.instance.worldBossRiverTodayNeedAlertCheckDate = new Date();
                  SharedManager.instance.saveWorldBossRiverTodayNeedAlert();
                  break;
               case 1:
                  SharedManager.instance.demonReviveTipCheckDate = new Date();
                  SharedManager.instance.saveDemonReviveTipCheck();
            }
         }
         sendRiver(true);
      }
      
      private function __closeHandler() : void
      {
         sendRiver(false);
      }
      
      private function sendRiver(param1:Boolean) : void
      {
         _tipRiver = false;
         if(param1 && checkPay)
         {
            _tipRiver = true;
            hide();
            if(selfMemberData.isDie == 1)
            {
               WorldBossSocketOutManager.sendRiver();
            }
            else
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("riverView.notDieState"));
            }
         }
      }
      
      private function riverHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(selfMemberData.isDie == 1)
            {
               WorldBossSocketOutManager.sendRiver();
            }
            else
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("riverView.notDieState"));
            }
         }
      }
      
      private function get checkPay() : Boolean
      {
         switch(_type - 1)
         {
            case 0:
               if(playerInfo.point < _riverPay)
               {
                  RechargeAlertMannager.show();
                  return false;
               }
               break;
            case 1:
               if(playerInfo.consortiaOffer < _riverPay)
               {
                  ConsortiaSkillHelper.addOffer();
                  return false;
               }
         }
         return true;
      }
      
      private function __battlehandler(param1:MouseEvent) : void
      {
         var _loc4_:Date = null;
         var _loc7_:TodayNotAlertFrame = null;
         var _loc6_:String = null;
         var _loc3_:String = null;
         if(_tipRiver)
         {
            return;
         }
         var _loc5_:Boolean = true;
         var _loc2_:Date = SharedManager.instance.worldBossRiverTodayNeedAlertCheckDate_enterBattle;
         if(_loc2_)
         {
            _loc4_ = new Date();
            if(_loc4_.fullYear == _loc2_.fullYear && _loc4_.month == _loc2_.month && _loc4_.date == _loc2_.date)
            {
               _loc5_ = false;
            }
         }
         if(_loc5_)
         {
            _loc7_ = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert");
            _loc6_ = LanguageMgr.GetTranslation("map.campaign.view.ui.RiverView.content_battle",_battlePoint);
            _loc3_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc7_.show(_loc6_,_loc3_,__todayNotAlert2,__closeHandler2,"center",2,false,_battlePoint);
         }
         else
         {
            sendEnterBattle(true,SharedManager.instance.worldBossRiverUseBind);
         }
      }
      
      private function __todayNotAlert2(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            SharedManager.instance.worldBossRiverTodayNeedAlertCheckDate_enterBattle = new Date();
            SharedManager.instance.saveWorldBossRiverTodayNeedAlertCheckDate_enterBattle();
            SharedManager.instance.worldBossRiverUseBind = param2;
            SharedManager.instance.saveWorldBossRiverUseBind();
         }
         sendEnterBattle(true,param2);
      }
      
      private function __closeHandler2() : void
      {
         sendEnterBattle(false);
      }
      
      private function sendEnterBattle(param1:Boolean, param2:Boolean = true) : void
      {
         var _loc3_:int = 0;
         _tipRiver = false;
         if(param1)
         {
            _loc3_ = int(playerInfo.point);
            if(param2)
            {
               _loc3_ = playerInfo.giftToken + playerInfo.point;
            }
            if(_loc3_ < _battlePoint)
            {
               RechargeAlertMannager.show();
               return;
            }
            _tipRiver = true;
            hide();
            if(selfMemberData.isDie == 1)
            {
               WorldBossSocketOutManager.sendEnterBattle(param2);
            }
            else
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("riverView.notDieState"));
            }
         }
      }
      
      public function hide() : void
      {
         if(_downTime)
         {
            _downTime.stop();
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function get selfMemberData() : CampaignArmy
      {
         return CampaignManager.instance.mapModel.selfMemberData;
      }
      
      public function setAutoState(param1:Boolean) : void
      {
      }
      
      public function get state() : Boolean
      {
         return false;
      }
      
      public function dispose() : void
      {
         if(_downTime)
         {
            _downTime.removeEventListener("complete",__timeCompleteHandler);
            _downTime.dispose();
         }
         _downTime = null;
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_riverBtn)
         {
            _riverBtn.removeEventListener("click",__riverHandler);
            _riverBtn.dispose();
            _riverBtn = null;
         }
         if(_battleBtn)
         {
            _battleBtn.removeEventListener("click",__battlehandler);
            _battleBtn.dispose();
            _battleBtn = null;
         }
         if(_txt)
         {
            _txt.dispose();
         }
         _txt = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

