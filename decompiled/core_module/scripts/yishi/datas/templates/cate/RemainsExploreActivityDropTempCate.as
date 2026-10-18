package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.CommonDropTempInfo;
   
   public class RemainsExploreActivityDropTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function RemainsExploreActivityDropTempCate(param1:XMLList)
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
      
      public function getTemplatesByTypeIndex(param1:int, param2:int) : Array
      {
         var _loc5_:Array = [];
         var _loc6_:Dictionary = getTemplates();
         var _loc4_:String = param2.toString();
         for each(var _loc3_:CommonDropTempInfo in _loc6_)
         {
            if(_loc3_.site == param1 && _loc3_.para2 == _loc4_)
            {
               _loc5_.push(_loc3_);
            }
         }
         return _loc5_;
      }
   }
}

