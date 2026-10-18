package mvc.module.store
{
   import flash.events.EventDispatcher;
   import yishi.datas.templates.ComposeGoodsTemplete;
   import yishi.manager.TempleteManager;
   
   public class ComposeGoodsInfo extends EventDispatcher
   {
      
      public var cellType:int;
      
      private var _groupId:int;
      
      public var selected:Boolean;
      
      public var templateId:int;
      
      private var _ownCount1:int;
      
      private var _ownCount2:int;
      
      private var _ownCount3:int;
      
      private var _ownCount4:int;
      
      private var _canMakeCount1:int;
      
      private var _canMakeCount2:int;
      
      private var _canMakeCount3:int;
      
      private var _canMakeCount4:int;
      
      private var _canMakeCount:int;
      
      public function ComposeGoodsInfo()
      {
         super();
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function set groupId(param1:int) : void
      {
         _groupId = param1;
      }
      
      public function get template() : ComposeGoodsTemplete
      {
         return TempleteManager.instance.getComposeTempleteById(templateId);
      }
      
      public function get ownCount1() : int
      {
         return _ownCount1;
      }
      
      public function set ownCount1(param1:int) : void
      {
         _ownCount1 = param1;
         _canMakeCount1 = _ownCount1 / template.Count1;
      }
      
      public function get ownCount2() : int
      {
         return _ownCount2;
      }
      
      public function set ownCount2(param1:int) : void
      {
         _ownCount2 = param1;
         _canMakeCount2 = template.Count2 > 0 ? _ownCount2 / template.Count2 : _ownCount2;
      }
      
      public function get ownCount3() : int
      {
         return _ownCount3;
      }
      
      public function set ownCount3(param1:int) : void
      {
         _ownCount3 = param1;
         _canMakeCount3 = template.Count3 > 0 ? _ownCount3 / template.Count3 : _ownCount3;
      }
      
      public function get ownCount4() : int
      {
         return _ownCount4;
      }
      
      public function set ownCount4(param1:int) : void
      {
         _ownCount4 = param1;
         _canMakeCount4 = template.Count4 > 0 ? _ownCount4 / template.Count4 : _ownCount4;
      }
      
      public function getCanMakeCount() : int
      {
         var _loc1_:int = 2147483647;
         if(template.Material1 > 0)
         {
            _loc1_ = int(_canMakeCount1 <= 0 ? 0 : _canMakeCount1);
         }
         if(template.Material2 > 0)
         {
            _loc1_ = _canMakeCount2 < _loc1_ ? _canMakeCount2 : _loc1_;
         }
         if(template.Material3 > 0)
         {
            _loc1_ = _canMakeCount3 < _loc1_ ? _canMakeCount3 : _loc1_;
         }
         if(template.Material4 > 0)
         {
            _loc1_ = _canMakeCount4 < _loc1_ ? _canMakeCount4 : _loc1_;
         }
         if(_loc1_ == 2147483647)
         {
            throw new Error("模板有问题，该公式不需要任何材料");
         }
         return _loc1_;
      }
      
      public function get canMakeCount() : int
      {
         return _canMakeCount;
      }
      
      public function set canMakeCount(param1:int) : void
      {
         _canMakeCount = param1;
      }
   }
}

