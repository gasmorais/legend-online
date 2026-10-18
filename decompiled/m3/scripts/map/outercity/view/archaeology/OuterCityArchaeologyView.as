package map.outercity.view.archaeology
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.KingContractEvents;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.KingContractManager;
   import map.internals.event.OuterCityEvent;
   import map.outercity.ArchaeologyNodeInfo;
   import map.outercity.OuterCityModel;
   import map.outercity.helper.mapview.OutercityArchaeologyHelper;
   import map.outercity.manager.OuterCityManager;
   import map.outercity.view.mapphysics.ArmyView;
   import mvc.module.archeology.ArchaeologyModel;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.kingcontract.KingContractInfo;
   import yishi.actions.map.collection.CollectionAction;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArchaeologyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GameBaseQueueManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class OuterCityArchaeologyView extends Component
   {
      
      private var mcContiner:Component;
      
      private var energyMc:MovieClip;
      
      private var redMc:MovieClip;
      
      private var yellowMc:MovieClip;
      
      private var greenMc:MovieClip;
      
      private var helpBtn:BaseButton;
      
      private var closeBtn:BaseButton;
      
      private var digBtn:BaseButton;
      
      private var searchBtn:BaseButton;
      
      private var buyBtn:IconButton;
      
      private var leftText:FilterFrameText;
      
      private var archaeologyBtn:BaseButton;
      
      private var stargazingBtn:BaseButton;
      
      private var currentState:int = -1;
      
      private var configTemp:ConfigInfosTempInfo;
      
      private var buyConfigTemp:ConfigInfosTempInfo;
      
      private var _operaMediator:AutoArchaeologyOpera;
      
      private var curLevel:int;
      
      public function OuterCityArchaeologyView()
      {
         super();
         initView();
         addEvent();
         __updateEnergyHandler(null);
         __resizeHandler(null);
      }
      
      private function initView() : void
      {
         mcContiner = ComponentFactory.Instance.creatComponentByStylename("OuterCityArchaeologyView.mcContiner");
         redMc = ComponentFactory.Instance.creatCustomObject("OuterCityArchaeologyView.redMc");
         yellowMc = ComponentFactory.Instance.creatCustomObject("OuterCityArchaeologyView.yellowMc");
         energyMc = ComponentFactory.Instance.creatCustomObject("OuterCityArchaeologyView.energyMc");
         greenMc = ComponentFactory.Instance.creatCustomObject("OuterCityArchaeologyView.greenMc");
         closeBtn = ComponentFactory.Instance.creatComponentByStylename("OuterCityArchaeologyView.closeBtn");
         helpBtn = ComponentFactory.Instance.creatComponentByStylename("OuterCityArchaeologyView.helpBtn");
         leftText = ComponentFactory.Instance.creatComponentByStylename("OuterCityArchaeologyView.leftText");
         digBtn = ComponentFactory.Instance.creatComponentByStylename("OuterCityArchaeologyView.digBtn");
         searchBtn = ComponentFactory.Instance.creatComponentByStylename("OuterCityArchaeologyView.searchBtn");
         buyBtn = ComponentFactory.Instance.creatComponentByStylename("ui.Archaeology.BuyBtn");
         archaeologyBtn = ComponentFactory.Instance.creatComponentByStylename("OuterCityArchaeologyView.archaeologyBtn");
         stargazingBtn = ComponentFactory.Instance.creatComponentByStylename("OuterCityArchaeologyView.stargazingBtn");
         _operaMediator = new AutoArchaeologyOpera();
         addChild(mcContiner);
         addChild(digBtn);
         configTemp = TempleteManager.instance.getConfigInfoByConfigName("archaeology_max_count");
         buyConfigTemp = TempleteManager.instance.getConfigInfoByConfigName("archaeology_purchases");
         helpBtn.tipData = LanguageMgr.GetTranslation("ArchaeologyFrame.helpBtn.TipData");
         closeBtn.tipData = LanguageMgr.GetTranslation("public.close1");
         searchBtn.tipData = LanguageMgr.GetTranslation("OuterCityArchaeologyView.autoRoad");
         archaeologyBtn.tipData = LanguageMgr.GetTranslation("OuterCityArchaeologyView.archaeologyBtn.tipdata");
         stargazingBtn.tipData = LanguageMgr.GetTranslation("OuterCityArchaeologyView.stargazingBtn.tipdata");
      }
      
      private function addEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__resizeHandler);
         closeBtn.addEventListener("click",__onCloseHandler);
         helpBtn.addEventListener("click",__helpBtnHandler);
         digBtn.addEventListener("click",__ondigClcikHandler);
         searchBtn.addEventListener("click",__searchClcikHandler);
         archaeologyBtn.addEventListener("click",_outerStateChangeHandler);
         stargazingBtn.addEventListener("click",_outerStateChangeHandler);
         buyBtn.addEventListener("click",buyHandler);
         MsgMan.addObserver("ARCHAEOLOGY_WALK_NEXT",this,__walkNextHandler);
         NotificationManager.instance.addEventListener("MOVE_OVER",__moveOverHandler);
         NotificationManager.instance.addEventListener("PLAYER_EXTRA_FIELD",__updateEnergyHandler);
         NotificationManager.instance.addEventListener("START_OUTERCITY_RADAR",__startRadarHandler);
         if(greenMc)
         {
            greenMc["digBtn"].addEventListener("click",__sendDigClickHandler);
         }
         MsgMan.addObserver("ARCHAEOLOGY_NODE_LIST",this,__updateNodeListHandler);
         NotificationManager.instance.addEventListener("UPDATE_KINGCONTRACT",__updateKingContractHandler);
         if(outercityModel)
         {
            outercityModel.addEventListener("POSATION_POINT",__refreshMcState);
            outercityModel.addEventListener("return_home",__refreshMcState);
         }
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
         if(closeBtn)
         {
            closeBtn.removeEventListener("click",__onCloseHandler);
         }
         if(helpBtn)
         {
            helpBtn.removeEventListener("click",__helpBtnHandler);
         }
         if(digBtn)
         {
            digBtn.removeEventListener("click",__ondigClcikHandler);
         }
         if(searchBtn)
         {
            searchBtn.removeEventListener("click",__searchClcikHandler);
         }
         if(archaeologyBtn)
         {
            archaeologyBtn.removeEventListener("click",_outerStateChangeHandler);
         }
         if(stargazingBtn)
         {
            stargazingBtn.removeEventListener("click",_outerStateChangeHandler);
         }
         if(buyBtn)
         {
            buyBtn.removeEventListener("click",buyHandler);
         }
         MsgMan.removeObserver("ARCHAEOLOGY_WALK_NEXT",this,__walkNextHandler);
         NotificationManager.instance.removeEventListener("MOVE_OVER",__moveOverHandler);
         NotificationManager.instance.removeEventListener("PLAYER_EXTRA_FIELD",__updateEnergyHandler);
         NotificationManager.instance.removeEventListener("START_OUTERCITY_RADAR",__startRadarHandler);
         if(greenMc)
         {
            greenMc["digBtn"].removeEventListener("click",__sendDigClickHandler);
         }
         MsgMan.removeObserver("ARCHAEOLOGY_NODE_LIST",this,__updateNodeListHandler);
         NotificationManager.instance.removeEventListener("UPDATE_KINGCONTRACT",__updateKingContractHandler);
         if(outercityModel)
         {
            outercityModel.removeEventListener("POSATION_POINT",__refreshMcState);
            outercityModel.removeEventListener("return_home",__refreshMcState);
         }
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         this.x = StageReferance.stageWidth / 2 - 80;
         this.y = StageReferance.stageHeight - 200;
         digBtn.x = StageReferance.gameStageWidth / 2 - 110;
         digBtn.y = 60;
      }
      
      private function __sendDigClickHandler(param1:MouseEvent) : void
      {
         if(!configTemp)
         {
            return;
         }
         if(outercityModel.isArchaeologyCollection)
         {
            return;
         }
         var _loc3_:int = parseInt(configTemp.ConfigValue) + archaeologyModel.hasBuyExplorCount;
         if(archaeologyModel.hasExplorationCount >= _loc3_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("OuterCityArchaeologyView.energyCount.isEmptyAlert"));
            return;
         }
         var _loc2_:ArchaeologyNodeInfo = OutercityArchaeologyHelper.getNearestNode(armyViewPos,outercityModel.archaeologyNodeList);
         if(_loc2_)
         {
            GameBaseQueueManager.instance.addAction(new CollectionAction(null,_loc2_.nodeId));
         }
      }
      
      private function __ondigClcikHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _operaMediator.start();
         digBtn.visible = false;
         ArchaeologyManager.instance.sendArchaeologyRequest(5);
      }
      
      private function __onCloseHandler(param1:MouseEvent) : void
      {
         removeContinerChild();
         currentState = -1;
         digBtn.visible = true;
         _operaMediator.stop();
      }
      
      private function buyHandler(param1:MouseEvent) : void
      {
         if(!buyConfigTemp)
         {
            return;
         }
         var _loc4_:Array = buyConfigTemp.ConfigValue.split(",");
         var _loc8_:int = int(_loc4_[2]);
         if(archaeologyModel.hasBuyExplorCount >= _loc8_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("archaeology.Nobuy"));
            return;
         }
         if(playerInfo.point < int(_loc4_[0]))
         {
            RechargeAlertMannager.show();
            return;
         }
         var _loc5_:int = _loc8_ - archaeologyModel.hasBuyExplorCount - int(_loc4_[1]);
         if(_loc5_ < 0)
         {
            _loc5_ = 0;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc6_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc7_:String = LanguageMgr.GetTranslation("archaeology.buy.time",_loc4_[0],_loc4_[1],_loc5_);
         SimpleAlertHelper.instance.data = [buyConfirm];
         SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc2_,_loc3_,false,true);
      }
      
      private function buyConfirm(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            ArchaeologyManager.instance.sendArchaeologyRequest(7);
         }
      }
      
      private function _outerStateChangeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(OuterCityManager.instance.model.isArchaeologyCollection)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("OuterCityArchaeologyView.isCollecting.alert"));
            return;
         }
         if(param1.currentTarget is BaseButton && param1.currentTarget.stylename == "OuterCityArchaeologyView.archaeologyBtn")
         {
            archaeologyModel.outerBtnState = 1;
         }
         else if(param1.currentTarget is BaseButton && param1.currentTarget.stylename == "OuterCityArchaeologyView.stargazingBtn")
         {
            archaeologyModel.outerBtnState = 0;
         }
         refreshStateBtn();
      }
      
      private function __searchClcikHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!configTemp)
         {
            return;
         }
         if(outercityModel.isArchaeologyCollection)
         {
            return;
         }
         var _loc2_:int = parseInt(configTemp.ConfigValue) + archaeologyModel.hasBuyExplorCount;
         if(archaeologyModel.hasExplorationCount >= _loc2_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("OuterCityArchaeologyView.energyCount.isEmptyAlert"));
            return;
         }
         _operaMediator.start();
      }
      
      private function __alertBackHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            FrameControllerManager.instance.openControllerByInfo("kingcontract");
         }
      }
      
      private function __updateKingContractHandler(param1:KingContractEvents) : void
      {
         _operaMediator.start();
      }
      
      private function get day() : int
      {
         return (KingContractManager.Instance.model.kingContractInfos[2] as KingContractInfo).template.Duration / 1440;
      }
      
      private function get point() : int
      {
         return int(TempleteManager.instance.getConfigInfoByConfigName("All_KingContract").ConfigValue);
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = null;
         if(VersionSwitch.STAR_GAZING)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("core.outercityArchaeology.helpFrame");
         }
         else
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("core.outercityArchaeology.helpFrame1");
         }
         _loc2_.show();
      }
      
      private function __refreshMcState(param1:OuterCityEvent) : void
      {
         if(!digBtn.visible)
         {
            refreshView();
         }
      }
      
      private function __updateNodeListHandler(param1:String, param2:Object) : void
      {
         if(!digBtn.visible)
         {
            refreshView();
         }
      }
      
      private function __walkNextHandler(param1:String, param2:Object) : void
      {
         if(!digBtn.visible)
         {
            refreshView();
         }
      }
      
      private function __moveOverHandler(param1:OuterCityEvent) : void
      {
         if(!digBtn.visible)
         {
            refreshView();
         }
      }
      
      private function refreshView() : void
      {
         setDicMcByState();
         refreshDirection();
      }
      
      private function __updateEnergyHandler(param1:NotificationEvent) : void
      {
         if(!configTemp)
         {
            return;
         }
         var _loc2_:int = int(archaeologyModel.hasExplorationCount);
         var _loc3_:int = archaeologyModel.hasBuyExplorCount + parseInt(configTemp.ConfigValue);
         var _loc4_:int = _loc3_ - _loc2_;
         leftText.text = _loc4_ + "/" + _loc3_;
         energyMc.gotoAndStop(int(_loc2_ * 40 / _loc3_));
         curLevel = archaeologyModel.getGradeByExp(archaeologyModel.exp);
         buyBtn.visible = _loc4_ <= 0;
      }
      
      private function __startRadarHandler(param1:NotificationEvent) : void
      {
         if(_operaMediator)
         {
            _operaMediator.stop();
         }
      }
      
      private function refreshDirection() : void
      {
         var _loc1_:Number = OutercityArchaeologyHelper.getDirection(armyViewPos,outercityModel.archaeologyNodeList);
         if(_loc1_ <= 0)
         {
            _loc1_ = 360 + _loc1_;
         }
         if(currentState == 1)
         {
            greenMc.gotoAndPlay(1);
         }
         else if(currentState == 2)
         {
            yellowMc.gotoAndStop(int(_loc1_ / 10));
         }
         else
         {
            redMc.gotoAndStop(int(_loc1_ / 10));
         }
      }
      
      private function setDicMcByState() : void
      {
         var _loc1_:int = OutercityArchaeologyHelper.getLightState(armyViewPos,outercityModel.archaeologyNodeList);
         if(currentState == _loc1_)
         {
            return;
         }
         removeContinerChild();
         mcContiner.addChild(buyBtn);
         currentState = _loc1_;
         if(currentState == 1)
         {
            mcContiner.addChild(greenMc);
            __sendDigClickHandler(null);
            greenMc["digBtn"].buttonMode = true;
         }
         else if(currentState == 2)
         {
            mcContiner.addChild(yellowMc);
         }
         else
         {
            mcContiner.addChild(redMc);
         }
         mcContiner.addChild(energyMc);
         mcContiner.addChild(leftText);
         mcContiner.addChild(helpBtn);
         mcContiner.addChild(closeBtn);
         mcContiner.addChild(searchBtn);
         mcContiner.addChild(archaeologyBtn);
         mcContiner.addChild(stargazingBtn);
         refreshStateBtn();
      }
      
      private function refreshStateBtn() : void
      {
         if(!isOpenStargazing)
         {
            archaeologyBtn.visible = false;
            stargazingBtn.visible = false;
         }
         else if(archaeologyModel.outerBtnState != 0)
         {
            archaeologyBtn.visible = false;
            stargazingBtn.visible = true;
         }
         else
         {
            archaeologyBtn.visible = true;
            stargazingBtn.visible = false;
         }
      }
      
      private function get outercityModel() : OuterCityModel
      {
         return OuterCityManager.instance.model;
      }
      
      private function get archaeologyModel() : ArchaeologyModel
      {
         return ArchaeologyManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get isOpenStargazing() : Boolean
      {
         return VersionSwitch.STAR_GAZING && curLevel >= 3;
      }
      
      private function get armyViewPos() : Point
      {
         var _loc2_:Point = null;
         var _loc3_:BaseArmy = null;
         var _loc1_:ArmyView = OuterCityManager.instance.controler.selfAvatarView;
         if(_loc1_)
         {
            _loc2_ = new Point(_loc1_.x,_loc1_.y);
         }
         else
         {
            _loc3_ = outercityModel.getWorldArmyByUserId(playerInfo.userId);
            if(_loc3_)
            {
               _loc2_ = new Point(_loc3_.curPosX * 20,_loc3_.curPosY * 20);
            }
         }
         return _loc2_;
      }
      
      private function removeContinerChild() : void
      {
         if(energyMc && energyMc.parent)
         {
            energyMc.parent.removeChild(energyMc);
         }
         if(redMc && redMc.parent)
         {
            redMc.parent.removeChild(redMc);
         }
         if(yellowMc && yellowMc.parent)
         {
            yellowMc.parent.removeChild(yellowMc);
         }
         if(greenMc && greenMc.parent)
         {
            greenMc.parent.removeChild(greenMc);
         }
         if(closeBtn && closeBtn.parent)
         {
            closeBtn.parent.removeChild(closeBtn);
         }
         if(searchBtn && searchBtn.parent)
         {
            searchBtn.parent.removeChild(searchBtn);
         }
         if(helpBtn && helpBtn.parent)
         {
            helpBtn.parent.removeChild(helpBtn);
         }
         if(leftText && leftText.parent)
         {
            leftText.parent.removeChild(leftText);
         }
         if(archaeologyBtn && archaeologyBtn.parent)
         {
            archaeologyBtn.parent.removeChild(archaeologyBtn);
         }
         if(stargazingBtn && stargazingBtn.parent)
         {
            stargazingBtn.parent.removeChild(stargazingBtn);
         }
         if(buyBtn && buyBtn.parent)
         {
            buyBtn.parent.removeChild(buyBtn);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(energyMc)
         {
            ObjectUtils.disposeViolentMc(energyMc);
         }
         energyMc = null;
         if(redMc)
         {
            ObjectUtils.disposeViolentMc(redMc);
         }
         redMc = null;
         if(yellowMc)
         {
            ObjectUtils.disposeViolentMc(yellowMc);
         }
         yellowMc = null;
         if(greenMc)
         {
            ObjectUtils.disposeViolentMc(greenMc);
         }
         greenMc = null;
         if(closeBtn)
         {
            ObjectUtils.disposeObject(closeBtn);
         }
         closeBtn = null;
         if(searchBtn)
         {
            ObjectUtils.disposeObject(searchBtn);
         }
         searchBtn = null;
         if(helpBtn)
         {
            ObjectUtils.disposeObject(helpBtn);
         }
         helpBtn = null;
         if(leftText)
         {
            ObjectUtils.disposeObject(leftText);
         }
         leftText = null;
         if(mcContiner)
         {
            ObjectUtils.disposeAllChildren(mcContiner);
         }
         if(digBtn)
         {
            ObjectUtils.disposeObject(digBtn);
         }
         digBtn = null;
         ObjectUtils.disposeObject(archaeologyBtn);
         archaeologyBtn = null;
         ObjectUtils.disposeObject(stargazingBtn);
         stargazingBtn = null;
         ObjectUtils.disposeObject(buyBtn);
         buyBtn = null;
         if(_operaMediator)
         {
            ObjectUtils.disposeObject(_operaMediator);
         }
         _operaMediator = null;
         buyConfigTemp = null;
         super.dispose();
      }
   }
}

