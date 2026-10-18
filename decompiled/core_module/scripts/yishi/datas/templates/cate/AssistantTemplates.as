package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.AssistantTempInfo;
   
   public class AssistantTemplates extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function AssistantTemplates(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         getTemplates();
      }
      
      public function getTemplates() : Dictionary
      {
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               if(!_dic[_loc1_.@Id])
               {
                  _dic[_loc1_.@Id] = createNode(_loc1_,AssistantTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
      
      public function getallInfos() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:AssistantTempInfo in _dic)
         {
            _loc1_.push(_loc2_);
         }
         _loc1_.sortOn("Id");
         return _loc1_;
      }
      
      public function byNameGetInfo(param1:int) : AssistantTempInfo
      {
         for each(var _loc2_:AssistantTempInfo in _dic)
         {
            if(_loc2_.SonType == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

