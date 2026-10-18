package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.ServenLeadRewardInfo;
   
   public class ServenLeadRewardTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function ServenLeadRewardTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         getTemplates();
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc3_:String = null;
         var _loc1_:Array = null;
         if(_list)
         {
            for each(var _loc2_:XML in _list)
            {
               _loc3_ = _loc2_.@Day;
               if(_dic[_loc3_])
               {
                  (_dic[_loc3_] as Array).push(createNode(_loc2_,ServenLeadRewardInfo,_tempXml));
               }
               else
               {
                  _loc1_ = [];
                  _loc1_.push(createNode(_loc2_,ServenLeadRewardInfo,_tempXml));
                  _dic[_loc3_] = _loc1_;
               }
            }
         }
         _loc3_ = null;
         return _dic;
      }
      
      public function getArrayByDay(param1:String) : Array
      {
         var _loc2_:Array = [];
         for(var _loc3_:String in _dic)
         {
            if(_loc3_ == param1)
            {
               _loc2_ = _dic[_loc3_];
               break;
            }
         }
         return _loc2_;
      }
   }
}

