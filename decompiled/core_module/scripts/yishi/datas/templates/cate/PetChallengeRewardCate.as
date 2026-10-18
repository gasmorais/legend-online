package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.PetChallengeManager;
   import mvc.module.petchallenge.PetChallengeModel;
   import mvc.module.petchallenge.PetChallengeObjectData;
   
   public final class PetChallengeRewardCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      private var _weekRewards:Array;
      
      public function PetChallengeRewardCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         initData();
      }
      
      private function initData() : void
      {
         var _loc1_:PetChallengeRewardTemplate = null;
         var _loc4_:int = 0;
         var _loc2_:Array = LanguageMgr.GetTranslation("PetChallengeRewardTemplate.allAddValue").split(",");
         var _loc3_:Array = LanguageMgr.GetTranslation("PetChallengeRewardTemplate.allAppellValue").split(",");
         _loc4_ = 1;
         while(_loc4_ <= 3)
         {
            _loc1_ = new PetChallengeRewardTemplate();
            _loc1_.RewardType = 2;
            _loc1_.Type = 2;
            _loc1_.Ranking = "2|" + _loc4_;
            _loc1_.TemplateId = 9999999;
            _loc1_.parseReward();
            _loc1_.rewardName = LanguageMgr.GetTranslation("PetChallengeRewardTemplate.allAdd",_loc2_[_loc4_]);
            _dic[_loc1_] = _loc1_;
            _loc1_ = new PetChallengeRewardTemplate();
            _loc1_.RewardType = 3;
            _loc1_.Type = 2;
            _loc1_.Ranking = "2|" + _loc4_;
            _loc1_.TemplateId = int(_loc3_[_loc4_]);
            _loc1_.parseReward();
            _dic[_loc1_] = _loc1_;
            _loc4_++;
         }
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:PetChallengeRewardTemplate = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               if(!_dic[String(_loc1_.@TemplateId)])
               {
                  _loc2_ = createNode(_loc1_,PetChallengeRewardTemplate,_tempXml) as PetChallengeRewardTemplate;
                  _loc2_.parseReward();
                  _dic[_loc2_] = _loc2_;
               }
            }
         }
         return _dic;
      }
      
      public function getRewardsByGroup(param1:int) : Array
      {
         if(param1 > 6 || param1 < 2)
         {
            return null;
         }
         var _loc3_:Array = [];
         getTemplates();
         for each(var _loc2_:PetChallengeRewardTemplate in _dic)
         {
            if(_loc2_.Type == 2 && _loc2_.groupId == param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         _loc3_.sortOn(["RewardType","TemplateId"],[0x10 | 2,16]);
         return _loc3_;
      }
      
      public function get weekRewards() : Array
      {
         if(!_weekRewards)
         {
            _weekRewards = [];
            getTemplates();
            for each(var _loc1_:PetChallengeRewardTemplate in _dic)
            {
               if(_loc1_.Type == 2)
               {
                  _weekRewards.push(_loc1_);
               }
            }
            _weekRewards.sortOn(["RewardType","TemplateId"],[0x10 | 2,16]);
         }
         return _weekRewards;
      }
      
      public function getWeekRankingReward(param1:PetChallengeObjectData) : Array
      {
         var _loc4_:Array = [];
         var _loc3_:int = model.getGroupIdByScore(param1.score);
         for each(var _loc2_:PetChallengeRewardTemplate in weekRewards)
         {
            if(_loc2_.min <= param1.ranking && param1.ranking <= _loc2_.max && _loc3_ == _loc2_.groupId)
            {
               _loc4_.push(_loc2_);
            }
         }
         return _loc4_;
      }
      
      private function get model() : PetChallengeModel
      {
         return PetChallengeManager.instance.model;
      }
   }
}

