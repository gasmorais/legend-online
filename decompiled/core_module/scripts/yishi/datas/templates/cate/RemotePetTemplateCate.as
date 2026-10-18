package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.RemotePetTurnTemplateInfo;
   
   public class RemotePetTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _group:Dictionary;
      
      private var _tempXml:XML;
      
      public function RemotePetTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         _group = new Dictionary();
      }
      
      public function getTemplates() : Dictionary
      {
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               if(!_dic[_loc1_.@Index + "_" + _loc1_.@Type])
               {
                  _dic[_loc1_.@Index + "_" + _loc1_.@Type] = createNode(_loc1_,RemotePetTurnTemplateInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
      
      public function getTemplateById(param1:int, param2:int) : RemotePetTurnTemplateInfo
      {
         var _loc4_:* = null;
         if(param1 <= 0)
         {
            return null;
         }
         if(!_dic[param1 + "_" + param2] && _list)
         {
            _loc4_ = _list.(@Index == param1 && @Type == param2);
            var _loc10_:int = 0;
            var _loc9_:* = _loc4_;
            for each(var _loc3_:XML in _loc9_)
            {
               _dic[_loc3_.@Index + "_" + _loc3_.@Type] = createNode(_loc3_,RemotePetTurnTemplateInfo,_tempXml);
            }
         }
         return _dic[param1 + "_" + param2];
      }
      
      public function getTemplateBySkillId(param1:int) : RemotePetTurnTemplateInfo
      {
         if(param1 <= 0)
         {
            return new RemotePetTurnTemplateInfo();
         }
         getTemplates();
         if(_dic)
         {
            for each(var _loc2_:RemotePetTurnTemplateInfo in _dic)
            {
               if(_loc2_.Skill == param1)
               {
                  return _loc2_;
               }
            }
         }
         return new RemotePetTurnTemplateInfo();
      }
   }
}

