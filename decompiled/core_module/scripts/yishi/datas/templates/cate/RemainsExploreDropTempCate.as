package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.CommonDropTempInfo;
   
   public class RemainsExploreDropTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function RemainsExploreDropTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@id;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,CommonDropTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
      
      public function getInfoByArray(param1:Array) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:Array = [];
         var _loc6_:Dictionary = getTemplates();
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = int(param1[_loc3_]);
            for each(var _loc4_:CommonDropTempInfo in _loc6_)
            {
               if(_loc4_.dropId == _loc2_)
               {
                  _loc5_.push(_loc4_);
               }
            }
            _loc3_++;
         }
         return _loc5_;
      }
   }
}

