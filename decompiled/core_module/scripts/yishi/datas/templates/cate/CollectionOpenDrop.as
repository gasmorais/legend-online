package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.CommonDropTempInfo;
   
   public class CollectionOpenDrop extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function CollectionOpenDrop(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         initTemplates();
      }
      
      public function initTemplates() : void
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@id + "";
               _dic[_loc2_] = createNode(_loc1_,CommonDropTempInfo,_tempXml) as CommonDropTempInfo;
            }
         }
         _list = null;
      }
      
      public function getDropGoods() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:CommonDropTempInfo in _dic)
         {
            _loc1_.push(_loc2_);
         }
         _loc1_.sortOn("itemId");
         return _loc1_;
      }
      
      public function getDropitemGoods(param1:int) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         for each(var _loc5_:CommonDropTempInfo in _dic)
         {
            if(_loc5_.dropId == param1)
            {
               _loc3_.push(_loc5_);
            }
         }
         loop1:
         for each(_loc5_ in _dic)
         {
            var _loc9_:int = 0;
            var _loc8_:Array = _loc3_;
            do
            {
               for each(var _loc4_:CommonDropTempInfo in _loc8_)
               {
               }
               continue loop1;
            }
            while(_loc5_.dropId != _loc4_.itemId);
            _loc2_.push(_loc5_);
         }
         _loc2_.sortOn(["itemId","count"],[2,2]);
         return _loc2_;
      }
   }
}

