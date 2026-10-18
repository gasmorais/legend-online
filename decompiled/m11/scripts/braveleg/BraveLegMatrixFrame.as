package braveleg
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import events.ArmyEvent;
   import events.PawnEvent;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.ArmySocketOutManager;
   import managers.ChildManager;
   import mvc.module.armyII.ArmyPawn;
   import mvc.module.armyII.UserArmy;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.view.community.HeadIconCell;
   
   public class BraveLegMatrixFrame extends Frame implements IManualSize
   {
      
      private const FRONT_ROW_INDEX:int = 1;
      
      private const BACK_ROW_INDEX:int = 3;
      
      private var _matrixBg:Image;
      
      private var _matrixHead:HeadIconCell;
      
      private var _matrixFont1Btn:SelectedIconButton;
      
      private var _matrixFont2Btn:SelectedIconButton;
      
      private var _matrixBack1Btn:SelectedIconButton;
      
      private var _matrixBack2Btn:SelectedIconButton;
      
      private var _tabGroup:SelectedButtonGroup;
      
      private var _thanePos:int;
      
      private var _childPos:int;
      
      private var _slavedChildPos:int;
      
      private var _pawnPos1:int;
      
      private var _pawnPos2:int;
      
      private var _thaneFightPos:int;
      
      private var _pawnFightPos:int;
      
      private var _lastPosition:String;
      
      private var _currentPistion:String;
      
      private var heroPosArr:Array = [4,7,6,9];
      
      private var first:Boolean = false;
      
      public function BraveLegMatrixFrame()
      {
         super();
         initPos();
         initView();
         addEvent();
         updatePosAndView();
         _tabGroup.selectIndex = heroPosArr.indexOf(_thanePos);
         FrameControllerManager.instance.armyController.setOldData();
      }
      
      private function initView() : void
      {
         _matrixBg = ComponentFactory.Instance.creatComponentByStylename("braveleg.MatrixBg");
         _matrixHead = ComponentFactory.Instance.creatComponentByStylename("braveleg.MatrixHead");
         _matrixFont1Btn = ComponentFactory.Instance.creatComponentByStylename("braveleg.MatrixFontBtn");
         _matrixFont2Btn = ComponentFactory.Instance.creatComponentByStylename("braveleg.MatrixFontBtn");
         _matrixBack1Btn = ComponentFactory.Instance.creatComponentByStylename("braveleg.MatrixBackBtn");
         _matrixBack2Btn = ComponentFactory.Instance.creatComponentByStylename("braveleg.MatrixBackBtn");
         addToContent(_matrixBg);
         addToContent(_matrixHead);
         addToContent(_matrixFont1Btn);
         addToContent(_matrixFont2Btn);
         addToContent(_matrixBack1Btn);
         addToContent(_matrixBack2Btn);
         _matrixFont1Btn.visible = _matrixBack1Btn.visible = true;
         _matrixFont2Btn.visible = _matrixBack2Btn.visible = false;
         titleText = LanguageMgr.GetTranslation("braveleg.Matrix.Title");
         _matrixHead.type = "head";
         _matrixHead.headId = ArmyManager.instance.thane.snsInfo.headId;
         _tabGroup = new SelectedButtonGroup();
         _tabGroup.addSelectItem(_matrixFont1Btn);
         _tabGroup.addSelectItem(_matrixFont2Btn);
         _tabGroup.addSelectItem(_matrixBack1Btn);
         _tabGroup.addSelectItem(_matrixBack2Btn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         userArmy.addEventListener("ARMY_PAWN_CHANGE",__pawnChangeHandler);
         thane.addEventListener("THANE_INFO_UPDATE",__updateHandler);
         ArmyManager.instance.addEventListener("ARMY_PAWN_CHANGE",__pawnChangeHandler);
         _tabGroup.addEventListener("change",__updateHeroPosHandler);
         ArmyManager.instance.addEventListener("ENTERWAR_PAWN_SELECT",__updateEnterPawnHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         userArmy.removeEventListener("ARMY_PAWN_CHANGE",__pawnChangeHandler);
         thane.removeEventListener("THANE_INFO_UPDATE",__updateHandler);
         ArmyManager.instance.removeEventListener("ARMY_PAWN_CHANGE",__pawnChangeHandler);
         _tabGroup.removeEventListener("change",__updateHeroPosHandler);
         ArmyManager.instance.removeEventListener("ENTERWAR_PAWN_SELECT",__updateEnterPawnHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_matrixBg);
         _matrixBg = null;
         ObjectUtils.disposeObject(_matrixHead);
         _matrixHead = null;
         ObjectUtils.disposeObject(_matrixFont1Btn);
         _matrixFont1Btn = null;
         ObjectUtils.disposeObject(_matrixFont2Btn);
         _matrixFont2Btn = null;
         ObjectUtils.disposeObject(_matrixBack1Btn);
         _matrixBack1Btn = null;
         ObjectUtils.disposeObject(_matrixBack2Btn);
         _matrixBack2Btn = null;
         ObjectUtils.disposeObject(_tabGroup);
         _tabGroup = null;
         super.dispose();
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __updateHeroPosHandler(param1:Event) : void
      {
         if(!first)
         {
            first = true;
            return;
         }
         _thanePos = heroPosArr[_tabGroup.selectIndex];
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
      
      private function refreshView() : void
      {
         _lastPosition = _currentPistion;
         _currentPistion = "";
         _currentPistion += _thanePos + ",";
         if(child)
         {
            _currentPistion += _childPos + ",";
         }
         if(childModel.getSlavedEnterWar())
         {
            _currentPistion += _slavedChildPos + ",";
         }
         else if(armyPawn && armyPawn.ownPawns != 0)
         {
            _currentPistion += _pawnPos1 + ",";
            _currentPistion += _pawnPos2 + ",";
         }
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
            _thaneFightPos = 1;
            _pawnFightPos = 3;
         }
         else if(_thanePos == 7)
         {
            _pawnPos1 = 3;
            _pawnPos2 = 12;
            _childPos = 9;
            _slavedChildPos = 12;
            _thaneFightPos = 1;
            _pawnFightPos = 3;
         }
         else if(_thanePos == 6)
         {
            _pawnPos1 = 1;
            _pawnPos2 = 10;
            _childPos = 4;
            _slavedChildPos = 10;
            _thaneFightPos = 3;
            _pawnFightPos = 1;
         }
         else if(_thanePos == 9)
         {
            _pawnPos1 = 1;
            _pawnPos2 = 10;
            _childPos = 7;
            _slavedChildPos = 10;
            _thaneFightPos = 3;
            _pawnFightPos = 1;
         }
      }
      
      private function get userArmy() : UserArmy
      {
         return ArmyManager.instance.army;
      }
      
      private function get thane() : ThaneInfo
      {
         return userArmy.baseHero;
      }
      
      private function get armyPawn() : ArmyPawn
      {
         return userArmy.armyPawns[0];
      }
      
      private function get child() : ChildData
      {
         return ChildManager.instance.model.getEnterWar();
      }
      
      private function get childModel() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,350,195);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

