package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.GoddessUpLevelTempInfo;
   
   public class GoddessLevelTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function GoddessLevelTempCate(param1:XMLList)
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
               _loc2_ = _loc1_.@Type + "_" + _loc1_.@Level;
               _dic[_loc2_] = createNode(_loc1_,GoddessUpLevelTempInfo,_tempXml) as GoddessUpLevelTempInfo;
            }
         }
         _list = null;
      }
      
      public function getTemplete(param1:int, param2:int) : GoddessUpLevelTempInfo
      {
         var _loc3_:String = param1 + "_" + param2;
         return _dic[_loc3_];
      }
   }
}

