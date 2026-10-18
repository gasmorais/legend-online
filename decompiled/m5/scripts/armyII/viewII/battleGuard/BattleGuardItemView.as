package armyII.viewII.battleGuard
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.GlowFilter;
   import yishi.datas.playerinfo.BattleGuardSocketInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.TempleteManager;
   
   public class BattleGuardItemView extends Component
   {
      
      private var _data:BattleGuardSocketInfo;
      
      private var _btn:DisplayObject;
      
      private var _uiFilter:UIFilter = new UIFilter();
      
      private var _maskShape:DisplayObject;
      
      private var _lockImg:Bitmap;
      
      private var _downFilters:Array;
      
      private var _overFilter:Array;
      
      private var _pos:int;
      
      private var _thaneInfo:ThaneInfo;
      
      private var isActived:Boolean = false;
      
      private var _selected:Boolean;
      
      private var _state:int;
      
      public function BattleGuardItemView(param1:int, param2:ThaneInfo)
      {
         _thaneInfo = param2;
         _pos = param1;
         var _loc3_:ColorMatrixFilter = new ColorMatrixFilter();
         _loc3_.matrix = [1.59,-0.33,-0.04,0,-3.65,-0.17,1.4,0,0,3.65,-0.17,-0.33,1.7,0,-3.65,0,0,0,1,0];
         var _loc4_:GlowFilter = new GlowFilter(16776960,1,10,10,2,3);
         var _loc5_:GlowFilter = new GlowFilter(16724736,1,16,16,2,1);
         _downFilters = [_loc3_,_loc4_,_loc5_];
         _overFilter = [_loc3_];
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:Shape = null;
         _btn = ComponentFactory.Instance.creat("asset.battleguard.Item0" + _pos);
         addChild(_btn);
         _lockImg = ComponentFactory.Instance.creatBitmap("asset.battleguard.LockImg");
         if(_pos == 7)
         {
            _loc1_ = new Shape();
            _loc1_.graphics.beginFill(0,0.5);
            _loc1_.graphics.drawRect(0,0,60,60);
            _loc1_.graphics.endFill();
            _maskShape = _loc1_;
            _maskShape.x = 1;
            _maskShape.y = 1;
            if(_lockImg)
            {
               _lockImg.x = 19;
               _lockImg.y = 15;
            }
         }
         else
         {
            _maskShape = ComponentFactory.Instance.creat("asset.battleguard.ItemMask");
            _maskShape.x = 9;
            _maskShape.y = 8;
            if(_lockImg)
            {
               _lockImg.x = 27;
               _lockImg.y = 20;
            }
         }
         this.height = _btn.height;
         this.width = _btn.width;
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_maskShape);
         _maskShape = null;
         ObjectUtils.disposeObject(_lockImg);
         _lockImg = null;
      }
      
      public function get data() : BattleGuardSocketInfo
      {
         return _data;
      }
      
      public function set data(param1:BattleGuardSocketInfo) : void
      {
         _data = param1;
         if(_data)
         {
            refresh();
         }
         tipData = data;
         if(param1)
         {
            addEvent();
         }
         else
         {
            removeEvent();
         }
      }
      
      public function refresh() : void
      {
         var _loc1_:Array = null;
         var _loc3_:UpgradeTemplateInfo = null;
         if(_data.state == 0)
         {
            _loc1_ = TempleteManager.instance.getTemplatesByType(28);
            for each(var _loc2_:UpgradeTemplateInfo in _loc1_)
            {
               if(_loc2_.ActiveObject == _pos)
               {
                  _loc3_ = _loc2_;
                  break;
               }
            }
            if(!_loc3_ || _thaneInfo.grades < _loc3_.Grades)
            {
               _uiFilter.setGrayFilter(this);
            }
            else
            {
               if(_maskShape)
               {
                  addChild(_maskShape);
               }
               if(_lockImg)
               {
                  addChild(_lockImg);
               }
            }
            isActived = false;
         }
         else
         {
            if(_maskShape && _maskShape.parent)
            {
               _maskShape.parent.removeChild(_maskShape);
            }
            if(_lockImg && _lockImg.parent)
            {
               _lockImg.parent.removeChild(_lockImg);
            }
            _uiFilter.setNormalFilter(this);
            isActived = true;
         }
      }
      
      private function addEvent() : void
      {
         this.addEventListener("mouseOver",__mouseOverHandler);
         this.addEventListener("mouseOut",__mouseOutHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("mouseOver",__mouseOverHandler);
         this.removeEventListener("mouseOut",__mouseOutHandler);
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         if(selected)
         {
            return;
         }
         if(!isActived)
         {
            return;
         }
         _btn.filters = _overFilter;
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         if(selected)
         {
            return;
         }
         if(!isActived)
         {
            return;
         }
         _btn.filters = null;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         if(!_btn)
         {
            return;
         }
         if(param1)
         {
            _btn.filters = _downFilters;
         }
         else
         {
            _btn.filters = [];
         }
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         _state = param1;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         super.dispose();
      }
   }
}

