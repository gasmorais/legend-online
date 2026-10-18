package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.RondamBossTemplateInfo;
   
   public class RondamBossTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function RondamBossTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      private function initDic() : void
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@TemplateId;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,RondamBossTemplateInfo);
               }
            }
         }
      }
      
      public function getTemplatesById(param1:int) : RondamBossTemplateInfo
      {
         var _loc2_:XML = null;
         initDic();
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@SkillId == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,RondamBossTemplateInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
   }
}

