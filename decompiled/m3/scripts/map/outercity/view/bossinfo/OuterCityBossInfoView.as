package map.outercity.view.bossinfo
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.KingContractManager;
   import map.internals.event.OuterCityEvent;
   import map.outercity.BossMsgInfo;
   import map.outercity.manager.OuterCityManager;
   import mvc.module.kingcontract.KingContractInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class OuterCityBossInfoView extends Sprite implements Disposeable
   {
      
      private var _titleImg0:Bitmap;
      
      private var _enemyCountTxt0:FilterFrameText;
      
      private var _enemyCountTxt1:FilterFrameText;
      
      private var _enemyCountTxt2:FilterFrameText;
      
      private var _titleImg1:Bitmap;
      
      private var _bossInfoTxt0:FilterFrameText;
      
      private var _bossInfoTxt1:FilterFrameText;
      
      private var _bossInfoTxt2:FilterFrameText;
      
      private var _bossInfoTxt3:FilterFrameText;
      
      private var _bossInfoTxt4:FilterFrameText;
      
      private var _bossRadar0:BaseButton;
      
      private var _bossRadar1:BaseButton;
      
      private var _bossRadar2:BaseButton;
      
      private var _bossRadar3:BaseButton;
      
      private var _bossRadar4:BaseButton;
      
      private var _titleImg2:Bitmap;
      
      private var _bossTimeTxt:FilterFrameText;
      
      private var _helpBtn:BaseButton;
      
      private var _graphics1:Sprite;
      
      public function OuterCityBossInfoView()
      {
         super();
         init();
         addEvent();
         updateView();
      }
      
      private function addEvent() : void
      {
         var _loc1_:int = 0;
         NotificationManager.instance.addEventListener("OUTER_CITY_GET_BOSSINFO",onGetBossInfo);
         NotificationManager.instance.addEventListener("OUTER_CITY_UPDATE_BOSS_TIME",onUpdateBossTime);
         _helpBtn.addEventListener("click",onHelpClick);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            this["_bossRadar" + _loc1_].addEventListener("click",__bossRadarHandler);
            _loc1_++;
         }
      }
      
      private function removeEvent() : void
      {
         var _loc1_:int = 0;
         NotificationManager.instance.removeEventListener("OUTER_CITY_GET_BOSSINFO",onGetBossInfo);
         NotificationManager.instance.removeEventListener("OUTER_CITY_UPDATE_BOSS_TIME",onUpdateBossTime);
         _helpBtn.removeEventListener("click",onHelpClick);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            this["_bossRadar" + _loc1_].removeEventListener("click",__bossRadarHandler);
            _loc1_++;
         }
      }
      
      private function onHelpClick(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("outercity.boss.helpFrame");
         _loc2_.show();
      }
      
      private function init() : void
      {
         var _loc1_:int = 0;
         _graphics1 = new Sprite();
         _graphics1.graphics.beginFill(0,0.3);
         _graphics1.graphics.drawRect(0,0,260,245);
         _graphics1.graphics.endFill();
         this.addChild(_graphics1);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            this["_titleImg" + _loc1_] = ComponentFactory.Instance.creatBitmap("asset.outercity.BossInfoViewTitle" + _loc1_);
            addChild(this["_titleImg" + _loc1_]);
            this["_enemyCountTxt" + _loc1_] = ComponentFactory.Instance.creatComponentByStylename("outercity.BossInfo.enemyTxt" + _loc1_);
            addChild(this["_enemyCountTxt" + _loc1_]);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            this["_bossInfoTxt" + _loc1_] = ComponentFactory.Instance.creatComponentByStylename("outercity.BossInfo.bossInfoTxt" + _loc1_);
            this.addChild(this["_bossInfoTxt" + _loc1_]);
            this["_bossRadar" + _loc1_] = ComponentFactory.Instance.creatComponentByStylename("outercity.BossSearchRadar" + _loc1_);
            this["_bossRadar" + _loc1_].visible = false;
            this.addChild(this["_bossRadar" + _loc1_]);
            _loc1_++;
         }
         _bossTimeTxt = ComponentFactory.Instance.creatComponentByStylename("outercity.BossInfo.bossTimeTxt");
         this.addChild(_bossTimeTxt);
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("outerCity.boss.helpBtn");
         addChild(_helpBtn);
      }
      
      private function onGetBossInfo(param1:OuterCityEvent) : void
      {
         updateView();
      }
      
      private function onUpdateBossTime(param1:OuterCityEvent) : void
      {
         updateView();
      }
      
      private function updateView() : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:BossMsgInfo = null;
         var _loc2_:String = null;
         _loc5_ = 0;
         while(_loc5_ < 3)
         {
            _loc4_ = int(OuterCityManager.instance.model.bossInfo["count" + (_loc5_ + 1)]);
            if(_loc4_ > OuterCityManager.instance.model.bossInfo["canKillCount" + (_loc5_ + 1)])
            {
               _loc4_ = int(OuterCityManager.instance.model.bossInfo["canKillCount" + (_loc5_ + 1)]);
            }
            this["_enemyCountTxt" + _loc5_].text = LanguageMgr.GetTranslation("map.outercity.view.bossinfo._enemyCountTxt" + _loc5_,_loc4_,OuterCityManager.instance.model.bossInfo["canKillCount" + (_loc5_ + 1)]);
            _loc5_++;
         }
         _bossTimeTxt.text = DateFormatter.getConsortiaCountDate(OuterCityManager.instance.model.bossInfo.leftBossTime);
         var _loc1_:Array = OuterCityManager.instance.model.bossInfo.bosslist;
         if(_loc1_ == null)
         {
            return;
         }
         var _loc6_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc5_];
            try
            {
               _loc2_ = LanguageMgr.GetTranslation("map.outercity.view.bossinfo.bossStatus" + _loc3_.type);
               this["_bossInfoTxt" + _loc5_].text = LanguageMgr.GetTranslation("map.outercity.view.bossinfo.bossTxt",_loc3_.bossName,_loc3_.grade,_loc2_);
               this["_bossInfoTxt" + _loc5_].width = this["_bossInfoTxt" + _loc5_].textWidth + 5;
               this["_bossInfoTxt" + _loc5_].setFrame(1);
               this["_bossRadar" + _loc5_].visible = true;
               if(this["_bossInfoTxt" + _loc5_].x + this["_bossInfoTxt" + _loc5_].textWidth + 6 > _loc6_)
               {
                  _loc6_ = this["_bossInfoTxt" + _loc5_].x + this["_bossInfoTxt" + _loc5_].textWidth + 6;
               }
               if(_loc3_.type == 0)
               {
                  this["_bossInfoTxt" + _loc5_].setFrame(2);
                  this["_bossRadar" + _loc5_].visible = false;
               }
            }
            catch(e:Error)
            {
            }
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < 5)
         {
            this["_bossRadar" + _loc5_].x = _loc6_;
            _loc5_++;
         }
      }
      
      private function __bossRadarHandler(param1:MouseEvent) : void
      {
         var _loc7_:BaseButton = null;
         var _loc6_:int = 0;
         var _loc2_:Array = null;
         var _loc5_:BossMsgInfo = null;
         var _loc9_:Point = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc8_:String = null;
         var _loc10_:String = null;
         SoundManager.instance.play("022");
         if(KingContractManager.Instance.checkHasBuffById(10))
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("START_OUTERCITY_RADAR"));
            _loc7_ = param1.currentTarget as BaseButton;
            _loc6_ = int(_loc7_.stylename.substring(_loc7_.stylename.length - 1,_loc7_.stylename.length));
            _loc2_ = OuterCityManager.instance.model.bossInfo.bosslist;
            _loc5_ = _loc2_[_loc6_];
            _loc9_ = new Point(_loc5_.x * 20,_loc5_.y * 20);
            NotificationManager.instance.dispatchEvent(new OuterCityEvent("START_MOVE",_loc9_));
            _loc9_ = new Point(_loc9_.x - StageReferance.stageWidth / 2,_loc9_.y - StageReferance.stageHeight / 2);
            OuterCityManager.instance.mapView.motionTo(_loc9_);
         }
         else
         {
            SimpleAlertHelper.instance.data = [__alertBackHandler];
            _loc3_ = LanguageMgr.GetTranslation("public.confirm");
            _loc4_ = LanguageMgr.GetTranslation("public.cancel");
            _loc8_ = LanguageMgr.GetTranslation("public.prompt");
            _loc10_ = LanguageMgr.GetTranslation("kingcontract.view.allBuyFrontAlert");
            SimpleAlertHelper.instance.popAlerFrame(_loc8_,_loc10_,_loc3_,_loc4_,false,true);
         }
      }
      
      private function __alertBackHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            FrameControllerManager.instance.openControllerByInfo("kingcontract");
         }
      }
      
      private function get day() : int
      {
         return (KingContractManager.Instance.model.kingContractInfos[2] as KingContractInfo).template.Duration / 1440;
      }
      
      private function get point1() : int
      {
         return int(TempleteManager.instance.getConfigInfoByConfigName("All_KingContract").ConfigValue);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_titleImg0);
         _titleImg0 = null;
         ObjectUtils.disposeObject(_enemyCountTxt0);
         _enemyCountTxt0 = null;
         ObjectUtils.disposeObject(_enemyCountTxt1);
         _enemyCountTxt1 = null;
         ObjectUtils.disposeObject(_enemyCountTxt2);
         _enemyCountTxt2 = null;
         ObjectUtils.disposeObject(_titleImg1);
         _titleImg1 = null;
         ObjectUtils.disposeObject(_bossInfoTxt0);
         _bossInfoTxt0 = null;
         ObjectUtils.disposeObject(_bossInfoTxt1);
         _bossInfoTxt1 = null;
         ObjectUtils.disposeObject(_bossInfoTxt2);
         _bossInfoTxt2 = null;
         ObjectUtils.disposeObject(_bossInfoTxt3);
         _bossInfoTxt3 = null;
         ObjectUtils.disposeObject(_bossInfoTxt4);
         _bossInfoTxt4 = null;
         ObjectUtils.disposeObject(_bossRadar0);
         _bossRadar0 = null;
         ObjectUtils.disposeObject(_bossRadar1);
         _bossRadar1 = null;
         ObjectUtils.disposeObject(_bossRadar2);
         _bossRadar2 = null;
         ObjectUtils.disposeObject(_bossRadar3);
         _bossRadar3 = null;
         ObjectUtils.disposeObject(_bossRadar4);
         _bossRadar4 = null;
         ObjectUtils.disposeObject(_titleImg2);
         _titleImg2 = null;
         ObjectUtils.disposeObject(_bossTimeTxt);
         _bossTimeTxt = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_graphics1);
         _graphics1 = null;
         this.graphics.clear();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

