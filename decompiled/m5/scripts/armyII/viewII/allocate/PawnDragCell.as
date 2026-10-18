package armyII.viewII.allocate
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.ArmyControler;
   import mvc.module.armyII.ArmyPawn;
   import mvc.module.armyII.UserArmy;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.GameDrag;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.PawnContain;
   
   public class PawnDragCell extends PawnContain
   {
      
      public static const P_closeStyle:String = "closeStyle";
      
      public static const P_upgradeStyle:String = "upgradeStyle";
      
      private var _closeStyle:String;
      
      private var _upgradeStyle:String;
      
      private var _closeBtn:BaseButton;
      
      private var _upgradeBtn:TextButton;
      
      public function PawnDragCell()
      {
         super();
         dragEnable = true;
      }
      
      public function set closeStyle(param1:String) : void
      {
         _closeStyle = param1;
         onPropertiesChanged("closeStyle");
      }
      
      public function set upgradeStyle(param1:String) : void
      {
         _upgradeStyle = param1;
         onPropertiesChanged("upgradeStyle");
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["closeStyle"])
         {
            _closeBtn = ComponentFactory.Instance.creatComponentByStylename(_closeStyle);
            _closeBtn.visible = false;
         }
         if(_changedPropeties["upgradeStyle"])
         {
            _upgradeBtn = ComponentFactory.Instance.creatComponentByStylename(_upgradeStyle);
            _upgradeBtn.text = LanguageMgr.GetTranslation("armyII.viewII.allocate.upgrade");
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_closeBtn)
         {
            addChild(_closeBtn);
         }
         if(_upgradeBtn)
         {
            addChild(_upgradeBtn);
         }
      }
      
      override public function set pawn(param1:ArmyPawn) : void
      {
         super.pawn = param1;
         initEvent();
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function refreshView() : void
      {
         super.refreshView();
         if(icon.icon == null)
         {
            if(_upgradeBtn)
            {
               _upgradeBtn.visible = false;
            }
         }
         else if(_upgradeBtn)
         {
            _upgradeBtn.visible = true;
            _upgradeBtn.enable = ArmyManager.instance.canUpgradePawn(pawn) && thane.grades >= 8;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
         if(_closeBtn)
         {
            _closeBtn.addEventListener("click",__dismissHandler);
         }
         if(_upgradeBtn)
         {
            _upgradeBtn.addEventListener("click",__upgradeHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHandler);
         if(_closeBtn)
         {
            _closeBtn.removeEventListener("click",__dismissHandler);
         }
         if(_upgradeBtn)
         {
            _upgradeBtn.removeEventListener("click",__upgradeHandler);
         }
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         if(_closeBtn && pawn && pawn.ownPawns > 0)
         {
            _closeBtn.visible = true;
         }
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         if(_closeBtn)
         {
            _closeBtn.visible = false;
         }
      }
      
      private function __dismissHandler(param1:MouseEvent) : void
      {
         if(pawn && pawn.ownPawns > 0)
         {
            control.openDissmissFrame(this);
         }
      }
      
      private function __upgradeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(pawn)
         {
            control.startFrameByType(ArmyPanelEnum.PAWNUPGRADE,pawn);
         }
      }
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:ArmyPawn = null;
         var _loc2_:ArmyPawn = null;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         if(!pawn || pawn.ownPawns == 0)
         {
            return;
         }
         var _loc8_:int = int(ArmyManager.instance.army.getEmputyPos());
         var _loc7_:int = int(army.baseHero.attackProrerty.totalConatArmy);
         if(_loc8_ == 0)
         {
            _loc4_ = int(_loc7_ > pawn.ownPawns ? pawn.ownPawns : _loc7_);
            ArmyManager.instance.army.addNewPawnByIndex(_loc8_,pawn,_loc4_);
            ArmyManager.instance.removePawnCountById(pawn.templateId,_loc4_);
            control.sendMovePawnInfo();
         }
         else
         {
            _loc5_ = ArmyManager.instance.army.getPawnByIndex(0);
            _loc2_ = ArmyManager.instance.army.getPawnByIndex(1);
            if(_loc5_.ownPawns > 0 && _loc5_.templateId == pawn.templateId)
            {
               if(_loc5_.ownPawns >= _loc7_)
               {
                  return;
               }
               _loc4_ = _loc7_ - _loc5_.ownPawns;
               _loc4_ = int(_loc4_ > pawn.ownPawns ? pawn.ownPawns : _loc4_);
               ArmyManager.instance.army.addArmyPawnCountByIndex(0,_loc4_);
               ArmyManager.instance.removePawnCountById(pawn.templateId,_loc4_);
               control.sendMovePawnInfo();
            }
            else
            {
               _loc3_ = int(_loc5_.templateId);
               _loc6_ = int(_loc5_.ownPawns);
               _loc4_ = int(_loc7_ > pawn.ownPawns ? pawn.ownPawns : _loc7_);
               ArmyManager.instance.army.addNewPawnByIndex(0,pawn,_loc4_);
               pawn.ownPawns -= _loc4_;
               pawn.commit();
               ArmyManager.instance.addPawnCountById(_loc3_,_loc6_);
               control.sendMovePawnInfo();
            }
         }
      }
      
      override protected function onDragStop(param1:GameDrag) : void
      {
         var _loc2_:SoldierDragCell = null;
         if(param1.dropTarget != this)
         {
            if(param1.dropTarget is PawnContain)
            {
               if(param1.dropTarget is PawnDragCell)
               {
                  param1.stopImmediatePropagation();
               }
               else if(param1.dropTarget is SoldierDragCell)
               {
                  _loc2_ = param1.dropTarget as SoldierDragCell;
                  if(_loc2_.isLock)
                  {
                     __iTEM_DROP_BagNotic();
                     return;
                  }
                  adjustArmy(this,_loc2_);
               }
            }
            else
            {
               param1.stopImmediatePropagation();
            }
         }
         __iTEM_DROP_BagNotic();
      }
      
      private function getSamePawnNumber(param1:PawnDragCell, param2:SoldierDragCell) : int
      {
         var _loc4_:int = int(param2.pawn.ownPawns);
         var _loc6_:int = int(param1.pawn.templateInfo.NeedPopulation);
         var _loc3_:int = int(param1.pawn.ownPawns);
         var _loc5_:int = army.baseHero.attackProrerty.totalConatArmy / _loc6_;
         if(_loc5_ <= _loc3_)
         {
            return _loc5_ - _loc4_;
         }
         if(_loc4_ + _loc3_ >= _loc5_)
         {
            return _loc5_ - _loc4_;
         }
         return _loc3_;
      }
      
      private function getDifPawnNumber(param1:PawnDragCell, param2:SoldierDragCell) : int
      {
         var _loc3_:int = int(param1.pawn == null ? 0 : param1.pawn.ownPawns);
         var _loc5_:int = int(param1.pawn.templateInfo.NeedPopulation);
         var _loc4_:int = army.baseHero.attackProrerty.totalConatArmy / _loc5_;
         return _loc4_ <= _loc3_ ? _loc4_ : _loc3_;
      }
      
      private function adjustArmy(param1:PawnDragCell, param2:SoldierDragCell) : void
      {
         var _loc3_:int = 0;
         if(param2.pawn && param2.pawn.ownPawns != 0)
         {
            if(param2.pawn.templateId == param1.pawn.templateId)
            {
               if(param2.pawn.ownPawns == army.baseHero.attackProrerty.totalConatArmy)
               {
                  return;
               }
               _loc3_ = getSamePawnNumber(param1,param2);
            }
            else
            {
               _loc3_ = getDifPawnNumber(param1,param2);
            }
         }
         else
         {
            _loc3_ = getDifPawnNumber(param1,param2);
         }
         var _loc4_:AdjustPawnFrame = ComponentFactory.Instance.creatComponentByStylename("army.AdjustPawnFrame");
         _loc4_.target = param2;
         _loc4_.self = param1;
         _loc4_.count = _loc3_;
         _loc4_.show();
      }
      
      private function get control() : ArmyControler
      {
         return FrameControllerManager.instance.armyController;
      }
      
      private function get army() : UserArmy
      {
         return ArmyManager.instance.army;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function get icon() : BaseIconView
      {
         return _icon;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

