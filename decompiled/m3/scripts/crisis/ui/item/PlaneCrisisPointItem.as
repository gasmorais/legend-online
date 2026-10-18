package crisis.ui.item
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import crisis.ui.PlaneCrisisArmyView;
   import crisis.ui.PlaneCrisisComBitData;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.crisis.PlaneCrisisArmy;
   import mvc.module.crisis.PlaneCrisisEventType;
   import mvc.module.crisis.PlaneCrisisModel;
   import mvc.module.crisis.PlaneCrisisNodeInfo;
   import mvc.module.crisis.PlaneCrisisPlayerInfo;
   import yishi.datas.templates.PlaneCrisisEventTempInfo;
   import yishi.datas.templates.PlaneCrisisTempInfo;
   import yishi.manager.PlaneCrisisManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class PlaneCrisisPointItem extends Sprite
   {
      
      private var _cloud:Bitmap;
      
      private var _good:Bitmap;
      
      private var _teamContainer:SimpleTileList;
      
      private var _mouseSp:Component;
      
      private var _btnContainer:Sprite;
      
      private var _btnBack:Bitmap;
      
      private var _invateBtn:BaseButton;
      
      private var _attackBtn:BaseButton;
      
      private var _transBtn:BaseButton;
      
      private var _data:PlaneCrisisNodeInfo;
      
      private var _tempInfo:PlaneCrisisTempInfo;
      
      private var _eventTemp:PlaneCrisisEventTempInfo;
      
      public function PlaneCrisisPointItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _cloud = new Bitmap();
         _good = new Bitmap();
         _teamContainer = ComponentFactory.Instance.creatCustomObject("planecrisis.teamBox",[2]);
         _btnContainer = ComponentFactory.Instance.creatCustomObject("planecrisis.pointOpperSp");
         _mouseSp = ComponentFactory.Instance.creatComponentByStylename("ui.planecrisis.pointGoodSp");
         addChild(_cloud);
         addChild(_teamContainer);
         addChild(_mouseSp);
         _mouseSp.addChild(_good);
         _mouseSp.addChild(_btnContainer);
         _cloud.rotation = 45;
         _cloud.x = 2;
         _cloud.y = -60;
         _good.x = -50;
         _good.y = -70;
         _teamContainer.mouseEnabled = false;
      }
      
      private function initEvent() : void
      {
         _mouseSp.addEventListener("rollOver",overHandler);
         _mouseSp.addEventListener("rollOut",outHandler);
         addEventListener("click",clickMoveHandler);
      }
      
      private function removeEvent() : void
      {
         _mouseSp.removeEventListener("rollOver",overHandler);
         _mouseSp.removeEventListener("rollOut",outHandler);
         removeEventListener("click",clickMoveHandler);
      }
      
      private function clickMoveHandler(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         var _loc2_:PlaneCrisisArmy = model.selfArmy;
         if(_loc2_ != null && _tempInfo != null)
         {
            if(_loc2_.standNodeId == _tempInfo.NodeId)
            {
               return;
            }
            if(isConnect(_loc2_.standNodeId))
            {
               if(!_loc2_.isMoving)
               {
                  if(model.selfInfo.actionNum >= model.oneStepMoveNum)
                  {
                     PlaneCrisisManager.Instance.gameOp(10,_tempInfo.NodeId);
                  }
                  else
                  {
                     PlaneCrisisManager.Instance.alertBuy();
                  }
               }
            }
            else
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("planeCrisis.cannotMoveTip"));
            }
         }
      }
      
      private function tranEndBoss() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("planeCrisis.tranToEndBoss");
         SimpleAlertHelper.instance.data = [doTranEndBoss];
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,true);
      }
      
      private function doTranEndBoss(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            PlaneCrisisManager.Instance.gameOp(8);
         }
      }
      
      private function overHandler(param1:MouseEvent = null) : void
      {
         if(_btnBack != null)
         {
            _btnBack.visible = true;
         }
         if(_invateBtn != null)
         {
            _invateBtn.visible = true;
            if(_tempInfo && model.selfArmy.standNodeId == _tempInfo.NodeId)
            {
               if(_eventTemp.bossTransNum > 0)
               {
                  _invateBtn.enable = true;
               }
               else
               {
                  _invateBtn.enable = false;
               }
            }
            else
            {
               _invateBtn.enable = false;
            }
         }
         if(_attackBtn != null)
         {
            _attackBtn.visible = true;
            if(_tempInfo && model.selfArmy.standNodeId == _tempInfo.NodeId)
            {
               _attackBtn.enable = true;
            }
            else
            {
               _attackBtn.enable = false;
            }
         }
         if(_transBtn != null)
         {
            _transBtn.visible = true;
            _invateBtn.visible = false;
            if(_tempInfo && model.selfArmy.standNodeId == _tempInfo.NodeId)
            {
               _transBtn.enable = false;
            }
            else
            {
               _transBtn.enable = true;
            }
         }
      }
      
      private function outHandler(param1:MouseEvent = null) : void
      {
         if(_btnBack != null)
         {
            _btnBack.visible = false;
         }
         if(_invateBtn != null)
         {
            _invateBtn.visible = false;
         }
         if(_attackBtn != null)
         {
            _attackBtn.visible = false;
         }
         if(_transBtn != null)
         {
            _transBtn.visible = false;
         }
      }
      
      public function get isCanShowAvater() : Boolean
      {
         if(_teamContainer.numChildren < 2 && _good.bitmapData == null)
         {
            return true;
         }
         return false;
      }
      
      public function isConnect(param1:int) : Boolean
      {
         if(_tempInfo == null)
         {
            return false;
         }
         return Boolean(_tempInfo.isConnect(param1));
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_good)
         {
            TweenMax.killTweensOf(_good);
         }
         deleteOppBtns();
         ObjectUtils.disposeObject(_cloud);
         _cloud = null;
         ObjectUtils.disposeObject(_good);
         _good = null;
         ObjectUtils.disposeObject(_teamContainer);
         _teamContainer = null;
         ObjectUtils.disposeObject(_mouseSp);
         _mouseSp = null;
         ObjectUtils.disposeObject(_btnContainer);
         _btnContainer = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
         _tempInfo = null;
         _eventTemp = null;
      }
      
      private function creatOppBtns() : void
      {
         if(_btnBack == null)
         {
            _btnBack = ComponentFactory.Instance.creatBitmap("asset.planecrisis.oppBack");
            _btnContainer.addChild(_btnBack);
            _btnBack.visible = false;
         }
         if(_invateBtn == null)
         {
            _invateBtn = ComponentFactory.Instance.creatComponentByStylename("planecrisis.inviateBtn");
            _invateBtn.addEventListener("click",invateHandler);
            _btnContainer.addChild(_invateBtn);
            _invateBtn.visible = false;
            _invateBtn.enable = false;
         }
         if(_attackBtn == null)
         {
            _attackBtn = ComponentFactory.Instance.creatComponentByStylename("planecrisis.attackBtn");
            _attackBtn.addEventListener("click",attackHandler);
            _btnContainer.addChild(_attackBtn);
            _attackBtn.visible = false;
            _attackBtn.enable = false;
         }
         if(_data && _data.eventType == PlaneCrisisEventType.END_BOSS && _transBtn == null)
         {
            _transBtn = ComponentFactory.Instance.creatComponentByStylename("planecrisis.transBtn");
            _transBtn.addEventListener("click",transHandler);
            _btnContainer.addChild(_transBtn);
            _transBtn.visible = false;
         }
      }
      
      private function deleteOppBtns() : void
      {
         if(_invateBtn)
         {
            _invateBtn.removeEventListener("click",invateHandler);
         }
         if(_attackBtn)
         {
            _attackBtn.removeEventListener("click",attackHandler);
         }
         if(_transBtn)
         {
            _attackBtn.removeEventListener("click",transHandler);
         }
         ObjectUtils.disposeObject(_invateBtn);
         _invateBtn = null;
         ObjectUtils.disposeObject(_attackBtn);
         _attackBtn = null;
         ObjectUtils.disposeObject(_transBtn);
         _transBtn = null;
         ObjectUtils.disposeObject(_btnBack);
         _btnBack = null;
      }
      
      private function transHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         if(_data.isOpen && !_data.isPick)
         {
            tranEndBoss();
         }
      }
      
      private function invateHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         PlaneCrisisManager.Instance.gameOp(4);
         outHandler();
      }
      
      private function attackHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         outHandler();
         if(_data.eventType == PlaneCrisisEventType.END_BOSS)
         {
            attackEndBoss();
         }
         else if(model.selfInfo.actionNum >= _eventTemp.bossAttackNum)
         {
            PlaneCrisisManager.Instance.confrimAttackBoss(_eventTemp.bossAttackNum);
         }
         else
         {
            PlaneCrisisManager.Instance.alertBuy();
         }
      }
      
      private function attackEndBoss() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("planeCrisis.doAttack");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("planeCrisis.attackEndBoss");
         if(model.hasOnffLineTeamer)
         {
            _loc4_ += "\n" + LanguageMgr.GetTranslation("planeCrisis.offLineAttackTip");
         }
         SimpleAlertHelper.instance.data = [doAttackEndBoss];
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,true,true);
      }
      
      private function doAttackEndBoss(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            PlaneCrisisManager.Instance.gameOp(3);
         }
      }
      
      public function leveOffPoints(param1:int) : void
      {
         var _loc5_:Bitmap = null;
         var _loc4_:int = 0;
         var _loc2_:int = int(_teamContainer.numChildren);
         var _loc3_:String = "" + param1;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = _teamContainer.getChildAt(_loc4_) as Bitmap;
            if(_loc5_.name == _loc3_)
            {
               break;
            }
            _loc4_++;
         }
         if(_loc5_ != null)
         {
            _teamContainer.beginChanges();
            _teamContainer.removeChild(_loc5_);
            _teamContainer.commitChanges();
         }
         outHandler();
      }
      
      public function showTeams() : void
      {
         var _loc2_:Bitmap = null;
         var _loc4_:int = 0;
         if(_data == null)
         {
            return;
         }
         var _loc6_:Dictionary = model.planeCrisisInfoDic;
         var _loc5_:Array = [];
         for each(var _loc3_:PlaneCrisisPlayerInfo in _loc6_)
         {
            if(_loc3_.armyData.standNodeId == _data.nodeId)
            {
               _loc5_.push(_loc3_.color);
            }
         }
         var _loc1_:int = int(_loc5_.length);
         if(_loc1_ > 0 && _data != null)
         {
            _loc5_.sort(16);
            if(_teamContainer)
            {
               _teamContainer.removeAllChild();
            }
            _teamContainer.beginChanges();
            _loc4_ = 0;
            while(_loc4_ < _loc1_)
            {
               if(_loc1_ == 1)
               {
                  if(!_data.isPick && (_data.eventType == PlaneCrisisEventType.END_BOSS || _data.eventType == PlaneCrisisEventType.TRAP_BOSS || _data.eventType == PlaneCrisisEventType.MIDDLE_BOSS))
                  {
                     _loc2_ = PlaneCrisisComBitData.Instance.colorDic[_loc5_[_loc4_]];
                     _loc2_.name = "" + _loc5_[_loc4_];
                     _teamContainer.addChild(_loc2_);
                  }
               }
               else
               {
                  _loc2_ = PlaneCrisisComBitData.Instance.colorDic[_loc5_[_loc4_]];
                  _loc2_.name = "" + _loc5_[_loc4_];
                  _teamContainer.addChild(_loc2_);
               }
               _loc4_++;
            }
            _teamContainer.commitChanges();
            if(_teamContainer.numChildren > 0)
            {
               hideArmyView(_tempInfo.NodeId);
               if(!_data.isPick)
               {
                  _teamContainer.x = -65;
                  _teamContainer.y = -28;
               }
               else
               {
                  _teamContainer.x = -20;
                  _teamContainer.y = -20;
               }
            }
            else
            {
               showArmyView(_data.nodeId);
            }
         }
         else if(_teamContainer)
         {
            _teamContainer.removeAllChild();
         }
         overHandler();
      }
      
      private function hideArmyView(param1:int) : void
      {
         var _loc3_:Dictionary = model.armyViewDic;
         for each(var _loc2_:PlaneCrisisArmyView in _loc3_)
         {
            if(_loc2_.data.standNodeId == param1)
            {
               _loc2_.visible = false;
            }
         }
      }
      
      private function showArmyView(param1:int) : void
      {
         var _loc3_:Dictionary = model.armyViewDic;
         for each(var _loc2_:PlaneCrisisArmyView in _loc3_)
         {
            if(_loc2_.data.standNodeId == param1)
            {
               _loc2_.visible = true;
            }
         }
      }
      
      private function get model() : PlaneCrisisModel
      {
         return PlaneCrisisManager.Instance.model;
      }
      
      public function get data() : PlaneCrisisNodeInfo
      {
         return _data;
      }
      
      public function set data(param1:PlaneCrisisNodeInfo) : void
      {
         _data = param1;
         if(_data != null)
         {
            _eventTemp = _data.eventTempInfo;
            if(_eventTemp != null)
            {
               _mouseSp.tipData = _eventTemp.Description;
            }
            else
            {
               _mouseSp.tipData = null;
            }
            if(_data.isPick)
            {
               deleteOppBtns();
               _cloud.bitmapData = PlaneCrisisComBitData.Instance.cloudGray;
               if(!_data.isPlay)
               {
                  playMovie();
                  _data.isPlay = true;
               }
               else
               {
                  if(_good.bitmapData != null)
                  {
                     showTeams();
                  }
                  _good.bitmapData = null;
               }
            }
            else if(_data.isOpen)
            {
               switch(_data.eventType)
               {
                  case PlaneCrisisEventType.END_BOSS:
                     _good.bitmapData = PlaneCrisisComBitData.Instance.eventBigBoss;
                     creatOppBtns();
                     break;
                  case PlaneCrisisEventType.TRAP_BOSS:
                     _good.bitmapData = PlaneCrisisComBitData.Instance.eventSmallBoss;
                     creatOppBtns();
                     break;
                  case PlaneCrisisEventType.MIDDLE_BOSS:
                     _good.bitmapData = PlaneCrisisComBitData.Instance.eventSmallBoss;
                     creatOppBtns();
                     break;
                  case PlaneCrisisEventType.DISPERSE_GOG:
                     _good.bitmapData = PlaneCrisisComBitData.Instance.eventCloud;
                     break;
                  case PlaneCrisisEventType.TREASURE_BOX:
                     _good.bitmapData = PlaneCrisisComBitData.Instance.eventBox;
                     break;
                  case PlaneCrisisEventType.KEY:
                     _good.bitmapData = PlaneCrisisComBitData.Instance.eventKey;
                     break;
                  case PlaneCrisisEventType.CRYSTAL:
                     _good.bitmapData = PlaneCrisisComBitData.Instance.eventElargment;
                     break;
                  case PlaneCrisisEventType.REWARD:
                     _good.bitmapData = PlaneCrisisComBitData.Instance.eventRewardBox;
                     break;
                  default:
                     _good.bitmapData = null;
               }
            }
            else
            {
               _good.bitmapData = null;
            }
         }
         else
         {
            _eventTemp = null;
         }
      }
      
      public function playMovie() : void
      {
         if(_data != null)
         {
            switch(_data.eventType)
            {
               case PlaneCrisisEventType.DISPERSE_GOG:
                  _good.bitmapData = PlaneCrisisComBitData.Instance.eventCloud;
                  break;
               case PlaneCrisisEventType.TREASURE_BOX:
                  _good.bitmapData = PlaneCrisisComBitData.Instance.eventBox;
                  break;
               case PlaneCrisisEventType.KEY:
                  _good.bitmapData = PlaneCrisisComBitData.Instance.eventKey;
                  break;
               case PlaneCrisisEventType.CRYSTAL:
                  _good.bitmapData = PlaneCrisisComBitData.Instance.eventElargment;
                  break;
               case PlaneCrisisEventType.REWARD:
                  _good.bitmapData = PlaneCrisisComBitData.Instance.eventRewardBox;
                  break;
               default:
                  _good.bitmapData = null;
            }
            if(_good.bitmapData != null)
            {
               TweenMax.to(_good,1.2,{
                  "y":-200,
                  "onComplete":movieComplete
               });
            }
         }
      }
      
      private function movieComplete() : void
      {
         _good.bitmapData = null;
      }
      
      public function get tempInfo() : PlaneCrisisTempInfo
      {
         return _tempInfo;
      }
      
      public function get eventInfo() : PlaneCrisisEventTempInfo
      {
         return _eventTemp;
      }
      
      public function set tempInfo(param1:PlaneCrisisTempInfo) : void
      {
         if(_tempInfo == param1)
         {
            return;
         }
         _tempInfo = param1;
         if(_tempInfo != null)
         {
            this.x = _tempInfo.X;
            this.y = _tempInfo.Y;
            switch(int(_tempInfo.NodeType) - 10)
            {
               case 0:
                  _cloud.bitmapData = PlaneCrisisComBitData.Instance.cloudGreen;
                  break;
               case 1:
                  _cloud.bitmapData = PlaneCrisisComBitData.Instance.cloudRed;
                  break;
               case 2:
                  _cloud.bitmapData = PlaneCrisisComBitData.Instance.cloudYellow;
                  break;
               default:
                  _cloud.bitmapData = PlaneCrisisComBitData.Instance.cloudBlue;
            }
         }
         else
         {
            _cloud.bitmapData = null;
         }
      }
   }
}

