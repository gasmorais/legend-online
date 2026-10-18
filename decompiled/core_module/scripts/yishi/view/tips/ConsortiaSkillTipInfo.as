package yishi.view.tips
{
   import flash.utils.Dictionary;
   
   public class ConsortiaSkillTipInfo
   {
      
      private var _data:Dictionary;
      
      private var _itemArr:Array = [];
      
      private var _explainArr:Array = [];
      
      private var _title:String;
      
      public function ConsortiaSkillTipInfo()
      {
         super();
         _data = new Dictionary();
         _data["itemArr"] = _itemArr;
         _data["explainArr"] = _explainArr;
      }
      
      public function addItem(param1:String) : void
      {
         if(param1 == null || param1 == "")
         {
            return;
         }
         _itemArr.push(param1);
      }
      
      public function addExplain(param1:String) : void
      {
         if(param1 == null || param1 == "")
         {
            return;
         }
         _explainArr.push(param1);
      }
      
      public function get data() : Dictionary
      {
         return _data;
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function set title(param1:String) : void
      {
         _title = param1;
         _data["title"] = param1;
      }
   }
}

