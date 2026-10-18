package yishi.view.tips
{
   import flash.utils.Dictionary;
   
   public class MultipleDictionaryInfo
   {
      
      private var _data:Vector.<Dictionary>;
      
      public function MultipleDictionaryInfo()
      {
         super();
         _data = new Vector.<Dictionary>();
      }
      
      public function addItem(param1:String, param2:String) : void
      {
         var _loc3_:Dictionary = new Dictionary(true);
         _loc3_[param1] = param2;
         _data.push(_loc3_);
      }
      
      public function addItemAt(param1:String, param2:String, param3:int = 0) : void
      {
         var _loc4_:Dictionary = new Dictionary(true);
         _loc4_[param1] = param2;
         _data.unshift(_loc4_);
      }
      
      public function get data() : Vector.<Dictionary>
      {
         return _data;
      }
   }
}

