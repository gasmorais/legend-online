package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.GuildFBTempInfo;
   
   public class GuildFBTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function GuildFBTemplateCate(param1:XMLList)
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
               _loc2_ = _loc1_.@NodeId + "";
               _dic[_loc2_] = createNode(_loc1_,GuildFBTempInfo,_tempXml) as GuildFBTempInfo;
            }
         }
         _list = null;
      }
      
      public function getNodeById(param1:int) : GuildFBTempInfo
      {
         return _dic[param1 + ""];
      }
      
      public function getOneNode(param1:int, param2:int) : GuildFBTempInfo
      {
         for each(var _loc3_:GuildFBTempInfo in _dic)
         {
            if(_loc3_.AreaId == param1 && _loc3_.Difficulty == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getNodes(param1:int, param2:int) : Array
      {
         var _loc3_:Array = [];
         for each(var _loc4_:GuildFBTempInfo in _dic)
         {
            if(_loc4_.AreaId == param1 && _loc4_.Difficulty == param2)
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
   }
}

