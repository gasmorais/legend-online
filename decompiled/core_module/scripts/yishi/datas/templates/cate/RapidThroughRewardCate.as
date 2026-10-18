package yishi.datas.templates.cate
{
   import mvc.module.rapidThrough.RapidThroughModel;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.SimpleDictionary;
   
   public class RapidThroughRewardCate extends TemplateCate
   {
      
      private var _dic:SimpleDictionary;
      
      private var _tempXml:XML;
      
      public function RapidThroughRewardCate(param1:XMLList)
      {
         super(param1);
         _dic = new SimpleDictionary();
      }
      
      public function getTemplates() : SimpleDictionary
      {
         var _loc3_:String = null;
         var _loc2_:Array = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc3_ = _loc1_.@Ranking;
               _loc2_ = _loc3_.split(",");
               _loc3_ = _loc2_[0];
               if(!_dic[_loc3_])
               {
                  _dic[_loc3_] = createNode(_loc1_,RapidThroughRewardTemplate,_tempXml) as RapidThroughRewardTemplate;
                  _dic[_loc3_].initRanking();
                  _dic[_loc3_].refereshReward(_loc1_.@TemplateId,_loc1_.@Count);
               }
               else
               {
                  _dic[_loc3_].refereshReward(_loc1_.@TemplateId,_loc1_.@Count);
               }
            }
         }
         _list = null;
         return _dic;
      }
      
      private function get model() : RapidThroughModel
      {
         return FrameControllerManager.instance.rapidThroughController.model;
      }
   }
}

