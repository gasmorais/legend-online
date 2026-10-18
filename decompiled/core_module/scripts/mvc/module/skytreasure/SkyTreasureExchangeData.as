package mvc.module.skytreasure
{
   import com.road.yishi.proto.cccactive.ExchangeItemPB;
   import com.road.yishi.proto.cccactive.SkyTreasureExchangeActivePB;
   
   public class SkyTreasureExchangeData
   {
      
      private var _activeId:String;
      
      private var _items:Array;
      
      public function SkyTreasureExchangeData(param1:SkyTreasureExchangeActivePB)
      {
         super();
         _activeId = param1.activeId;
         _items = [];
         for each(var _loc2_:ExchangeItemPB in param1.items)
         {
            _items.push(new SkyTreasureExchangeTemplateData(_loc2_.activeId,_loc2_.templateId,_loc2_.exchangeTimes));
         }
      }
      
      public function get actId() : String
      {
         return _activeId;
      }
      
      public function get items() : Array
      {
         return _items;
      }
      
      public function updateAllItemData(param1:Array) : void
      {
         for each(var _loc2_:Object in param1)
         {
            updateExchangeNum(_loc2_);
         }
      }
      
      public function updateExchangeNum(param1:Object) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:SkyTreasureExchangeTemplateData = findExchangeInfo(param1.activeId,param1.templateId);
         if(_loc2_)
         {
            _loc2_.updateExchangeNum(param1.exchangeTimes);
         }
         else
         {
            _items.push(new SkyTreasureExchangeTemplateData(param1.activeId,param1.templateId,param1.exchangeTimes));
         }
      }
      
      private function findExchangeInfo(param1:String, param2:int) : SkyTreasureExchangeTemplateData
      {
         for each(var _loc3_:SkyTreasureExchangeTemplateData in _items)
         {
            if(_loc3_.actId == param1 && _loc3_.templateId == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function findTempExchangeNum(param1:int) : int
      {
         for each(var _loc2_:SkyTreasureExchangeTemplateData in _items)
         {
            if(_loc2_.templateId == param1)
            {
               return _loc2_.exchangeNum;
            }
         }
         return 0;
      }
   }
}

