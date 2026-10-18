package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.MinosNodeTempInfo;
   
   public class MinosNodeCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      public function MinosNodeCate(param1:XMLList)
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
               _loc2_ = _loc1_.@Id;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,MinosNodeTempInfo);
               }
            }
         }
         _loc2_ = null;
      }
      
      public function getDiffTempBy(param1:int, param2:int, param3:int, param4:int) : MinosNodeTempInfo
      {
         for each(var _loc5_:MinosNodeTempInfo in _dic)
         {
            if(_loc5_.ForLevel == param1 && _loc5_.NodeId == param2 && _loc5_.NodeType == param3 && _loc5_.NodeGrade == param4)
            {
               return _loc5_;
            }
         }
         return null;
      }
      
      public function getTemplateByID(param1:int) : MinosNodeTempInfo
      {
         return _dic["" + param1];
      }
   }
}

