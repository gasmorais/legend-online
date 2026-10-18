package petchallenge.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.PetChallengeManager;
   import mvc.module.petchallenge.PetChallengeModel;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.cate.PetChallengeRewardCate;
   import yishi.datas.templates.cate.PetChallengeRewardTemplate;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class PetChallengeInfoView extends Component
   {
      
      private var back:MutipleImage;
      
      private var petTypeContiner:Component;
      
      private var lookRewardBtn:TextButton;
      
      private var rankText:FilterFrameText;
      
      private var groupLabel:FilterFrameText;
      
      private var nextScoreText:FilterFrameText;
      
      private var goodsReward:HBox;
      
      private var _tipView:PetChallengeWeekRewardTipView;
      
      private var pointList:Vector.<PetChallengeResiPointView>;
      
      private var intervalScore:int;
      
      private var groupId:int;
      
      private var rewardObj:Object = {};
      
      private var groupTextArr:Array;
      
      public function PetChallengeInfoView()
      {
         super();
         initView();
         initTypesView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("PetChallengeInfoView.back");
         lookRewardBtn = ComponentFactory.Instance.creatComponentByStylename("PetChallengeInfoView.lookRewardBtn");
         petTypeContiner = ComponentFactory.Instance.creatComponentByStylename("PetChallengeInfoView.petTypeContiner");
         rankText = ComponentFactory.Instance.creatComponentByStylename("PetChallengeInfoView.rankText");
         groupLabel = ComponentFactory.Instance.creatComponentByStylename("PetChallengeInfoView.groupLabel");
         nextScoreText = ComponentFactory.Instance.creatComponentByStylename("PetChallengeInfoView.nextScoreText");
         goodsReward = ComponentFactory.Instance.creatComponentByStylename("PetChallengeInfoView.goodsReward");
         addChild(back);
         addChild(lookRewardBtn);
         addChild(petTypeContiner);
         addChild(rankText);
         addChild(groupLabel);
         addChild(nextScoreText);
         addChild(goodsReward);
         lookRewardBtn.text = LanguageMgr.GetTranslation("PetChallengeInfoView.lookReward");
         groupTextArr = LanguageMgr.GetTranslation("PetChallengeInfoView.groupLabel.textArr").split("|");
      }
      
      private function initTypesView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PetChallengeResiPointView = null;
         pointList = new Vector.<PetChallengeResiPointView>();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = new PetChallengeResiPointView(_loc2_ + 1);
            _loc1_.x = _loc2_ % 3 * 100;
            _loc1_.y = int(_loc2_ / 3) * 35;
            petTypeContiner.addChild(_loc1_);
            pointList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         model.addEventListener(PetChallengeModel.CHALLENGE_INFO_CHAGNE,__refreshHandler);
         lookRewardBtn.addEventListener("mouseDown",__lookRewardHandler);
      }
      
      private function removeEvent() : void
      {
         if(model)
         {
            model.removeEventListener(PetChallengeModel.CHALLENGE_INFO_CHAGNE,__refreshHandler);
         }
         if(lookRewardBtn)
         {
            lookRewardBtn.removeEventListener("mouseDown",__lookRewardHandler);
         }
      }
      
      private function __refreshHandler(param1:Event) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc4_:BaseItemView = null;
         var _loc8_:GoodsInfo = null;
         if(!model.selfInfo)
         {
            return;
         }
         groupId = model.getGroupIdByRankAndScore(model.selfInfo.ranking,model.selfInfo.score);
         if(model.selfInfo.ranking > 0)
         {
            rankText.text = LanguageMgr.GetTranslation("steel.view.ranklists.SteelRankListFrame.RankTxt01",model.selfInfo.ranking);
         }
         else
         {
            rankText.text = LanguageMgr.GetTranslation("areslords.RankFrame.str05");
         }
         groupLabel.text = groupTextArr[groupId - 1] + " " + model.selfInfo.score;
         groupLabel.setFrame(groupId);
         var _loc5_:int = int(model.getGroupIdByRankAndScore(model.selfInfo.ranking,model.selfInfo.score,false));
         if(_loc5_ >= 3)
         {
            intervalScore = model.groupArr[6 - _loc5_] - model.selfInfo.score;
            nextScoreText.htmlText = LanguageMgr.GetTranslation("PetChallengeInfoView.nextScoreText.text",groupTextArr[_loc5_ - 2],intervalScore);
         }
         else
         {
            nextScoreText.htmlText = "";
         }
         _loc6_ = 0;
         while(_loc6_ < pointList.length)
         {
            pointList[_loc6_].refreshView();
            _loc6_++;
         }
         var _loc1_:PetChallengeRewardCate = TempleteManager.instance.petChallengeRewardCate;
         var _loc7_:Array = _loc1_.getWeekRankingReward(model.selfInfo);
         var _loc3_:Array = [];
         _loc7_.sortOn(["TemplateId"],[16]);
         goodsReward.removeAllChild();
         for each(_loc2_ in _loc7_)
         {
            if(_loc2_.RewardType == 1)
            {
               _loc3_.push(_loc2_);
            }
         }
         if(_loc3_.length > 0)
         {
            for each(_loc2_ in _loc3_)
            {
               _loc4_ = rewardObj[_loc2_.TemplateId];
               if(!_loc4_)
               {
                  _loc4_ = ComponentFactory.Instance.creatCustomObject("PetChallengeInfoView.rewardItemView");
                  rewardObj[_loc2_.TemplateId] = _loc4_;
               }
               _loc8_ = new GoodsInfo();
               _loc8_.templateId = _loc2_.TemplateId;
               _loc8_.count = _loc2_.Count;
               _loc4_.data = _loc8_;
               goodsReward.addChild(_loc4_);
            }
         }
      }
      
      private function __lookRewardHandler(param1:MouseEvent) : void
      {
         if(_tipView && !_tipView.isDie)
         {
            ObjectUtils.disposeObject(_tipView);
            _tipView = null;
            return;
         }
         _tipView = new PetChallengeWeekRewardTipView();
         var _loc2_:Point = new Point();
         _loc2_ = lookRewardBtn.localToGlobal(_loc2_);
         _tipView.x = _loc2_.x - _tipView.displayWidth - 10;
         _tipView.y = _loc2_.y - 254;
         if(_tipView.y < 0)
         {
            _tipView.y = 20;
         }
         _tipView.show();
         param1.stopPropagation();
      }
      
      private function get model() : PetChallengeModel
      {
         return PetChallengeManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(rankText);
         rankText = null;
         ObjectUtils.disposeObject(groupLabel);
         groupLabel = null;
         ObjectUtils.disposeObject(nextScoreText);
         nextScoreText = null;
         ObjectUtils.disposeObject(lookRewardBtn);
         lookRewardBtn = null;
         ObjectUtils.disposeObject(goodsReward);
         goodsReward = null;
         ObjectUtils.disposeObject(_tipView);
         _tipView = null;
         ObjectUtils.disposeObject(petTypeContiner);
         petTypeContiner = null;
         if(rewardObj)
         {
            for(var _loc1_:String in rewardObj)
            {
               ObjectUtils.disposeObject(rewardObj[_loc1_]);
               rewardObj[_loc1_] = null;
            }
            rewardObj = null;
         }
         LogicUtils.disposeDisplayCollection(pointList);
         pointList = null;
         groupTextArr = null;
         super.dispose();
      }
   }
}

