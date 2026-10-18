package armyII.viewII.lineUp
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ArmyEvent;
   import events.PawnEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.controler.ArmyControler;
   import mvc.module.armyII.ArmyPawn;
   import mvc.module.armyII.UserArmy;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   
   public class LineupLeftView extends Sprite implements Disposeable
   {
      
      private var _vBox:VBox;
      
      private var _recruitBtn:IconButton;
      
      private var _itemList:Array;
      
      public function LineupLeftView()
      {
         super();
         initView();
         initEvent();
         initData();
         refreshData();
      }
      
      private function initView() : void
      {
         _itemList = [];
         _vBox = ComponentFactory.Instance.creatComponentByStylename("army.skill.LineUp.vbox");
         _recruitBtn = ComponentFactory.Instance.creatComponentByStylename("army.skill.lineUpRecruitBtn");
         addChild(_vBox);
         addChild(_recruitBtn);
      }
      
      private function initEvent() : void
      {
         _recruitBtn.addEventListener("click",__recruitHandler);
         userArmy.addEventListener("ARMY_PAWN_CHANGE",__pawnChangeHandler);
         thane.addEventListener("THANE_INFO_UPDATE",__updateHandler);
         ArmyManager.instance.addEventListener("ARMY_PAWN_CHANGE",__pawnChangeHandler);
         ArmyManager.instance.addEventListener("ENTERWAR_PAWN_SELECT",__updateEnterPawnHandler);
      }
      
      private function removeEvent() : void
      {
         _recruitBtn.removeEventListener("click",__recruitHandler);
         userArmy.removeEventListener("ARMY_PAWN_CHANGE",__pawnChangeHandler);
         thane.removeEventListener("THANE_INFO_UPDATE",__updateHandler);
         ArmyManager.instance.removeEventListener("ARMY_PAWN_CHANGE",__pawnChangeHandler);
         ArmyManager.instance.removeEventListener("ENTERWAR_PAWN_SELECT",__updateEnterPawnHandler);
      }
      
      private function __recruitHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         control.startFrameByType(ArmyPanelEnum.RECRUIT_PAWN);
      }
      
      private function __updateEnterPawnHandler(param1:PawnEvent) : void
      {
         refreshData();
      }
      
      private function __updateHandler(param1:PlayerEvent) : void
      {
         refreshData();
      }
      
      private function __pawnChangeHandler(param1:ArmyEvent) : void
      {
         refreshData();
      }
      
      private function initData() : void
      {
         var _loc2_:int = 0;
         var _loc1_:LineUpLeftItem = null;
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("arrmy.LineupLeftItem");
            _vBox.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function refreshData() : void
      {
         var _loc2_:LineUpLeftItem = null;
         var _loc1_:* = null;
         var _loc4_:int = 0;
         var _loc5_:Array = ArmyManager.instance.castlePawnList.getList();
         _loc5_ = filterByCount(_loc5_);
         _loc5_.sort(sortByNeedBuild);
         var _loc3_:int = int(_loc5_.length);
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc2_ = _itemList[_loc4_];
            if(_loc4_ < _loc3_)
            {
               _loc2_.data = _loc5_[_loc4_] as ArmyPawn;
            }
            else
            {
               _loc2_.data = null;
            }
            _loc4_++;
         }
      }
      
      private function sortByNeedBuild(param1:ArmyPawn, param2:ArmyPawn) : int
      {
         var _loc4_:int = int(param1.templateInfo.NeedBuilding);
         var _loc3_:int = int(param2.templateInfo.NeedBuilding);
         if(_loc4_ > _loc3_)
         {
            return 1;
         }
         if(_loc4_ < _loc3_)
         {
            return -1;
         }
         return 0;
      }
      
      private function filterByCount(param1:Array) : Array
      {
         var _loc6_:ArmyPawn = null;
         var _loc5_:int = 0;
         var _loc2_:Array = [];
         var _loc4_:int = int(param1.length);
         var _loc3_:ArmyPawn = userArmy.getPawnByIndex(0);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = param1[_loc5_] as ArmyPawn;
            if(_loc6_.ownPawns > 0 || _loc6_.templateId == _loc3_.templateId && _loc3_.ownPawns > 0)
            {
               _loc2_.push(param1[_loc5_]);
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      private function get userArmy() : UserArmy
      {
         return ArmyManager.instance.army;
      }
      
      private function get thane() : ThaneInfo
      {
         return userArmy.baseHero;
      }
      
      private function get control() : ArmyControler
      {
         return FrameControllerManager.instance.armyController;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         ObjectUtils.disposeAllGrandson(_vBox);
         if(_vBox)
         {
            ObjectUtils.disposeObject(_vBox);
         }
         _vBox = null;
         if(_recruitBtn)
         {
            ObjectUtils.disposeObject(_recruitBtn);
         }
         _recruitBtn = null;
         _loc1_ = 0;
         while(_loc1_ < _itemList.length)
         {
            ObjectUtils.disposeObject(_itemList[_loc1_]);
            _itemList[_loc1_] = null;
            _loc1_++;
         }
         _itemList = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

