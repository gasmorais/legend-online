package armyII.viewII.allocate
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.armyII.ArmyPawn;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.DragManager;
   
   public class SortPawnFrame extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _helpTxt:FilterFrameText;
      
      private var _pawnCellList:Vector.<PawnSortCell>;
      
      public function SortPawnFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PawnSortCell = null;
         escEnable = true;
         titleText = LanguageMgr.GetTranslation("armyII.viewII.allocate.AllocateView.sort");
         _pawnCellList = new Vector.<PawnSortCell>();
         _bg = ComponentFactory.Instance.creatComponentByStylename("army.SortPawnBg");
         _helpTxt = ComponentFactory.Instance.creatComponentByStylename("armyII.SortPawnHelpTxt");
         _helpTxt.text = LanguageMgr.GetTranslation("armyII.viewII.allocate.SortPawnFrame.help");
         addToContent(_bg);
         addToContent(_helpTxt);
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("army.PawnSortCell" + (_loc2_ + 1));
            _loc1_.backTxt.setFrame(_loc2_ + 1);
            _loc1_.pos = _loc2_ + 1;
            _pawnCellList.push(_loc1_);
            addToContent(_loc1_);
            _loc2_++;
         }
         if(thane.fightPos >= 1)
         {
            _pawnCellList[thane.fightPos - 1].hero = thane;
         }
         if(armyPawn.fightPos >= 1)
         {
            _pawnCellList[armyPawn.fightPos - 1].pawn = armyPawn;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__responseHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         dispose();
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get armyPawn() : ArmyPawn
      {
         return ArmyManager.instance.army.armyPawns[0];
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         DragManager.getInstance().stopDrag();
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         _bg = null;
         _helpTxt = null;
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _pawnCellList[_loc1_] = null;
            _loc1_++;
         }
         _pawnCellList = null;
         super.dispose();
         ChildManager.instance.openChildFram();
      }
   }
}

