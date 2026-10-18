package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.CarnivalDailyChallengeTemplateInfo;
   
   public class CarnivalDailyChallengeTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      private var _isInit:Boolean;
      
      public function CarnivalDailyChallengeTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function initTemplates() : void
      {
         var _loc2_:String = null;
         _isInit = true;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = "" + _loc1_.@Id;
               _dic[_loc2_] = createNode(_loc1_,CarnivalDailyChallengeTemplateInfo,_tempXml) as CarnivalDailyChallengeTemplateInfo;
            }
         }
         _list = null;
      }
      
      public function getTempInfo(param1:int) : CarnivalDailyChallengeTemplateInfo
      {
         if(!_isInit)
         {
            initTemplates();
         }
         var _loc2_:String = "" + param1;
         return _dic[_loc2_];
      }
   }
}

