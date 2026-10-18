package yishi.view.community
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import mvc.module.armyII.ArmyPawn;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.ArmyManager;
   
   public class PawnTileList extends Sprite implements Disposeable
   {
      
      protected var _scroll:ScrollPanel;
      
      protected var _vbox:VBox;
      
      protected var _pawnList:Dictionary;
      
      protected var _filter:IFilterFormat;
      
      public function PawnTileList()
      {
         super();
         init();
         refreshView();
      }
      
      protected function init() : void
      {
         var _loc2_:DisplayObject = null;
         _filter = new UIFilter();
         _pawnList = new Dictionary();
         _vbox = new VBox();
         _scroll = ComponentFactory.Instance.creatComponentByStylename("casern.ScrollPanel");
         _scroll.beginChanges();
         _scroll.setView(_vbox);
         _scroll.vUnitIncrement = 30;
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
      
      public function refreshView() : void
      {
         var _loc2_:DisplayObject = null;
         var _loc1_:Array = ArmyManager.instance.casernPawnList.getList();
         _loc1_.sort(sortByNeedBuild);
         for each(var _loc3_:ArmyPawn in _loc1_)
         {
            _loc2_ = _pawnList[_loc3_.templateInfo.SonType];
            if(_loc2_)
            {
               _loc2_["data"] = _loc3_;
            }
         }
         _vbox.refreshChildPos();
         _scroll.invalidateViewport();
      }
      
      public function getRecruitPawnBtn(param1:int) : TextButton
      {
         return _pawnList[param1].recruitPawnBtn;
      }
      
      protected function sortByNeedBuild(param1:ArmyPawn, param2:ArmyPawn) : int
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
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         for(var _loc1_:String in _pawnList)
         {
            delete _pawnList[_loc1_];
         }
         _pawnList = null;
      }
   }
}

