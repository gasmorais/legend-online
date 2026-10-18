package yishi.datas.templates.cate
{
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.utils.StringHelper;
   
   public class RapidThroughRewardTemplate
   {
      
      public var Ranking:String;
      
      public var TemplateId:String;
      
      public var Count:int;
      
      public var rankingString:String = "";
      
      private var _rewardArray:Array = [];
      
      public var rewardInfo:Array = [];
      
      public function RapidThroughRewardTemplate()
      {
         super();
      }
      
      public function refereshReward(param1:int, param2:int) : void
      {
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.templateId = param1;
         _loc3_.count = param2;
         rewardInfo.push(_loc3_);
         rewardInfo.sortOn("templateId",0x10 | 2);
      }
      
      public function get rewardArray() : Array
      {
         var _loc1_:int = 0;
         if(_rewardArray.length > 0)
         {
            return _rewardArray;
         }
         _loc1_ = 0;
         while(_loc1_ < rewardInfo.length)
         {
            if(rewardInfo[_loc1_].templateInfo)
            {
               _rewardArray.push(StringHelper.format("{0}*<font face=\'Arial\'>{1}</font>",rewardInfo[_loc1_].templateInfo.TemplateName,rewardInfo[_loc1_].count));
            }
            _loc1_++;
         }
         return _rewardArray;
      }
      
      public function initRanking() : void
      {
         var _loc1_:Array = this.Ranking.split(",");
         Ranking = _loc1_[0];
         if(_loc1_.length == 1)
         {
            rankingString = _loc1_[0];
         }
         else
         {
            rankingString = _loc1_[0] + "~" + _loc1_[1];
         }
         rankingString = LanguageMgr.GetTranslation("raipthrough.rewardRank",rankingString);
      }
   }
}

