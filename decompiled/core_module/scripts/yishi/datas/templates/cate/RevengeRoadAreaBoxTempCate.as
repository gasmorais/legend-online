package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.CommonDropTempInfo;
   
   public class RevengeRoadAreaBoxTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function RevengeRoadAreaBoxTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         getTemplates();
      }
      
      public function getTemplatesAry(param1:int) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:String = "" + param1;
         for each(var _loc4_:CommonDropTempInfo in _dic)
         {
            if(_loc4_.para2 == _loc3_)
            {
               _loc2_.push(_loc4_);
            }
         }
         return _loc2_;
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
   }
}

