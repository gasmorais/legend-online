package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import mvc.module.dayGuide.LeadRewardTempInfo;
   
   public class DayGuideDropTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function DayGuideDropTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplatesByPos(param1:int) : LeadRewardTempInfo
      {
         var _loc2_:XML = null;
         if(!_dic[param1])
         {
            _loc2_ = _list.(@index == param1)[0];
            if(_loc2_)
            {
               _dic[param1] = createNode(_loc2_,LeadRewardTempInfo,_tempXml);
            }
         }
         return _dic[param1] as LeadRewardTempInfo;
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@templateId;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,LeadRewardTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
   }
}

