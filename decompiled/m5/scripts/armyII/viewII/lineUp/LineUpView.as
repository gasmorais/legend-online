package armyII.viewII.lineUp
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconTextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import events.ArmyEvent;
   import events.PawnEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.ArmySocketOutManager;
   import managers.ChildManager;
   import managers.DragonTalkerManager;
   import mvc.controler.ArmyControler;
   import mvc.module.armyII.ArmyPawn;
   import mvc.module.armyII.UserArmy;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildModel;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.monster.MonsterInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.MonsterManager;
   import yishi.utils.MsgMan;
   
   public class LineUpView extends Sprite implements Disposeable
   {
      
      private const FRONT_ROW_INDEX:int = 1;
      
      private const BACK_ROW_INDEX:int = 3;
      
      private var _bg:Bitmap;
      
      private var _armyBg:Bitmap;
      
      private var _leftView:LineupLeftView;
      
      private var _bottoms:Array;
      
      private var _tabGroup:SelectedButtonGroup;
      
      private var _fontBtn1:SelectedIconTextButton;
      
      private var _fontBtn2:SelectedIconTextButton;
      
      private var _backBtn1:SelectedIconTextButton;
      
      private var _backBtn2:SelectedIconTextButton;
      
      private var _thanePos:int;
      
      private var _childPos:int;
      
      private var _slavedChildPos:int;
      
      private var _pawnPos1:int;
      
      private var _pawnPos2:int;
      
      private var _monsterPos:int;
      
      private var _thaneFightPos:int;
      
      private var _pawnFightPos:int;
      
      private var _lastPosition:String;
      
      private var _currentPistion:String;
      
      private var heroPosArr:Array = [4,7,6,9];
      
      private var first:Boolean = false;
      
      public function LineUpView()
      {
         super();
         initView();
         initEvent();
         initPos();
         checkPos();
         _tabGroup.selectIndex = heroPosArr.indexOf(_thanePos);
         refreshView();
         control.setOldData();
      }
      
      private function get control() : ArmyControler
      {
         return FrameControllerManager.instance.armyController;
      }
      
      private function initView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:LineUpFormationItem = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.army.lineupBg");
         _armyBg = ComponentFactory.Instance.creatBitmap("asset.army.lineupBack");
         _leftView = ComponentFactory.Instance.creatCustomObject("arrmy.LineupLeftView");
         _fontBtn1 = ComponentFactory.Instance.creatComponentByStylename("army.LineUpView.fontBtn1");
         _fontBtn2 = ComponentFactory.Instance.creatComponentByStylename("army.LineUpView.fontBtn2");
         _backBtn1 = ComponentFactory.Instance.creatComponentByStylename("army.LineUpView.backBtn1");
         _backBtn2 = ComponentFactory.Instance.creatComponentByStylename("army.LineUpView.backBtn2");
         _tabGroup = new SelectedButtonGroup();
         _tabGroup.addSelectItem(_fontBtn1);
         _tabGroup.addSelectItem(_fontBtn2);
         _tabGroup.addSelectItem(_backBtn1);
         _tabGroup.addSelectItem(_backBtn2);
         addChild(_bg);
         addChild(_armyBg);
         addChild(_fontBtn1);
         addChild(_fontBtn2);
         addChild(_backBtn1);
         addChild(_backBtn2);
         addChild(_leftView);
         _fontBtn1.text = LanguageMgr.GetTranslation("army.LineUpView.fontBtn1.text");
         _fontBtn2.text = LanguageMgr.GetTranslation("army.LineUpView.fontBtn2.text");
         _backBtn1.text = LanguageMgr.GetTranslation("army.LineUpView.backBtn1.text");
         _backBtn2.text = LanguageMgr.GetTranslation("army.LineUpView.backBtn2.text");
         _bottoms = [];
         var _loc1_:Array = [{
            "x":312,
            "y":142
         },{
            "x":270,
            "y":190
         },{
            "x":227,
            "y":247
         },{
            "x":177,
            "y":307
         },{
            "x":506,
            "y":142
         },{
            "x":473,
            "y":190
         },{
            "x":432,
            "y":247
         },{
            "x":377,
            "y":307
         }];
         var _loc3_:Array = [3,6,9,12,1,4,7,10];
         _loc4_ = 0;
         while(_loc4_ < 8)
         {
            _loc2_ = new LineUpFormationItem(_loc3_[_loc4_]);
            _loc2_.x = _loc1_[_loc4_].x;
            _loc2_.y = _loc1_[_loc4_].y;
            addChild(_loc2_);
            _bottoms[_loc4_] = _loc2_;
            _loc4_++;
         }
      }
      
      private function initEvent() : void
      {
         userArmy.addEventListener("ARMY_PAWN_CHANGE",__pawnChangeHandler);
         thane.addEventListener("THANE_INFO_UPDATE",__updateHandler);
         ArmyManager.instance.addEventListener("ARMY_PAWN_CHANGE",__pawnChangeHandler);
         _tabGroup.addEventListener("change",__updateHeroPosHandler);
         ArmyManager.instance.addEventListener("ENTERWAR_PAWN_SELECT",__updateEnterPawnHandler);
         MsgMan.addObserver("DRAGON_TALKER_INFO_UPDATE",this,__updateDragonTalkerState);
      }
      
      private function removeEvent() : void
      {
         userArmy.removeEventListener("ARMY_PAWN_CHANGE",__pawnChangeHandler);
         thane.removeEventListener("THANE_INFO_UPDATE",__updateHandler);
         ArmyManager.instance.removeEventListener("ARMY_PAWN_CHANGE",__pawnChangeHandler);
         _tabGroup.removeEventListener("change",__updateHeroPosHandler);
         ArmyManager.instance.removeEventListener("ENTERWAR_PAWN_SELECT",__updateEnterPawnHandler);
         MsgMan.removeObserver("DRAGON_TALKER_INFO_UPDATE",this,__updateDragonTalkerState);
      }
      
      private function __updateDragonTalkerState(param1:String, param2:Object) : void
      {
         refreshHeroState();
      }
      
      private function __updateHeroPosHandler(param1:Event) : void
      {
         if(!first)
         {
            first = true;
            return;
         }
         _thanePos = heroPosArr[_tabGroup.selectIndex];
         cleanItemView();
         updatePosAndView();
         if(_lastPosition != _currentPistion)
         {
            thane.fightPos = _thaneFightPos;
            armyPawn.fightPos = _pawnFightPos;
            ArmySocketOutManager.sendEditArmyPos(thane.userId,thane.fightPos,armyPawn.fightPos);
            ArmyManager.instance.isSorted = true;
         }
      }
      
      private function __updateHandler(param1:PlayerEvent) : void
      {
         updatePosAndView();
      }
      
      private function __updateEnterPawnHandler(param1:PawnEvent) : void
      {
         cleanItemView();
         updatePosAndView();
      }
      
      private function __pawnChangeHandler(param1:ArmyEvent) : void
      {
         updatePosAndView();
      }
      
      private function updatePosAndView() : void
      {
         checkPos();
         refreshView();
      }
      
      private function getItemByPos(param1:int) : LineUpFormationItem
      {
         var _loc3_:Array = [3,6,9,12,1,4,7,10];
         var _loc2_:int = _loc3_.indexOf(param1);
         if(_loc2_ == -1)
         {
            return _bottoms[0];
         }
         return _bottoms[_loc2_];
      }
      
      private function initPos() : void
      {
         if(thane.fightPos == 1 && armyPawn.fightPos == 3)
         {
            _thanePos = 4;
         }
         else if(thane.fightPos == 3 && armyPawn.fightPos == 1)
         {
            _thanePos = 6;
         }
         else
         {
            _thanePos = 4;
         }
      }
      
      private function checkPos() : void
      {
         if(_thanePos == 4)
         {
            _pawnPos1 = 3;
            _pawnPos2 = 12;
            _childPos = 6;
            _slavedChildPos = 12;
            _monsterPos = 3;
            _thaneFightPos = 1;
            _pawnFightPos = 3;
         }
         else if(_thanePos == 7)
         {
            _pawnPos1 = 3;
            _pawnPos2 = 12;
            _childPos = 9;
            _slavedChildPos = 12;
            _monsterPos = 3;
            _thaneFightPos = 1;
            _pawnFightPos = 3;
         }
         else if(_thanePos == 6)
         {
            _pawnPos1 = 1;
            _pawnPos2 = 10;
            _childPos = 4;
            _slavedChildPos = 10;
            _monsterPos = 1;
            _thaneFightPos = 3;
            _pawnFightPos = 1;
         }
         else if(_thanePos == 9)
         {
            _pawnPos1 = 1;
            _pawnPos2 = 10;
            _childPos = 7;
            _slavedChildPos = 10;
            _monsterPos = 1;
            _thaneFightPos = 3;
            _pawnFightPos = 1;
         }
      }
      
      private function refreshView() : void
      {
         var _loc1_:LineUpFormationItem = null;
         _lastPosition = _currentPistion;
         _currentPistion = "";
         _loc1_ = getItemByPos(_thanePos);
         _loc1_.data = thane;
         _currentPistion += _thanePos + ",";
         if(child)
         {
            _loc1_ = getItemByPos(_childPos);
            _loc1_.data = child;
            _currentPistion += _childPos + ",";
         }
         if(childModel.getSlavedEnterWar() || enterWarMonster)
         {
            if(childModel.getSlavedEnterWar())
            {
               _loc1_ = getItemByPos(_slavedChildPos);
               _loc1_.data = childModel.getSlavedEnterWar();
               _currentPistion += _slavedChildPos + ",";
            }
            if(enterWarMonster)
            {
               _loc1_ = getItemByPos(_monsterPos);
               _loc1_.data = enterWarMonster;
               _currentPistion += _monsterPos + ",";
            }
         }
         else if(armyPawn && armyPawn.ownPawns != 0)
         {
            _loc1_ = getItemByPos(_pawnPos1);
            _loc1_.data = armyPawn;
            _loc1_ = getItemByPos(_pawnPos2);
            _loc1_.data = armyPawn;
            _currentPistion += _pawnPos1 + ",";
            _currentPistion += _pawnPos2 + ",";
         }
      }
      
      private function refreshHeroState() : void
      {
         var _loc1_:LineUpFormationItem = null;
         _loc1_ = getItemByPos(_thanePos);
         _loc1_.refreshHeroState();
      }
      
      private function cleanItemView() : void
      {
         for each(var _loc1_:LineUpFormationItem in _bottoms)
         {
            if(_loc1_.data)
            {
               _loc1_.data = null;
            }
         }
      }
      
      private function get child() : ChildData
      {
         return ChildManager.instance.model.getEnterWar();
      }
      
      private function get userArmy() : UserArmy
      {
         return ArmyManager.instance.army;
      }
      
      private function get thane() : ThaneInfo
      {
         return userArmy.baseHero;
      }
      
      private function get dragonTalkerModel() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      private function get armyPawn() : ArmyPawn
      {
         return userArmy.armyPawns[0];
      }
      
      private function get childModel() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      private function get enterWarMonster() : MonsterInfo
      {
         return MonsterManager.instance.model.enterWarMonster;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_armyBg)
         {
            ObjectUtils.disposeObject(_armyBg);
         }
         _armyBg = null;
         if(_fontBtn1)
         {
            ObjectUtils.disposeObject(_fontBtn1);
         }
         _fontBtn1 = null;
         if(_fontBtn2)
         {
            ObjectUtils.disposeObject(_fontBtn2);
         }
         _fontBtn2 = null;
         if(_backBtn1)
         {
            ObjectUtils.disposeObject(_backBtn1);
         }
         _backBtn1 = null;
         if(_backBtn2)
         {
            ObjectUtils.disposeObject(_backBtn2);
         }
         _backBtn2 = null;
         if(_leftView)
         {
            ObjectUtils.disposeObject(_leftView);
         }
         _leftView = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

