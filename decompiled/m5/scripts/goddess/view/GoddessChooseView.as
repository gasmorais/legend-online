package goddess.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import goddess.item.GoddessSelectItem;
   import managers.GodDessManager;
   import mvc.module.goddess.GodDessModel;
   import mvc.module.goddess.GoddessInfo;
   
   public class GoddessChooseView extends Component
   {
      
      private var _vbox:VBox;
      
      private var _list:Vector.<GoddessSelectItem>;
      
      private const MAX:int = 5;
      
      public function GoddessChooseView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:GoddessSelectItem = null;
         var _loc2_:int = 0;
         _vbox = ComponentFactory.Instance.creatCustomObject("ui.goddess.choose.vbox");
         addChild(_vbox);
         _list = new Vector.<GoddessSelectItem>();
         _vbox.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new GoddessSelectItem();
            _loc1_.data = null;
            _list[_loc2_] = _loc1_;
            _vbox.addChild(_loc1_);
            _loc2_++;
         }
         _vbox.commitChanges();
      }
      
      public function refreshData(param1:Boolean = true) : void
      {
         var _loc3_:GoddessSelectItem = null;
         var _loc5_:int = 0;
         var _loc2_:Array = model.sortInfos;
         var _loc4_:int = int(_loc2_.length);
         _loc5_ = 0;
         while(_loc5_ < 5)
         {
            _loc3_ = _list[_loc5_];
            if(_loc5_ <= _loc4_ - 1)
            {
               if(_loc5_ == 0 && param1)
               {
                  model.selectInfo = _loc2_[_loc5_];
               }
               _loc3_.data = _loc2_[_loc5_];
            }
            else
            {
               _loc3_.data = null;
            }
            _loc5_++;
         }
      }
      
      public function chooseChange(param1:GoddessInfo) : void
      {
         for each(var _loc2_:GoddessSelectItem in _list)
         {
            if(_loc2_.data == param1)
            {
               _loc2_.selected = true;
            }
            else
            {
               _loc2_.selected = false;
            }
         }
      }
      
      private function getSelectItemByInfo(param1:GoddessInfo) : GoddessSelectItem
      {
         for each(var _loc2_:GoddessSelectItem in _list)
         {
            if(_loc2_.data == param1 && param1 != null)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function levelChange(param1:GoddessInfo) : void
      {
         var _loc2_:GoddessSelectItem = getSelectItemByInfo(param1);
         if(_loc2_)
         {
            _loc2_.level = param1.grade;
         }
      }
      
      public function stepChange(param1:GoddessInfo) : void
      {
         var _loc2_:GoddessSelectItem = getSelectItemByInfo(param1);
         if(_loc2_)
         {
            _loc2_.quality = param1.advanceTempInfo.Quality;
         }
      }
      
      public function devoteChange(param1:GoddessInfo) : void
      {
         var _loc2_:GoddessSelectItem = getSelectItemByInfo(param1);
         if(_loc2_)
         {
            _loc2_.devote = param1.devote;
         }
      }
      
      public function fightChange(param1:GoddessInfo) : void
      {
         var _loc2_:GoddessSelectItem = getSelectItemByInfo(param1);
         if(_loc2_)
         {
            _loc2_.isFight = param1.isFight;
         }
      }
      
      private function get model() : GodDessModel
      {
         return GodDessManager.instance.model;
      }
      
      override public function dispose() : void
      {
         for each(var _loc1_:GoddessSelectItem in _list)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _list = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

