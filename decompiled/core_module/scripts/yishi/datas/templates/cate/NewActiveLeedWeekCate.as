package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.CommonDropTempInfo;
   import yishi.utils.SimpleDictionary;
   
   public class NewActiveLeedWeekCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function NewActiveLeedWeekCate(param1:XMLList)
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
      
      public function getDropGoods(param1:int) : SimpleDictionary
      {
         var _loc2_:SimpleDictionary = new SimpleDictionary();
         for each(var _loc3_:CommonDropTempInfo in _dic)
         {
            if(int(_loc3_.para2) == param1)
            {
               if(!_loc2_[_loc3_.site])
               {
                  _loc2_[_loc3_.site] = [];
               }
               _loc2_[_loc3_.site].push(_loc3_);
            }
         }
         return _loc2_;
      }
   }
}

