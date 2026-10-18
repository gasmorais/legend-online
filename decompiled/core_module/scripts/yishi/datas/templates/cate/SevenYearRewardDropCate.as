package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.SevenYearRewardDropTemplate;
   import yishi.utils.SimpleDictionary;
   
   public class SevenYearRewardDropCate extends TemplateCate
   {
      
      private var _dic:SimpleDictionary;
      
      private var _tempXml:XML;
      
      private var rewardGradeDic:Dictionary;
      
      public function SevenYearRewardDropCate(param1:XMLList)
      {
         super(param1);
         _dic = new SimpleDictionary();
         rewardGradeDic = new Dictionary();
         initTemplates();
      }
      
      public function initTemplates() : void
      {
         var _loc2_:SevenYearRewardDropTemplate = null;
         var _loc3_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc3_ = _loc1_.@site;
               if(!_dic[_loc3_])
               {
                  _dic[_loc3_] = [];
               }
               _loc2_ = createNode(_loc1_,SevenYearRewardDropTemplate,_tempXml) as SevenYearRewardDropTemplate;
               if(rewardGradeDic[_loc2_.itemId] == null)
               {
                  rewardGradeDic[_loc2_.itemId] = [];
               }
               rewardGradeDic[_loc2_.itemId].push(_loc3_);
               _dic[_loc3_].push(_loc2_);
            }
         }
         _list = null;
      }
      
      public function getTemplatesByGrade(param1:int) : Array
      {
         return _dic[param1];
      }
      
      public function getTemplates() : SimpleDictionary
      {
         return _dic;
      }
      
      public function getTemplatesByItemId(param1:int) : Array
      {
         return rewardGradeDic[param1];
      }
   }
}

