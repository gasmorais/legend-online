package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.MonsterExploreTempInfo;
   
   public class MonsterExploreTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function MonsterExploreTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByChapterAndNode(param1:int, param2:int) : MonsterExploreTempInfo
      {
         var _loc4_:* = null;
         var _loc3_:XML = null;
         if(param1 == 0 || param2 == 0)
         {
            return null;
         }
         var _loc5_:String = param1 + "_" + param2;
         if(_list)
         {
            if(!_dic[_loc5_])
            {
               _loc3_ = _list.(@ChapterId == param1 && @NodeId == param2)[0];
               if(_loc3_)
               {
                  _dic[_loc5_] = createNode(_loc3_,MonsterExploreTempInfo,_tempXml);
               }
            }
         }
         return _dic[_loc5_];
      }
      
      public function getTemplates() : Dictionary
      {
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               if(!_dic[_loc1_.@ChapterId + "_" + _loc1_.@NodeId])
               {
                  _dic[_loc1_.@ChapterId + "_" + _loc1_.@NodeId] = createNode(_loc1_,MonsterExploreTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
   }
}

