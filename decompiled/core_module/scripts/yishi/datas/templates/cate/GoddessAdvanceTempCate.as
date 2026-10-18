package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.GoddessAdvaceTempInfo;
   
   public class GoddessAdvanceTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function GoddessAdvanceTempCate(param1:XMLList)
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
               _dic[_loc2_] = createNode(_loc1_,GoddessAdvaceTempInfo,_tempXml) as GoddessAdvaceTempInfo;
            }
         }
         _list = null;
      }
      
      public function getTemplete(param1:int, param2:int) : GoddessAdvaceTempInfo
      {
         var _loc3_:String = param1 + "_" + param2;
         return _dic[_loc3_];
      }
   }
}

