package goddess.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import goddess.item.GoddessEquipCell;
   import manager.LanguageMgr;
   import mvc.module.goddess.GoddessEquipInfo;
   import mvc.module.goddess.GoddessInfo;
   import yishi.datas.templates.GoddessEquipTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   
   public class GoddessEquipView extends Component
   {
      
      private var _equipSuits:Vector.<Image>;
      
      private var _equipCells:Vector.<GoddessEquipCell>;
      
      private var _data:GoddessInfo;
      
      private var _gray:Array;
      
      private const SUIT_MAX:int = 4;
      
      private const EQUIP_MAX:int = 4;
      
      public function GoddessEquipView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _gray = [UIFilter.getGrayFilter()];
         var _loc1_:int = 0;
         _equipSuits = new Vector.<Image>();
         _loc1_ = 1;
         while(_loc1_ <= 4)
         {
            _equipSuits[_loc1_ - 1] = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.equipSuit" + _loc1_);
            addChild(_equipSuits[_loc1_ - 1]);
            _loc1_++;
         }
         _equipCells = new Vector.<GoddessEquipCell>();
         _loc1_ = 1;
         while(_loc1_ <= 4)
         {
            _equipCells[_loc1_ - 1] = ComponentFactory.Instance.creatCustomObject("ui.goddess.equipCell" + _loc1_);
            _equipCells[_loc1_ - 1].buttonMode = true;
            addChild(_equipCells[_loc1_ - 1]);
            _loc1_++;
         }
      }
      
      private function initEvent() : void
      {
         for each(var _loc1_:GoddessEquipCell in _equipCells)
         {
            _loc1_.addEventListener("click",equipClickHandler);
         }
      }
      
      private function removeEvent() : void
      {
         for each(var _loc1_:GoddessEquipCell in _equipCells)
         {
            _loc1_.removeEventListener("click",equipClickHandler);
         }
      }
      
      private function equipClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:GoddessEquipCell = param1.currentTarget as GoddessEquipCell;
         var _loc3_:int = _equipCells.indexOf(_loc2_);
         selectIndex = _loc3_ + 1;
         MsgMan.notifyObserver("EVENT_CHANGE_EQUIP",_loc2_.data);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:Image in _equipSuits)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _equipSuits = null;
         for each(var _loc2_:GoddessEquipCell in _equipCells)
         {
            ObjectUtils.disposeObject(_loc2_);
         }
         _equipCells = null;
         super.dispose();
         _gray = null;
      }
      
      public function get data() : GoddessInfo
      {
         return _data;
      }
      
      public function set data(param1:GoddessInfo) : void
      {
         var _loc2_:int = 0;
         _data = param1;
         if(_data)
         {
            _loc2_ = 0;
            _loc2_ = 1;
            while(_loc2_ <= 4)
            {
               refreshEquipInfo(_equipCells[_loc2_ - 1],_loc2_);
               _loc2_++;
            }
            _loc2_ = 1;
            while(_loc2_ <= 4)
            {
               refreshSuit(_equipSuits[_loc2_ - 1],_loc2_);
               _loc2_++;
            }
         }
      }
      
      public function set selectIndex(param1:int) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 1;
         while(_loc2_ <= 4)
         {
            if(_loc2_ == param1)
            {
               _equipCells[_loc2_ - 1].selected = true;
            }
            else
            {
               _equipCells[_loc2_ - 1].selected = false;
            }
            _loc2_++;
         }
      }
      
      private function refreshEquipInfo(param1:GoddessEquipCell, param2:int) : void
      {
         var _loc3_:GoddessEquipInfo = _data.equips[param2];
         param1.data = _loc3_;
      }
      
      private function refreshSuit(param1:Image, param2:int) : void
      {
         var _loc3_:GoddessEquipInfo = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc12_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc11_:GoddessEquipTempInfo = TempleteManager.instance.goddessEquipTempCate.getSuitTempInfo(3,param2);
         if(!_loc11_)
         {
            return;
         }
         var _loc13_:int = 0;
         _loc5_ = 1;
         while(_loc5_ <= 4)
         {
            _loc3_ = _data.equips[_loc5_];
            if(_loc3_ && _loc3_.equipStrengthenLevel >= _loc11_.Grade)
            {
               _loc13_++;
            }
            _loc5_++;
         }
         var _loc7_:Array = _loc11_.getKeyValues();
         var _loc4_:String = "";
         var _loc10_:int = int(_loc7_.length);
         _loc6_ = 0;
         while(_loc6_ < _loc10_)
         {
            if(_loc6_ < _loc10_ - 1)
            {
               _loc4_ += _loc7_[_loc6_][1] + "  +" + _loc7_[_loc6_][0] + "\n";
            }
            else
            {
               _loc4_ += _loc7_[_loc6_][1] + "  +" + _loc7_[_loc6_][0];
            }
            _loc6_++;
         }
         if(_loc13_ >= 4)
         {
            _loc8_ = "#e9c68c";
            _loc9_ = "#59cd41";
            param1.filters = null;
            param1.alpha = 1;
         }
         else
         {
            _loc8_ = "#ff0000";
            _loc9_ = "#7d7d7d";
            param1.filters = _gray;
            param1.alpha = 0.6;
         }
         _loc12_ = LanguageMgr.GetTranslation("goddess.equip.suitTitle",_loc8_,_loc11_.Grade,_loc9_,_loc4_);
         param1.tipData = _loc12_;
      }
   }
}

