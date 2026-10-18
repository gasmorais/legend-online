package armyII.viewII.lineUp
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedIconTextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.PawnEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.controler.ArmyControler;
   import mvc.module.armyII.ArmyPawn;
   import mvc.module.armyII.UserArmy;
   import mvc.module.children.ChildData;
   import mvc.module.monster.MonsterInfo;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.MonsterManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class LineUpLeftItem extends Sprite implements Disposeable
   {
      
      private var _back:ScaleFrameImage;
      
      private var _headItem:BaseIconView;
      
      private var _hasNumTxt:FilterFrameText;
      
      private var _deleteBtn:BaseButton;
      
      private var _upgradeBtn:IconButton;
      
      private var _enterWarbg:Bitmap;
      
      private var _enterWarBtn:SelectedIconTextButton;
      
      private var _data:ArmyPawn;
      
      private var _enable:Boolean = true;
      
      private var _preClickTime:Number;
      
      private var _preSelected:Boolean;
      
      public function LineUpLeftItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("army.PawnBack");
         _headItem = ComponentFactory.Instance.creatCustomObject("army.PawnDragCellIcon");
         _hasNumTxt = ComponentFactory.Instance.creatComponentByStylename("army.PawnDragCellText");
         _deleteBtn = ComponentFactory.Instance.creatComponentByStylename("army.StorePawnClose");
         _upgradeBtn = ComponentFactory.Instance.creatComponentByStylename("army.skill.soldierUpgradeBtn");
         _enterWarbg = ComponentFactory.Instance.creatBitmap("asset.army.LineUpLeftItem.enterWarbg");
         _enterWarBtn = ComponentFactory.Instance.creatComponentByStylename("army.skill.enterWarBtn");
         addChild(_back);
         addChild(_headItem);
         addChild(_hasNumTxt);
         addChild(_deleteBtn);
         _deleteBtn.visible = false;
         addChild(_upgradeBtn);
         _upgradeBtn.visible = false;
         addChild(_enterWarbg);
         addChild(_enterWarBtn);
      }
      
      private function initEvent() : void
      {
         _deleteBtn.addEventListener("click",__deleteHandler);
         _upgradeBtn.addEventListener("click",__upgradeHandler);
         _enterWarBtn.addEventListener("click",__enterWarSelectHandler);
      }
      
      private function removeEvent() : void
      {
         if(_deleteBtn)
         {
            _deleteBtn.removeEventListener("click",__deleteHandler);
         }
         if(_upgradeBtn)
         {
            _upgradeBtn.removeEventListener("click",__upgradeHandler);
         }
         if(_enterWarBtn)
         {
            _enterWarBtn.removeEventListener("click",__enterWarSelectHandler);
         }
      }
      
      private function initDataEvent() : void
      {
         this.addEventListener("mouseOver",__mouseOverHandler);
         this.addEventListener("mouseOut",__mouseOutHandler);
         if(_data)
         {
            _data.addEventListener("pawnProppertyChager",__propertiesChanged);
         }
      }
      
      private function removeDataEvent() : void
      {
         this.removeEventListener("mouseOver",__mouseOverHandler);
         this.removeEventListener("mouseOut",__mouseOutHandler);
         if(_data)
         {
            _data.removeEventListener("pawnProppertyChager",__propertiesChanged);
         }
      }
      
      private function __enterWarSelectHandler(param1:MouseEvent) : void
      {
         var _loc12_:ArmyPawn = null;
         var _loc6_:ArmyPawn = null;
         var _loc4_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:int = int(userArmy.baseHero.attackProrerty.totalConatArmy);
         if(_loc7_ <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("LineUpLeftItem.totalConatArmy.noCount"));
            _enterWarBtn.selected = _preSelected;
            return;
         }
         var _loc13_:Number = getTimer();
         if(_loc13_ - _preClickTime < 1000)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            _enterWarBtn.selected = _preSelected;
            return;
         }
         _preClickTime = _loc13_;
         var _loc2_:int = int(_data.templateId);
         var _loc3_:ArmyPawn = userArmy.getPawnByIndex(0);
         var _loc11_:int = int(_loc3_.ownPawns);
         if(_enterWarBtn.selected)
         {
            _loc4_ = int(pawn == null ? 0 : pawn.ownPawns);
            _loc9_ = int(pawn.templateInfo.NeedPopulation);
            _loc10_ = _loc7_ / _loc9_;
            _loc8_ = _loc4_ > _loc10_ ? _loc10_ : _loc4_;
            if(_loc3_.templateId != _loc2_ && _loc11_ != 0)
            {
               userArmy.removeArmyPawnCountByIndex(0,_loc11_);
               _loc12_ = ArmyManager.instance.getPawnById(_loc3_.templateId);
               _loc12_.ownPawns = _loc12_.ownPawns + _loc11_;
               _loc12_.commit();
            }
            _loc6_ = ArmyManager.instance.getPawnById(_loc2_);
            userArmy.addNewPawnByIndex(0,_loc6_,_loc8_);
            _loc6_.ownPawns -= _loc8_;
            _loc6_.commit();
            control.sendMovePawnInfo();
         }
         else
         {
            _loc5_ = int(userArmy.getPawnByIndex(0).ownPawns);
            ArmyManager.instance.army.removeArmyPawnCountByIndex(0,_loc5_);
            ArmyManager.instance.addPawnCountById(_loc2_,_loc5_);
            control.sendMovePawnInfo();
         }
         ArmyManager.instance.dispatchEvent(new PawnEvent("ENTERWAR_PAWN_SELECT",null));
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         if(_data)
         {
            _deleteBtn.visible = true;
         }
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         _deleteBtn.visible = false;
      }
      
      private function get userArmy() : UserArmy
      {
         return ArmyManager.instance.army;
      }
      
      private function __deleteHandler(param1:MouseEvent) : void
      {
         if(data && data.ownPawns > 0)
         {
            control.openDissmissFrame(this);
         }
      }
      
      private function __upgradeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(data)
         {
            control.startFrameByType(ArmyPanelEnum.PAWNUPGRADE,data);
         }
      }
      
      public function set data(param1:ArmyPawn) : void
      {
         clean();
         removeDataEvent();
         _data = param1;
         if(_data)
         {
            initDataEvent();
            refreshView();
         }
      }
      
      private function __propertiesChanged(param1:PawnEvent = null) : void
      {
         refreshView();
      }
      
      private function clean() : void
      {
         if(_hasNumTxt)
         {
            _hasNumTxt.text = "";
         }
         if(_headItem)
         {
            _headItem.icon = null;
            _headItem.tipData = null;
         }
         if(_upgradeBtn)
         {
            _upgradeBtn.visible = true;
            _upgradeBtn.enable = false;
         }
         if(_deleteBtn)
         {
            _deleteBtn.enable = false;
         }
         if(_enterWarBtn)
         {
            _enterWarBtn.text = "";
            _enterWarBtn.selected = false;
            _enterWarBtn.enable = false;
         }
         buttonMode = false;
         enable = false;
      }
      
      private function refreshView() : void
      {
         if(_data)
         {
            if(_hasNumTxt)
            {
               _hasNumTxt.text = _data.ownPawns.toString();
            }
            if(_headItem)
            {
               _headItem.tipData = _data;
               _headItem.icon = IconFactory.getSoldierIconByIcon(_data.templateInfo.Icon);
            }
            if(_upgradeBtn)
            {
               _upgradeBtn.visible = true;
               _upgradeBtn.enable = true;
            }
            if(_deleteBtn && _data.ownPawns > 0)
            {
               _deleteBtn.enable = true;
            }
            if(_enterWarBtn)
            {
               if(userArmy.armyPawns[0].templateId == _data.templateId && userArmy.armyPawns[0].ownPawns > 0)
               {
                  _enterWarBtn.text = LanguageMgr.GetTranslation("pet.PetFrame.enterWar");
                  _enterWarBtn.selected = true;
               }
               else
               {
                  _enterWarBtn.text = LanguageMgr.GetTranslation("pet.PetFrame.unenterWar");
                  _enterWarBtn.selected = false;
               }
               _enterWarBtn.enable = true;
               _preSelected = _enterWarBtn.selected;
            }
            if(slavedChild || enterWarMonster)
            {
               _enterWarBtn.enable = false;
            }
            buttonMode = true;
            enable = true;
         }
      }
      
      public function get data() : ArmyPawn
      {
         return _data;
      }
      
      public function get pawn() : ArmyPawn
      {
         return _data;
      }
      
      public function get enable() : Boolean
      {
         return _enable;
      }
      
      public function set enable(param1:Boolean) : void
      {
         if(_enable == param1)
         {
            return;
         }
         _enable = param1;
         if(_enable)
         {
            filters = null;
         }
         else
         {
            filters = [UIFilter.getGrayFilter()];
         }
      }
      
      private function get slavedChild() : ChildData
      {
         return ChildManager.instance.model.getSlavedEnterWar();
      }
      
      private function get enterWarMonster() : MonsterInfo
      {
         return MonsterManager.instance.model.enterWarMonster;
      }
      
      private function get control() : ArmyControler
      {
         return FrameControllerManager.instance.armyController;
      }
      
      public function dispose() : void
      {
         removeDataEvent();
         removeEvent();
         ObjectUtils.disposeAllChildren(_back);
         _back = null;
         ObjectUtils.disposeObject(_headItem);
         _headItem = null;
         ObjectUtils.disposeObject(_hasNumTxt);
         _hasNumTxt = null;
         ObjectUtils.disposeObject(_deleteBtn);
         _deleteBtn = null;
         ObjectUtils.disposeObject(_upgradeBtn);
         _upgradeBtn = null;
         ObjectUtils.disposeObject(_enterWarbg);
         _enterWarbg = null;
         ObjectUtils.disposeObject(_enterWarBtn);
         _enterWarBtn = null;
      }
   }
}

