package armyII.viewII.allocate
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import flash.display.DisplayObject;
   import flash.utils.Dictionary;
   import mvc.module.armyII.ArmyPawn;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.view.community.PawnTileList;
   
   public class RecruitPawnTileList extends PawnTileList
   {
      
      public function RecruitPawnTileList()
      {
         super();
      }
      
      override protected function init() : void
      {
         var _loc2_:DisplayObject = null;
         _filter = new UIFilter();
         _pawnList = new Dictionary(true);
         _vbox = new VBox();
         _scroll = ComponentFactory.Instance.creatComponentByStylename("army.RecruitScrollPanel");
         _scroll.beginChanges();
         _scroll.setView(_vbox);
         _scroll.commitChanges();
         addChild(_scroll);
         var _loc1_:Array = ArmyManager.instance.casernPawnList.getList();
         _loc1_.sort(sortByNeedBuild);
         for each(var _loc3_:ArmyPawn in _loc1_)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("core.RecruitPawnCell");
            _loc2_["data"] = _loc3_;
            _vbox.addChild(_loc2_);
            _pawnList[_loc3_.templateInfo.SonType] = _loc2_;
         }
         _vbox.refreshChildPos();
         _scroll.invalidateViewport();
      }
      
      override public function refreshView() : void
      {
         var _loc2_:Array = null;
         var _loc1_:ArmyPawn = null;
         super.refreshView();
         var _loc3_:ArmyPawn = ArmyManager.instance.army.getPawnByIndex(0);
         if(_loc3_ && _loc3_.templateInfo)
         {
            _loc2_ = ArmyManager.instance.casernPawnList.getList();
            _loc2_.sort(sortByNeedBuild);
            _loc1_ = ArmyManager.instance.casernPawnList[_loc3_.templateInfo.SonType];
            _scroll.vScrollbar.scrollValue = _loc2_.indexOf(_loc1_) * 70;
         }
      }
   }
}

