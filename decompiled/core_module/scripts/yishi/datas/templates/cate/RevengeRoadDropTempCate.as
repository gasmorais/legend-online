package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.CommonDropTempInfo;
   
   public class RevengeRoadDropTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function RevengeRoadDropTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         getTemplates();
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
         _list = null;
         return _dic;
      }
      
      public function getDropsById(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:CommonDropTempInfo in _dic)
         {
            if(_loc3_.dropId == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
   }
}

