package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.CommonDropTempInfo;
   
   public class EnchantTalismanSkillDropTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function EnchantTalismanSkillDropTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         initTemplates();
      }
      
      public function initTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@site + "_" + _loc1_.@para2;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = [];
               }
               _dic[_loc2_].push(createNode(_loc1_,CommonDropTempInfo,_tempXml));
            }
         }
         _list = null;
         return _dic;
      }
      
      public function getTemplates(param1:String) : Array
      {
         return _dic[param1];
      }
   }
}

