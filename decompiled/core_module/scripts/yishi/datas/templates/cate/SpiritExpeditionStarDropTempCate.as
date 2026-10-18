package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.CommonDropTempInfo;
   
   public class SpiritExpeditionStarDropTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function SpiritExpeditionStarDropTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:CommonDropTempInfo = null;
         var _loc3_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc3_ = _loc1_.@site;
               if(!_dic[_loc3_])
               {
                  _dic[_loc3_] = [];
               }
               _loc2_ = createNode(_loc1_,CommonDropTempInfo,_tempXml) as CommonDropTempInfo;
               _dic[_loc3_].push(_loc2_);
            }
         }
         return _dic;
      }
   }
}

