package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.NewFirstPlayInfo;
   
   public class NewFirstPlayCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function NewFirstPlayCate(param1:XMLList)
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
               _loc2_ = _loc1_.@Id + "";
               _dic[_loc2_] = createNode(_loc1_,NewFirstPlayInfo,_tempXml) as NewFirstPlayInfo;
            }
         }
         _list = null;
      }
      
      public function getTemplate(param1:int, param2:int, param3:int, param4:int) : NewFirstPlayInfo
      {
         var _loc5_:NewFirstPlayInfo = null;
         for each(var _loc6_:NewFirstPlayInfo in _dic)
         {
            if(_loc6_.PayQuality == param3 && _loc6_.Jobs == param2 && _loc6_.Gender == param1 && _loc6_.Time == param4)
            {
               _loc5_ = _loc6_;
               break;
            }
         }
         return _loc5_;
      }
   }
}

