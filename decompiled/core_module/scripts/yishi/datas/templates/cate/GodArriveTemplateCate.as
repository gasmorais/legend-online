package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.GodArriveData;
   
   public class GodArriveTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      private var _leng40002:int;
      
      public function GodArriveTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplates() : Dictionary
      {
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               if(!_dic[String(_loc1_.@Id)])
               {
                  _dic[String(_loc1_.@Id)] = createNode(_loc1_,GodArriveData,_tempXml);
                  if(int(_loc1_.@CampaignId) == 40002)
                  {
                     _leng40002 = _leng40002 + 1;
                  }
               }
            }
         }
         return _dic;
      }
      
      public function getGodArriveData(param1:int, param2:int) : GodArriveData
      {
         getTemplates();
         for each(var _loc3_:GodArriveData in _dic)
         {
            if(_loc3_.CampaignId == param1 && _loc3_.Param1 == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getGodArriveLen() : int
      {
         getTemplates();
         return _leng40002;
      }
   }
}

